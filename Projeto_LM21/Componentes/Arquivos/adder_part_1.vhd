LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder_part_1 IS
    PORT (
        A : IN std_logic;
        B : IN std_logic;
        sum : OUT std_logic;
        cout : OUT std_logic
    );
END adder_part_1;

ARCHITECTURE ciclos_add1 OF adder_part_1 IS
BEGIN
    sum <= A XOR B;
    cout <= A AND B;
END ciclos_add1;