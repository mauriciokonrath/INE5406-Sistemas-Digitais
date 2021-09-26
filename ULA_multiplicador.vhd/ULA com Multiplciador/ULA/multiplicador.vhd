library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplicador is
	generic (N : integer := 4);
	port (A,B: in signed(N-1 downto 0);
			S: out signed((2*N)-1 downto 0)
			);
end multiplicador;

architecture comp of multiplicador is
begin

	process(A,B)
		variable array_out: signed(2*N + 1 downto 0);
		
	begin
		array_out := (others => '0');

		if (A /= 0 and B /= 0) then
			array_out(N downto 1) := B;
			for i in 1 to N loop
				if (array_out(1 downto 0) = "01") then
					array_out(2*N + 1 downto N+1) := array_out(2*N + 1 downto N+1) + A;
				elsif (array_out(1 downto 0) = "10") then
					array_out(2*N + 1 downto N+1) := array_out(2*N + 1 downto N+1) - A;
				end if;
				array_out(2*N downto 0) := array_out(2*N + 1 downto 1);
			end loop;
		end if;
		S <= array_out(2*N downto 1);
	end process;
end comp;