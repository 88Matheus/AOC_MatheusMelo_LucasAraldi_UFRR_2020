LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY mult IS
    PORT (
        in_port_A, in_port_B : IN std_logic_vector(7 DOWNTO 0);
        out_port : OUT std_logic_vector(15 DOWNTO 0)
    );
END mult;

ARCHITECTURE ciclos_mult OF mult IS
BEGIN
    PROCESS (in_port_A, in_port_B)
        VARIABLE produto : std_logic_vector(16 DOWNTO 0);
    BEGIN
        produto := "00000000" & in_port_B & "0";
        FOR i IN 0 TO 7 LOOP
            IF (produto(1) = '0' AND produto(0) = '1') THEN
                produto(16 DOWNTO 9) := produto(16 DOWNTO 9) + in_port_A;
            ELSIF (produto(1) = '1' AND produto(0) = '0') THEN
                produto(16 DOWNTO 9) := produto(16 DOWNTO 9) - in_port_A;
            END IF;
            produto(15 DOWNTO 0) := produto(16 DOWNTO 1);
        END LOOP;
        out_port <= produto(16 DOWNTO 1);
    END PROCESS;
END ciclos_mult;
