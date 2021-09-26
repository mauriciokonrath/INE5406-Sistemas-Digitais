
library ieee;
use ieee.std_logic_1164.all;

entity somador_completo is
	port (a, b, cin: in std_logic;
			s, cout: out std_logic);
			
end somador_completo;

architecture comportamento of somador_completo is

begin 

	s <= a XOR b XOR cin;
	cout <= (a AND b) OR (a AND cin) OR (b AND cin);


end comportamento;