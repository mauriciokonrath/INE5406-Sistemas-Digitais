LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY registrador_unsigned IS
generic (N : natural := 3 );
PORT (clk, carga : IN STD_LOGIC;
	  d : IN UNSIGNED(N-1 DOWNTO 0);
	  q : OUT UNSIGNED(N-1 DOWNTO 0));
END registrador_unsigned;

ARCHITECTURE estrutura OF registrador_unsigned IS
BEGIN
	PROCESS(clk)
	BEGIN
		IF (clk'EVENT AND clk = '1' AND carga = '1') THEN
			q <= d;
		END IF;
	END PROCESS;
END estrutura;