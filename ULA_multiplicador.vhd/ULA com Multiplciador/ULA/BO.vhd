LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bo IS 
generic (N : natural := 4 );
PORT (clk : IN STD_LOGIC;
      enA, enB, enOp, enOut : IN STD_LOGIC;
      dado : IN SIGNED(N-1 DOWNTO 0);
      S : OUT SIGNED (N-1 DOWNTO 0);
      flag : OUT UNSIGNED(2 DOWNTO 0));
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
	
	COMPONENT ULA IS
	generic (N: natural);
	PORT (
		A, B: in SIGNED(N-1 downto 0);
		SEL: in SIGNED(2 downto 0);
		overflow: out STD_LOGIC;
		negativo: out STD_LOGIC; 
		zero: out STD_LOGIC;
		S: out SIGNED(N-1 downto 0)
		);
	END COMPONENT;
	
SIGNAL sairegA, sairegB, sairegS, saiS : SIGNED (N-1 DOWNTO 0);
SIGNAL sairegOp: SIGNED ( 2 DOWNTO 0);
SIGNAL flagZ, sairegFlag: UNSIGNED(2 downto 0);
SIGNAL flagoverflow, flagnegativo, flagzero: STD_LOGIC;

BEGIN
	
	regA: registrador generic map(N) PORT MAP (clk, enA, dado, sairegA);
	regB: registrador generic map(N) PORT MAP (clk, enB, dado, sairegB);
	regOp: registrador generic map(3) PORT MAP (clk, enOp, dado(2 downto 0), sairegOp); 
	regS: registrador generic map(N) PORT MAP (clk, enOut, saiS, sairegS);
	regFlag: registrador_unsigned generic map(3) PORT MAP (clk, enOut, flagZ, sairegFlag);
	
	flagZ <= flagoverflow & flagnegativo & flagzero;
	
	ula0: ULA generic map(N) PORT MAP (sairegA, sairegB, sairegOp, flagoverflow, flagnegativo, flagzero, saiS);
	

	S <= sairegS;
	flag <= sairegFlag;
	
END estrutura;