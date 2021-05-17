LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY somador IS
    PORT (
        clock : IN std_logic;
        in_port : IN std_logic_vector (7 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0)
	);
		 
END somador;

ARCHITECTURE ciclo_somador OF somador IS
BEGIN
    PROCESS (clock)
    BEGIN
        out_port <= in_port + "00000001";
    END PROCESS;
END ciclo_somador;