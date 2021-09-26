library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned;
USE ieee.std_logic_signed.all;

entity Somador_8bitsComportamental is 

	port (A, B: in std_logic_vector(7 downto 0);			
			S: out std_logic_vector(7 downto 0));
			
end Somador_8bitsComportamental;

architecture comportamento of Somador_8bitsComportamental is

	begin
		S <= A + B;
		
end comportamento;
