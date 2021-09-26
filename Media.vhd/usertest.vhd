library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity usertest is
end usertest;

architecture tb of usertest is
	signal a, b, c, d: std_logic_vector(3 downto 0);
	signal aprovado, rec, reprovado: std_logic;
	
	component media
		port(
				a, b, c, d: in std_logic_vector(3 downto 0);
				aprovado, rec, reprovado: out std_logic
		);
	end component;
	
begin

	MD: media port map (a, b, c, d, aprovado, rec, reprovado);
    process
     constant period: time := 20 ns;
     begin
		a <= "1010"; b <= "0010"; c <= "1010"; d <= "0001";
		wait for period;
		a <= "0101"; b <= "0110"; c <= "0101"; d <= "1001";
		wait for period;
		a <= "0010"; b <= "0100"; c <= "0001"; d <= "0001";
		wait;
    end process;
end tb;