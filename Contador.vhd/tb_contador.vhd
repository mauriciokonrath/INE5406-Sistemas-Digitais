library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_contador is
end tb_contador;

architecture tb of tb_contador is
    signal clk : std_logic;
    signal s : std_logic_vector(3 downto 0);
begin
    -- conectando os sinais do test bench aos sinais do contador
    UUT : entity work.contador port map(clk, s);
	 
	 -- processo gerador de clock
	 tb1 : process
        constant periodo: time := 20 ns; -- periodo do clock
        begin
				clk <= '1';
            wait for periodo/2; -- 50% do periodo pra cada nivel
				clk <= '0';
				wait for periodo/2;
        end process;
end tb;