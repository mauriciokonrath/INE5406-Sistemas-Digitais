LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity projeto is
generic (N : natural := 8);
port (
	clk, inicio, reset : IN STD_LOGIC;
   S : OUT SIGNED (N-1 DOWNTO 0);
   flag : OUT UNSIGNED(3 DOWNTO 0);
	pronto: out std_logic := '0');
end projeto;

architecture arch of projeto is
	component bc is
		PORT (clk , inicio, reset, prontoUla: IN STD_LOGIC;
		dado: IN SIGNED (3 DOWNTO 0);
      enA, enB, enOp, enOut, enPC, resetPC, pronto, iniciarUla: OUT STD_LOGIC);
	end component;
	
	component bo is
		generic (N : natural := 4 );
		PORT (clk : IN STD_LOGIC;
			  enA, enB, enOp, enOut, enPC, resetPC, iniciarUla: IN STD_LOGIC;
			  S: OUT SIGNED (N-1 DOWNTO 0);
				opcode: out signed (3 downto 0);
				pronto: OUT std_logic;
			  flag : OUT UNSIGNED(3 DOWNTO 0));
	end component;
	
	signal prontoUla, iniciarUla: std_logic := '0';
	signal resultado: signed(N-1 downto 0);
	signal opcode: signed(3 downto 0);
	signal enA, enB, enOp, enOut, enPC, resetPC, pronto_bc: std_logic;
	signal flagZ: unsigned(3 downto 0);
begin

	bc0: bc port map (clk, inicio, reset, prontoUla, opcode, enA, enB, enOp, enOut, enPC, resetPC, pronto_bc, iniciarUla);
	bo0: bo generic map (N) port map (clk, enA, enB, enOp, enOut, enPC, resetPC, iniciarUla, resultado, opcode, prontoUla, flagZ);
	
	flag <= flagZ;
	pronto <= pronto_bc;
	S <= resultado;

end arch;