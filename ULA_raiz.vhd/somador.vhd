LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity somador is
    generic(N: natural := 8);
    Port (
        a, b: in signed(N-1 downto 0);
        sel: in std_logic;
        sum: out signed(N-1 downto 0);
        overflow: out std_logic
    );
end somador;

architecture arch of somador is
    signal sa, sb, ssum: signed(N downto 0);

begin
    sa <= resize(signed(a), N+1);
    sb <= resize(signed(b), N+1);

    ssum <= sa + sb when sel = '1' else sa - sb;
    overflow <= '1' when ssum(N-1) /= ssum(N) else '0';

    sum <= ssum(N-1 downto 0);

end arch;