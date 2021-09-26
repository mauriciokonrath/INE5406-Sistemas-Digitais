LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplicador IS
PORT (entA, entB : IN STD_LOGIC_VECTOR(3 downto 0);
      inicio, reset, ck : IN STD_LOGIC;
      pronto : OUT STD_LOGIC;
      saida, contA, contB: OUT STD_LOGIC_VECTOR(3 downto 0));
END multiplicador;

-- Sinais de comando
-- ini = RstP = mA = CB  => ini=1 somente em S1
-- CA=1 em S1 e em S4
-- dec = op = m1 = m2  => dec=1 somente em S4 (estado no qual ocorre A <= A - 1 )
-- CP=1 somente em S3 (estado no qual ocorre P <= P + B )


ARCHITECTURE estrutura OF multiplicador IS
    COMPONENT bc IS
        PORT (Reset, clk, inicio : IN STD_LOGIC;
        Az, Bz : IN STD_LOGIC;
        pronto : OUT STD_LOGIC;
        ini, CA, dec, CP: OUT STD_LOGIC );
    END COMPONENT;

    COMPONENT bo IS
			PORT (clk : IN STD_LOGIC;
			ini, CP, CA, dec : IN STD_LOGIC;
			entA, entB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Az, Bz : OUT STD_LOGIC;
			saida, conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
	 
	 signal saiAz, saiBz, saipronto, saiini, saiCA, saidec, saiCP: STD_LOGIC;
	 signal saisaida, saiconteudoA, saiconteudoB: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

bc0: bc port map(reset, ck, inicio, saiAz, saiBz, saipronto, saiini, saiCA, saidec, saiCP);
bo0: bo port map(ck, saiini, saiCP, saiCA, saidec, entA, entB, saiAz, saiBz, saisaida, saiconteudoA, saiconteudoB);

pronto <= saipronto;
saida <= saisaida;
contA <= saiconteudoA;
contB <= saiconteudoB;

END estrutura;