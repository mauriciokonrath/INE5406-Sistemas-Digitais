library ieee;
use ieee.std_logic_1164.all;

entity Somador_8bits is 

	port (A, B: in std_logic_vector(7 downto 0);
			cin: in std_logic;
			S: out std_logic_vector(7 downto 0);
			cout: out std_logic);
			
end Somador_8bits;

architecture comportamento of Somador_8bits is
	signal c1, c2, c3, c4, c5, c6, c7: std_logic;
	
	component somador_completo 
	port (a, b, cin: in std_logic;
			s, cout: out std_logic);
	end component;


	
begin
	
	SC0: somador_completo 
			port map( a => A(0), b => B(0), cin => cin, 
						s => S(0), cout => c1);
	
	SC1: somador_completo 
			port map( a => A(1), b => B(1), cin => c1, 
						s => S(1), cout => c2);
	
	SC2: somador_completo 
			port map( a => A(2), b => B(2), cin => c2, 
						s => S(2), cout => c3);
						
	SC3: somador_completo 
			port map( a => A(3), b => B(3), cin => c3, 
						s => S(3), cout => c4);
	
	SC4: somador_completo 
			port map( a => A(4), b => B(4), cin => c4, 
						s => S(4), cout => c5);
	
	SC5: somador_completo 
			port map( a => A(5), b => B(5), cin => c5, 
						s => S(5), cout => c6);
	
	SC6: somador_completo 
			port map( a => A(6), b => B(6), cin => c6, 
						s => S(6), cout => c7);
						
	SC7: somador_completo 
			port map( a => A(7), b => B(7), cin => c7, 
						s => S(7), cout => cout);

end comportamento;