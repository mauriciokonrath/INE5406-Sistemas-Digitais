LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY t1 IS 
generic (N : natural := 4 );
PORT (clk, inicio, reset : IN STD_LOGIC;
      dado : IN SIGNED(N-1 DOWNTO 0);
      S : OUT SIGNED (N-1 DOWNTO 0);
      flag : OUT UNSIGNED(2 DOWNTO 0));
END t1;

ARCHITECTURE estrutura OF t1 IS
	
	component bc is
	port (
		clk , inicio, reset: IN STD_LOGIC;
      enA, enB, enOp, enOut : OUT STD_LOGIC
	);
	end component;
	
	component bo is
	generic (N: natural := 4);
	port (
		clk : IN STD_LOGIC;
      enA, enB, enOp, enOut : IN STD_LOGIC;
      dado : IN SIGNED(N-1 DOWNTO 0);
      S : OUT SIGNED (N-1 DOWNTO 0);
      flag : OUT UNSIGNED(2 DOWNTO 0)
	);
	end component;
	
	signal enableA, enableB, enableOp, enableOut: std_logic;

BEGIN

	bc0: bc port map (clk, inicio, reset, enableA, enableB, enableOp, enableOut);
	bo0: bo generic map(N) port map (clk, enableA, enableB, enableOp, enableOut, dado, S, flag);
	
END estrutura;