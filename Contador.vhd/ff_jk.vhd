library IEEE;
use IEEE.std_logic_1164.all;

entity ff_jk is
    port (
            j, k, clk: in std_logic;
            Q, notQ: out std_logic
        );
end ff_jk;

architecture bhv of ff_jk is

signal jk: std_logic_vector(1 downto 0);
signal regQ: std_logic := '1';

begin
    jk <= j & k;

    process (clk)
    begin
        if clk'event and clk = '1' then
            case jk is
                when "00" => regQ <= regQ;
                when "10" => regQ <= '1';
                when "11"  => regQ <= not(regQ);
					 when others => regQ <= '0';
            end case;
        end if;
    end process;
	 Q <= regQ;
	 notQ <= not(regQ);
end bhv;