LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bo IS 
generic (N : natural := 4 );
PORT (clk : IN STD_LOGIC;
      enA, enB, enOp, enOut, enPC, resetPC, iniciarUla: IN STD_LOGIC;
      S: OUT SIGNED (N-1 DOWNTO 0);
		opcode: out signed (3 downto 0);
		pronto: OUT std_logic;
      flag : OUT UNSIGNED(3 DOWNTO 0));
	  
END bo;

ARCHITECTURE estrutura OF bo IS
	
	COMPONENT registrador IS
	generic (N: natural);
	PORT (clk, carga : IN STD_LOGIC;
		  d : IN SIGNED (N-1 DOWNTO 0);
		  q : OUT SIGNED(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT registrador_unsigned IS
	generic (N: natural);
	PORT (clk, carga : IN STD_LOGIC;
		  d : IN UNSIGNED (N-1 DOWNTO 0);
		  q : OUT UNSIGNED(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT Ula_mem IS
	generic(N: natural:= 4); 
	port
		(
			  clk: in std_logic;
			  iniciarUla: in std_logic;
			A, B: in SIGNED(N-1 downto 0);
			SEL: in SIGNED(3 downto 0);
			  overflow, negativo, zero, erro, pronto_ula: out STD_LOGIC := '0';
			S: out SIGNED(N-1 downto 0)
		);
	END COMPONENT;

	COMPONENT rom IS
	generic(
		data_bits: integer := 8;
		addr_bits: integer := 5;
		data_width: integer := 28
	);
	port(
		addr: in unsigned(addr_bits-1 downto 0);
		data: out signed(data_bits-1 downto 0)
	);
	END COMPONENT;

	COMPONENT registrador_PC IS
	generic (N : natural := 4 );
	PORT (clk, carga, reset: IN STD_LOGIC;
		  q : OUT UNSIGNED(N-1 DOWNTO 0));
	END COMPONENT;


	
SIGNAL sairegA, sairegB, sairegS, saiS: SIGNED (N-1 DOWNTO 0);
SIGNAL sairegPC: unsigned(4 downto 0);
SIGNAL sairegOp: SIGNED (3 DOWNTO 0);
SIGNAL flagZ, sairegFlag: UNSIGNED(3 downto 0);
SIGNAL flagoverflow, flagnegativo, flagzero, flagerro, pronto_ula: STD_LOGIC := '0';
SIGNAL dado: signed(7 downto 0);

BEGIN
	
	opcode <= dado(3 downto 0);
	regPC: registrador_PC generic map(5) PORT MAP (clk, enPC, resetPC, sairegPC);
	mem: rom PORT MAP(sairegPC, dado);
	regA: registrador generic map(N) PORT MAP (clk, enA, dado, sairegA);
	regB: registrador generic map(N) PORT MAP (clk, enB, dado, sairegB);
	regOp: registrador generic map(4) PORT MAP (clk, enOp, dado(3 downto 0), sairegOp); 
	regS: registrador generic map(N) PORT MAP (clk, enOut, saiS, sairegS);
	regFlag: registrador_unsigned generic map(4) PORT MAP (clk, enOut, flagZ, sairegFlag);
	
	flagZ <= flagoverflow & flagnegativo & flagzero & flagerro;
	
	ula0: Ula_mem generic map(N) PORT MAP (clk, iniciarUla, sairegA, sairegB, sairegOp, flagoverflow, flagnegativo, flagzero, flagerro, pronto_ula, saiS);
	

	S <= sairegS;
	flag <= sairegFlag;
	pronto <= pronto_ula;
	
END estrutura;