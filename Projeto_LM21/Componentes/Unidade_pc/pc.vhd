--melhor começar por aqui 
--unidade pc do processador

library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
ENTITY pc IS
    PORT (
        in_port : IN std_logic_vector (7 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0);
        clock : IN std_logic
    );
END pc;

ARCHITECTURE ciclos_pc OF pc IS
BEGIN
    PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            out_port <= in_port;
        END IF;
    END PROCESS;
END ciclos_pc;
