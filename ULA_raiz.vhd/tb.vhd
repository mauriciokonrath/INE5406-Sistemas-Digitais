library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb is
generic (N : natural := 8);
end tb;

architecture comp of tb is
signal S: signed(N-1 downto 0);
signal inicio, reset, pronto: std_logic;
signal clk: std_logic := '0';
signal flag: unsigned(3 DOWNTO 0);
constant clk_period : time := 10 ns;

file output_buf : text open write_mode is "output_files/saidas.txt"; 
constant num_of_clocks : integer := 65;
signal i : integer := 0;

component projeto is
	generic (N : natural := 8 );
	PORT (clk, inicio, reset : IN STD_LOGIC;
   S : OUT SIGNED (N-1 DOWNTO 0);
   flag : OUT UNSIGNED(3 DOWNTO 0);
	pronto: out std_logic := '0');
	
end component;

begin
	DUT: projeto generic map (8) port map(clk, inicio, reset, S, flag, pronto);
	process
		begin
			reset <= '1';
				wait for 2 ns;
			reset <= '0'; inicio <= '1';
				wait;
	end process;	

	clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
		  
		  if (i = num_of_clocks) then
            file_close(output_buf);
            wait;
        else
            i <= i + 1;
        end if;
   end process;
	
	file_io: process(S)
			variable write_col_to_output_buf : line;
      begin 
			write(write_col_to_output_buf, std_logic_vector(signed(S)));
			write(write_col_to_output_buf, string'(" "));
			write(write_col_to_output_buf, std_logic_vector(unsigned(flag)));
         writeline(output_buf, write_col_to_output_buf);
	end process;
	
end comp;