LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bc IS
PORT (clk , inicio, reset, prontoUla: IN STD_LOGIC;
		dado: IN SIGNED (3 DOWNTO 0);
      enA, enB, enOp, enOut, enPC, resetPC, pronto, iniciarUla: OUT STD_LOGIC);
END bc;

ARCHITECTURE estrutura OF bc IS
	TYPE state_type IS (S0, S1, S2, S3, S4, S5);
	SIGNAL state: state_type;
	SIGNAL opcode: SIGNED (3 DOWNTO 0);
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, reset)
	BEGIN
		
		if (reset = '1') then
			state <= S0;
		elsif (clk'EVENT AND clk = '1') THEN
			CASE state IS
				WHEN S0 =>
					enA <= '0';
					enB <= '0';
					enOP <= '0';
					enOut <= '0';
					enPC <= '0';
					resetPC <= '1';
					pronto <= '0';
					iniciarUla <= '0';
					opcode <= dado;

					if (inicio = '1') then
						state <= S1;
					end if;
					
				WHEN S1 =>
					enA <= '0';
					enB <= '0';
					enOP <= '1';
					enOut <= '0';
					enPC <= '1';
					resetPC <= '0';
					pronto <= '0';
					iniciarUla <= '0';

					if (opcode = "0000") then
						state <= S1;
					elsif (opcode = "1111") then
						state <= S0;
					else
						state <= S2;
					end if;

				WHEN S2 =>
					enA <= '1';
					enB <= '0';
					enOP <= '0';
					enOut <= '0';
					enPC <= '1';
					resetPC <= '0';
					pronto <= '0';
					iniciarUla <= '0';

					if ((opcode = "0011")
					 or (opcode = "0100")
					 or (opcode = "0101")
					 or (opcode = "1010"))
					then
						state <= S4;
					else
						state <= S3;
					end if;

				WHEN S3 =>
					enA <= '0';
					enB <= '1';
					enOP <= '0';
					enOut <= '0';
					enPC <= '1';
					resetPC <= '0';
					pronto <= '0';
					iniciarUla <= '0';

					state <= S4;

				WHEN S4 =>
					enA <= '0';
					enB <= '0';
					enOP <= '0';
					enOut <= '0';
					enPC <= '0';
					resetPC <= '0';
					pronto <= '0';
					iniciarUla <= '1';

					if (prontoUla = '1') then
						state <= S5;
					end if;
				
				WHEN S5 =>
					enA <= '0';
					enB <= '0';
					enOP <= '0';
					enOut <= '1';
					enPC <= '0';
					resetPC <= '0';
					pronto <= '1';
					iniciarUla <= '1';

					opcode <= dado;
					state <= S1;

			END CASE;
		END IF;
	END PROCESS;
END estrutura;
