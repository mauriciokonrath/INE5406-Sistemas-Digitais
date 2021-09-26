LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY registrador IS
generic (N : natural := 4 );
PORT (clk, carga : IN STD_LOGIC;
	  d : IN SIGNED(N-1 DOWNTO 0);
	  q : OUT SIGNED(N-1 DOWNTO 0));
END registrador;

ARCHITECTURE estrutura OF registrador IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1' AND carga = '1') THEN
			q <= d;
		END IF;
	END PROCESS;
END estrutura;