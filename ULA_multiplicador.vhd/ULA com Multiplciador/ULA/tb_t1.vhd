library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_t1 is
end tb_t1;

architecture comp of tb_t1 is
signal dado, S: signed(3 downto 0);
signal inicio, reset: std_logic;
signal clk: std_logic := '0';
signal flag: unsigned(2 DOWNTO 0); 
signal cont1, cont2: signed (3 downto 0) := "0000";
signal cont3: unsigned(10 downto 0) := "00000000000";
signal alterar, erro: std_logic := '0';
constant clk_period : time := 10 ns;

component t1 is
	generic (N : natural := 4 );
	PORT (clk, inicio, reset : IN STD_LOGIC;
			dado : IN SIGNED(N-1 DOWNTO 0);
			S : OUT SIGNED (N-1 DOWNTO 0);
			flag : OUT UNSIGNED(2 DOWNTO 0));
	
end component;

begin
	DUT: t1 generic map (4) port map(clk, inicio, reset, dado, S, flag);

	teste: process(S, alterar)
	constant period: time := 10 ns;
	begin
		if (alterar = '1') then
			cont3 <= cont3 + 1;
		end if;
		
		if (cont3 = 0) then
			if (cont1 + cont2 /= S) then
				erro <= '1';
			else erro <= '0';
			end if;

		elsif (cont3 = 1) then
			if (cont1 - cont2 /= S) then
				erro <= '1';
			else erro <= '0';
			end if;

		elsif (cont3 = 2) then
			if ((cont1 and cont2) /= S) then
				erro <= '1';
			else erro <= '0';
			end if;

		elsif (cont3 = 3) then
		
			if ((cont1 or cont2) /= S) then
				erro <= '1';
			else erro <= '0';
			end if;

		else
			if ((cont1 * cont2 /= S) and flag(2) = '0') then
				erro <= '1';
			else erro <= '0';
			end if;

		end if;
	end process;

	process
		constant period: time := 10 ns;
		begin
			reset <= '1';
				wait for 2 ns;
			reset <= '0'; inicio <= '1';
				wait for 3 ns;
			
			
			dado <= (OTHERS => '0'); 
            
            for i in 0 to 255 loop
					wait for period;
					
                dado <= "0000";
						wait for period;					 
					 dado <= cont1;					  
						wait for period;					  
					 dado <= cont2;

						
						wait for 2*period;
						cont1 <= cont1 + 1;
						
						if cont1 = "1111" then
							cont2 <= cont2 + 1;
						
						end if;
                
            end loop;
		alterar <= '1';
				
				for i in 0 to 255 loop
					
					wait for period;
					alterar <= '0';
                dado <= "0001";
						wait for period;					 
					 dado <= cont1;					  
						wait for period;					  
					 dado <= cont2;

						
						wait for 2*period;

						cont1 <= cont1 + 1;
						
						if cont1 = "1111" then
							cont2 <= cont2 + 1;
						
						end if;
                
            end loop;
		alterar <= '1';
				for i in 0 to 255 loop
					
					wait for period;
					alterar <= '0';
                dado <= "0010";
						wait for period;					 
					 dado <= cont1;					  
						wait for period;					  
					 dado <= cont2;

						
						wait for 2*period;
                
						cont1 <= cont1 + 1;
						
						if cont1 = "1111" then
							cont2 <= cont2 + 1;
						
						end if;

            end loop;
		alterar <= '1';
			for i in 0 to 255 loop
					
					wait for period;
					alterar <= '0';
                dado <= "0011";
						wait for period;					 
					 dado <= cont1;					  
						wait for period;					  
					 dado <= cont2;

						
						wait for 2*period;
                
						cont1 <= cont1 + 1;
						
						if cont1 = "1111" then
							cont2 <= cont2 + 1;
						
						end if;

            end loop;
		alterar <= '1';
			for i in 0 to 255 loop
					
					wait for period;
					alterar <= '0';
                dado <= "0100";
						wait for period;					 
					 dado <= cont1;					  
						wait for period;					  
					 dado <= cont2;

						
						wait for 2*period;

						cont1 <= cont1 + 1;
						
						if cont1 = "1111" then
							cont2 <= cont2 + 1;
						
						end if;
                
            end loop;
		alterar <= '1';		
	end process;
	
	

	clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;
	
end comp;