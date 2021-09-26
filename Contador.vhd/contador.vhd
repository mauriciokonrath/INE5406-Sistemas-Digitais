library IEEE;
use IEEE.std_logic_1164.all;

entity contador is
	port (
		clk: in std_logic;
		s: out std_logic_vector(3 downto 0)
	);
end contador;

architecture comportamento of contador is
	component ff_jk is
		port (
			j, k, clk: in std_logic;
         Q, notQ: out std_logic
		);
	end component;
	
	signal qs: std_logic_vector(3 downto 0);
	signal notqs: std_logic_vector(3 downto 0);
begin
	FF0: ff_jk port map ('1', '1', clk, qs(0), notqs(0));
	FF1: ff_jk port map ('1', '1', notqs(0), qs(1), notqs(1));
	FF2: ff_jk port map ('1', '1', notqs(1), qs(2), notqs(2));
	FF3: ff_jk port map ('1', '1', notqs(2), qs(3), notqs(3));
	
	s <= qs;
end comportamento;
	