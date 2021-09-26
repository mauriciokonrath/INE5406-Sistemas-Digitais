LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY registrador_PC IS
generic (N : natural := 4 );
PORT (clk, carga, reset: IN STD_LOGIC;
      q : OUT UNSIGNED(N-1 DOWNTO 0));
END registrador_PC;

ARCHITECTURE estrutura OF registrador_PC IS
signal cnt: unsigned(N-1 downto 0) := (others => '0');
BEGIN
    q <= cnt;
    PROCESS(clk, reset)
    BEGIN
        IF (reset = '1') THEN
            cnt <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (carga = '1') THEN
                cnt <= cnt + 1;
            END IF;
        END IF;
    END PROCESS;
END estrutura;