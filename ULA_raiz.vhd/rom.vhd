library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	generic(
		data_bits: integer := 8;
		addr_bits: integer := 5;
		data_width: integer := 28
	);
	port(
		addr: in unsigned(addr_bits-1 downto 0);
		data: out signed(data_bits-1 downto 0)
	);
end rom;

architecture arch of rom is

type rom_type is array (0 to data_width) of signed(data_bits-1 downto 0);
signal rom: rom_type := (
	"00000001", -- opcode - soma
	"01111111", -- a
	"01111111", -- b
	"00000010", -- opcode - subtração
	"00011111", -- a
	"00011111", -- b
	"00000011", -- opcode - incremento
	"01111111", -- a
	"00000100", -- opcode - decremento
	"00000000", -- a
	"00000101", -- opcode - not
	"00001111", -- a
	"00000110", -- opcode - and
	"00110011", -- a
	"10101010", -- b
	"00000111", -- opcode - or
	"00011100", -- a
	"00000011", -- b
	"00001000", -- opcode - xor
	"00001111", -- a
	"10101100", -- b
	"00001001", -- opcode - multiplicação
	"00000110", -- a
	"00000011", -- b
	"00001010", -- opcode - raiz
	"11010001", -- a
	"00001010", -- opcode - raiz
	"00110010", -- a
	"00001111"  -- opcode - halt
);

begin
	data <= rom(to_integer(unsigned(addr)));

end arch;