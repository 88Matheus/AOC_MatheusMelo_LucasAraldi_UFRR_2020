LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder_8 IS
    PORT (
        A : IN std_logic_vector(7 DOWNTO 0);
        B : IN std_logic_vector(7 DOWNTO 0);
        sinal : IN std_logic;
        result : OUT std_logic_vector(7 DOWNTO 0);
        cout : OUT std_logic
    );
END adder_8;

ARCHITECTURE ciclos_add OF adder_8 IS

    COMPONENT adder_part_2 IS
        PORT (
            A : IN std_logic;
            B : IN std_logic;
            cin : IN std_logic;
            sum : OUT std_logic;
            cout : OUT std_logic
        );
    END COMPONENT;

    SIGNAL C1, C2, C3, C4, C5, C6, C7, C8 : std_logic;

BEGIN
    A0 : adder_part_2 PORT MAP(A(0), B(0), sinal, result(0), C1);
    A1 : adder_part_2 PORT MAP(A(1), B(1), C1, result(1), C2);
    A2 : adder_part_2 PORT MAP(A(2), B(2), C2, result(2), C3);
    A3 : adder_part_2 PORT MAP(A(3), B(3), C3, result(3), C4);
    A4 : adder_part_2 PORT MAP(A(4), B(4), C4, result(4), C5);
    A5 : adder_part_2 PORT MAP(A(5), B(5), C5, result(5), C6);
    A6 : adder_part_2 PORT MAP(A(6), B(6), C6, result(6), C7);
    A7 : adder_part_2 PORT MAP(A(7), B(7), C7, result(7), cout);
END ciclos_add;
