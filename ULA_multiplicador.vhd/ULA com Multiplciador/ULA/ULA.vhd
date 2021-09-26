library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Ula is
generic(N: natural:= 4); 
port
	(
		A, B: in SIGNED(N-1 downto 0);
		SEL: in SIGNED(2 downto 0);
		overflow, negativo, zero: out STD_LOGIC := '0';
		S: out SIGNED(N-1 downto 0)
	);
end Ula;

architecture estrutura of Ula is

COMPONENT multiplicador IS
	generic (N: natural);
	port (A,B: in signed(N-1 downto 0);
			S: out signed((2*N)-1 downto 0)
			);
	END COMPONENT;
	
signal OUTPUT, soma, subt: SIGNED(N-1 downto 0);
signal saimult: signed(2*N-1 downto 0);
signal um: signed(N downto 0):= (others => '1');

begin
	
	mult: multiplicador generic map(N) PORT MAP (A, B, saimult);
	soma <= A + B; 
	subt <= A - B;
	
	
	with SEL select
    OUTPUT <= 	soma when "000",
					subt when "001",
					(A and B) when "010",
					(A or B) when "011",
					saimult(N-1 downto 0)  when others;
					
	 
	 
	process(OUTPUT) is
		begin			
			if SEL = 0 then				
				overflow <= (A(N-1) and B(N-1) and (not OUTPUT(N-1))) or ((not OUTPUT(N-1)) and (not B(N-1)) and  OUTPUT(N-1));
				
			elsif SEL = 1 then				
				overflow <= (A(N-1) and B(N-1) and (not OUTPUT(N-1))) or ((not OUTPUT(N-1)) and (not B(N-1)) and  OUTPUT(N-1));
			
			elsif SEL = 2 then				
				overflow <= '0';
				
			elsif SEL = 3 then
				overflow <='0';
				
			else
				if (saimult(2*N-1 downto N-1) = 0) or (saimult(2*N-1 downto N-1) = um) then
					overflow <= '0';
				
				else
					overflow <= '1';	
				end if;				
			end if;	
	end process;
		
	process(OUTPUT) is
	begin
		if OUTPUT < 0 then
			negativo <= '1';
		else
			negativo <= '0';				
		end if;
			
		if (OUTPUT = 0) then
			zero <= '1';
		else
			zero <= '0';				
		end if;
	end process;
	
	S <= OUTPUT;

end estrutura;