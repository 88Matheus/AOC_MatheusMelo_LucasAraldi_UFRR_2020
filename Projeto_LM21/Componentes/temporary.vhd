LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tempoprary IS
    PORT (
        in_port : IN std_logic;
        out_port : OUT std_logic
    );
END tempoprary;

ARCHITECTURE ciclos_tempo OF tempoprary IS
BEGIN
    out_port <= in_port;
END ciclos_tempo;
