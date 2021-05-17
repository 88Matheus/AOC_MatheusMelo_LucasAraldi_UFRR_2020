LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
-----ram == data memory
ENTITY ram IS
    PORT (
    clock : IN std_logic;
    mem_volta,mem_read : IN std_logic;
    adress : IN std_logic_vector(7 DOWNTO 0);
    in_port_ram : IN std_logic_vector(7 DOWNTO 0);
    out_port : OUT std_logic_vector(7 DOWNTO 0)
    );
END ram;

ARCHITECTURE ciclo_ram OF ram IS
    TYPE m_ram IS ARRAY (0 TO 7) OF std_logic_vector(7 DOWNTO 0);
    SIGNAL data_memory : m_ram := (OTHERS => "00000000");
BEGIN
    PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF (mem_volta = '1') THEN
            data_memory(to_integer(unsigned(adress))) <= in_port_ram;
            END IF;
            IF (mem_read = '1') THEN
            out_port <= data_memory(to_integer(unsigned(adress)));
            END IF;
        END IF;
    END PROCESS;
END ciclo_ram;
