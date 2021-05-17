LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY half_adder IS
    PORT (
        A : IN std_logic;
        B : IN std_logic;
        sum : OUT std_logic;
        cout : OUT std_logic
    );
END half_adder;

ARCHITECTURE behavior OF half_adder IS
BEGIN
    sum <= A XOR B;
    cout <= A AND B;
END behavior;