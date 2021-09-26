library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity raiz is
	generic (N : natural := 8);
   port (clk: in std_logic;
			A: in signed(N-1 downto 0);
			start: in std_logic := '0';
			neg, pronto: out std_logic := '0';
         S: out unsigned(N-1 downto 0));
end raiz;

architecture comp of raiz is
	signal inicio: std_logic := '1';
	signal S0: unsigned((N-1)/2 downto 0);
	signal zero: unsigned((N-1)/2 downto 0) := (others => '0'); 
begin
   process (clk, A)
		variable var1: unsigned(N-1 downto 0);
		variable var2: unsigned(N-1 downto 0);
		variable var3: unsigned(N-1 downto 0);
		variable teste: unsigned(N-1 downto 0);
		begin

			if ((clk'event) and (clk = '1')) then
				if start = '0' then
					inicio <= '1';
					pronto <= '0';
					neg <= '0';
				else
					if (A(N-1) = '1') then
						S <= (others => '0');
						neg <= '1';
						pronto <= '1';
					else
						if (inicio = '1') then
							var1 := unsigned(A);
							var2 := (others => '0');
							var3 := to_unsigned(2**(N-2),N);
							inicio <= '0';
						else
							if (var3 /= 0) then
								if (var1 < (var2 + var3)) then
									var2 := var2/2;
								else
									var1 := var1 - (var2 + var3);
									var2 := var2/2 + var3;						
								end if;
								var3 := var3/4;
							else
								pronto <= '1';
							end if;
						end if;
					S <= zero & var2((N-1)/2 downto 0);
					end if;
			end if;
		end if;
   end process;
end comp;