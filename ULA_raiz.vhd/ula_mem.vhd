library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Ula_mem is
generic(N: natural:= 4); 
port
    (
		  clk: in std_logic;
		  iniciarUla: in std_logic;
        A, B: in SIGNED(N-1 downto 0);
        SEL: in SIGNED(3 downto 0);
		flag: out STD_LOGIC_VECTOR(3 downto 0);
		overflow, negativo, zero, erro, pronto_ula: out STD_LOGIC := '0';
        S: out SIGNED(N-1 downto 0)
    );
end Ula_mem;

architecture estrutura of Ula_mem is

COMPONENT multiplicador_booth is
	generic (N : integer := 8);
	port (A,B: in signed(N-1 downto 0);
			clk, start: in std_logic;
			pronto: out std_logic;
			S: out signed((2*N)-1 downto 0)
			);
END COMPONENT;

COMPONENT somador IS
generic(N: natural:= 8);
Port (
	a : in  SIGNED(N-1 downto 0);
	b : in  SIGNED(N-1 downto 0);
	sel: in STD_LOGIC;
	sum : out  SIGNED(N-1 downto 0);
	overflow : out std_logic
	);
	END COMPONENT;

COMPONENT raiz IS
generic (N : natural := 8);
port (clk: in std_logic;
		 A: in signed(N-1 downto 0);
		 start: in std_logic := '0';
		 neg, pronto: out std_logic := '0';
	  S: out unsigned(N-1 downto 0));
END COMPONENT;
    
signal OUTPUT, sum_in, sum: signed(N-1 downto 0);
signal saimult: signed(2*N-1 downto 0);
signal sairaiz: unsigned(N-1 downto 0);
signal um: signed(N downto 0):= (others => '1');
signal sum_overflow, mult_overflow, pronto_raiz, pronto_mult, op: std_logic := '0';

begin
	mult_booth: multiplicador_booth generic map(N) PORT MAP (A, B, clk, iniciarUla, pronto_mult, saimult);
    raiz_quad: raiz generic map(N) PORT MAP(clk, A, iniciarUla, erro, pronto_raiz, sairaiz);
	 eba: somador generic map(N) PORT MAP (A, sum_in, op, sum, sum_overflow);

	WITH SEL select
	    op <='1' WHEN "0001",
			'1' WHEN "0011",
			'0' WHEN OTHERS;

	sum_in <= B when ((SEL = "0001") or (SEL = "0010")) else to_signed(1, N);

    WITH SEL select
        OUTPUT <= (others => '0') WHEN "0000",
						sum WHEN "0001" | "0010" | "0011" | "0100",
						NOT(A) WHEN "0101",
						A AND B WHEN "0110",
						A OR B WHEN "0111",
						A XOR B WHEN "1000",
						saimult(N-1 downto 0) WHEN "1001",
						signed(sairaiz) WHEN OTHERS;

	WITH SEL select
		pronto_ula <= '1' WHEN "0000",
					'1' WHEN "0001",
					'1' WHEN "0010",
					'1' WHEN "0011",
					'1' WHEN "0100",
					'1' WHEN "0101",
					'1' WHEN "0110",
					'1' WHEN "0111",
					'1' WHEN "1000",
					pronto_mult WHEN "1001",
					pronto_raiz WHEN OTHERS;
	
	overflow <= sum_overflow WHEN (SEL = "0001" or SEL =  "0010" or SEL =  "0011" or SEL =  "0100") ELSE
					mult_overflow WHEN SEL = "1001" ELSE '0';
	
	process(OUTPUT) is
	begin
		if OUTPUT < 0 then
			negativo <= '1';
		else
			negativo <= '0';				
		end if;
			
		if (OUTPUT = 0) then
			zero <= '1';
		else
			zero <= '0';
			
		end if;
	end process;
	
	process(saimult) is
	begin
		if (saimult(2*N-1 downto N-1) = 0) or (saimult(2*N-1 downto N-1) = um) then
				mult_overflow <= '0';
			else
				mult_overflow <= '1';
			end if;
	end process;

    S <= OUTPUT;

end estrutura;