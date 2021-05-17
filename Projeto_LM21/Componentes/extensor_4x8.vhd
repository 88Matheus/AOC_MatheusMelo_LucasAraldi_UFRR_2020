LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY extensor_4x8 IS
    PORT (
        in_port : IN std_logic_vector (3 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0)
    );
END extensor_4x8;

ARCHITECTURE ciclo_4x8 OF extensor_4x8 IS

BEGIN
    PROCESS (in_port)
    BEGIN
        out_port <= ("0000") & in_port;
    END PROCESS;
END ciclo_4x8;
