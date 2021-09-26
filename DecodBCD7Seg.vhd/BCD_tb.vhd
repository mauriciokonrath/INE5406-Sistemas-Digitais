library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BCD_tb is
end BCD_tb;

architecture tb of BCD_tb is
	signal bcd_in: std_Logic_Vector(3 downto 0);
	signal seven_seg: std_Logic_Vector(6 downto 0);
	
	component BCD
		port(
			bcd_in: in std_Logic_Vector(3 downto 0);
			seven_seg: out std_Logic_Vector(6 downto 0)
			);
	end component;
	
begin

		MD: BCD port map (bcd_in, seven_seg);
    process
     constant period: time := 20 ns;
     begin
		bcd_in <= "0000"; --0
		wait for period;
		bcd_in <= "0001"; --1 
		wait for period;
		bcd_in <= "0010"; --2
		wait for period;
		bcd_in <= "0011"; --3 
		wait for period;
		bcd_in <= "0100"; --4 
		wait for period;
		bcd_in <= "0101"; --5
		wait for period;
		bcd_in <= "0110"; --6 
		wait for period;
		bcd_in <= "0111"; --7 
		wait for period;
		bcd_in <= "1000"; --8
		wait for period;
		bcd_in <= "1001"; --9 
		wait for period;
		bcd_in <= "1010"; --10 
		wait for period;
		bcd_in <= "1011"; --11
		wait for period;
		bcd_in <= "1100"; --12
		wait for period;
		bcd_in <= "1101"; --13
		wait for period;
		bcd_in <= "1110"; --14
		wait for period;
		bcd_in <= "1111"; --15		
		wait;
    end process;
end tb;