library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplicador_booth is
	generic (N : integer := 8);
	port (A,B: in signed(N-1 downto 0);
			clk, start: in std_logic;
			pronto: out std_logic;
			S: out signed((2*N)-1 downto 0)
			);
end multiplicador_booth;

architecture comp of multiplicador_booth is
	signal var: std_logic := '0';
	signal var2: signed(N-1 downto 0) := (others => '0');
	signal Aout: signed(N downto 0);
	signal op: signed(N-1 downto 0);
	signal cnt: integer := N;
	signal eba: signed((2*N)-1 downto 0);
begin
	process(clk)
	variable Ain: signed(N downto 0);
	begin
		if ((clk'event) and (clk = '1')) then
			if start = '0' then
				var <= '0';
				var2 <= (others => '0');
				pronto <= '0';
				cnt <= N;
			else
				if cnt /= 0 then
					if (cnt = N) then
						Ain := A & '0';
					else
						Ain := shift_right(Ain,1);
						Ain(N) := op(0);
					end if;
					if Ain(1 downto 0) = "01" then
						op <= var2 + B;
						var2 <= shift_right(var2 + B, 1);
					elsif Ain(1 downto 0) = "10" then
						op <= var2 - B;
						var2 <= shift_right(var2 - B, 1);
					else
						op <= var2;
						var2 <= shift_right(var2, 1);
					end if;
					cnt <= cnt - 1;
					Aout <= Ain;
					var <= Ain(0);
					if cnt = 3 then
					pronto <= '1';
					end if;
				end if;
				
			end if;
		end if;
	end process;
	eba <= var2 & (op(0) & Aout(N downto 2));
	S <= eba;
end comp;