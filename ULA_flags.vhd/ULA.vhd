library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Ula is
generic(N: natural:= 4); 
port
	(
		A, B: in SIGNED(N-1 downto 0);
		SEL: in STD_LOGIC_VECTOR(1 downto 0);
		overflow: out STD_LOGIC;
		negativo: out STD_LOGIC; 
		zero: out STD_LOGIC;
		S: out SIGNED(N-1 downto 0)
	);
end Ula;

architecture estrutura of Ula is
signal OUTPUT, SigA, SigB: SIGNED(N-1 downto 0);
signal tempS: signed(N-1 downto 0);

begin
	
	process(SEL,A, B) is
		begin	
			
			if SEL = "00" then
				SigA <= A;
				SigB <= B;
				OUTPUT <= SigA + SigB;
				
				
			elsif SEL = "01" then
				SigA <= A;
				SigB <= B;
				OUTPUT <= SigA - SigB;
			
			elsif SEL = "10" then
				SigA <= A;
				SigB <= B;
				OUTPUT <= SigA and SigB;
				
			else
				SigA <= A;
				SigB <= B;
				OUTPUT <= SigA or SigB;
				
			end if;	
			
		
			if OUTPUT < "0000" then
				negativo <= '1';
			else
				negativo <= '0';
					
			end if;
			
			
			if (OUTPUT = "0000") then
				zero <= '1';
			else
				zero <= '0';
					
			end if;

		
		end process;
	overflow <= (A(N-1) and B(N-1) and (not OUTPUT(N-1))) or (not OUTPUT(N-1) and (not B(N-1)) and  OUTPUT(N-1));
	S <= OUTPUT;

end estrutura;

