--Banco de registradores
--vai dar input pela rom e output pra ula

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY banco_regs IS PORT (
    clock : IN std_logic;
    reg_write : IN std_logic;
    address_1,  address_2  : IN std_logic_vector(1 DOWNTO 0);
    write_data : IN std_logic_vector (7 DOWNTO 0);
    reg_out_A, reg_out_B : OUT std_logic_vector (7 DOWNTO 0)
);
END banco_regs;
-------------------------------------------------------------
ARCHITECTURE ciclo_reg OF banco_regs IS

    TYPE banco_regs IS ARRAY(0 TO 3) OF std_logic_vector (7 DOWNTO 0);
    SIGNAL regs : banco_regs;

BEGIN
    PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF (reg_write = '1') THEN
                regs(to_integer(unsigned(address_1))) <= write_data;
            END IF;
        END IF;
        reg_out_A <= regs(to_integer(unsigned(address_1)));
        reg_out_B <= regs(to_integer(unsigned(address_2)));
    END PROCESS;
END ciclo_reg;