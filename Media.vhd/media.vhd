library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity media is
port(
		a, b, c, d: in std_logic_vector(3 downto 0);
		aprovado, rec, reprovado: out std_logic
);
end media;

architecture comp of media is
	signal total: unsigned(5 downto 0);
	signal media_nota: unsigned(5 downto 0);
begin
	total <= unsigned("00"&a) + unsigned("00"&b) + unsigned("00"&c) + unsigned("00"&d);
	media_nota <= total / 4;

process(media_nota) is
	begin
	if(media_nota < 3) then
		reprovado <= '1';
		aprovado <= '0';
		rec <= '0';
	elsif(media_nota < 6) then
		reprovado <= '0';
		aprovado <= '0';
		rec <= '1';
	else
		reprovado <= '0';
		aprovado <= '1';
		rec <= '0';
	end if;
end process;
end comp;