LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT ( clk , inicio, reset: IN STD_LOGIC;
      enA, enB, enOp, enOut : OUT STD_LOGIC );
END bc;

ARCHITECTURE estrutura OF bc IS
	TYPE state_type IS (S0, S1, S2, S3, S4);
	SIGNAL state: state_type;
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, reset)
	BEGIN
		
		if (reset = '1') then
			state <= S0;
		elsif (clk'EVENT AND clk = '1') THEN
			CASE state IS
				WHEN S0 =>
					if(inicio = '0') then
						state <= S0;
					else
						state <= S1;
					end if;
						
				WHEN S1 => state <= S2;

				WHEN S2 => state <= S3;

				WHEN S3 => state <= S4;

				WHEN S4 => state <= S0;


			END CASE;
		END IF;
	END PROCESS;
	
	-- Logica de saida
	PROCESS (state)
	BEGIN
		CASE state IS
			WHEN S0 =>
				enA <= '0';
				enB <= '0';
				enOP <= '0';
				enOut <= '0';				
				
			WHEN S1 =>
				enA <= '0';
				enB <= '0';
				enOP <= '1';
				enOut <= '0';
				
			WHEN S2 =>
				enA <= '1';
				enB <= '0';
				enOP <= '0';
				enOut <= '0';
				
			WHEN S3 =>
				enA <= '0';
				enB <= '1';
				enOP <= '0';
				enOut <= '0';
				
			WHEN S4 =>
				enA <= '0';
				enB <= '0';
				enOP <= '0';
				enOut <= '1';
				
		END CASE;
	END PROCESS;
END estrutura;