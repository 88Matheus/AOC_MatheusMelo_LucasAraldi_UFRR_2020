LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplex_2x1 IS
    PORT (
        in_port : IN std_logic;
        in_A, in_B: IN std_logic_vector (7 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0)
    );
END multiplex_2x1;

ARCHITECTURE ciclos_2x1 OF multiplex_2x1 IS
BEGIN
    PROCESS (in_port, in_A, in_B)
    BEGIN
        CASE in_port IS
            WHEN '0' => out_port <= in_A;
            WHEN '1' => out_port <= in_B;
        END CASE;
    END PROCESS;
END ciclos_2x1;