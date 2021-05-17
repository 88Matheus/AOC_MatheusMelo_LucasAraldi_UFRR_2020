LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder_part_2 IS
    PORT (
        A : IN std_logic;
        B : IN std_logic;
        cin : IN std_logic;
        sum : OUT std_logic;
        cout : OUT std_logic
    );
END adder_part_2;

ARCHITECTURE ciclos_add2 OF adder_part_2 IS

    COMPONENT adder_part_1 IS
        PORT (
            A : IN std_logic;
            B : IN std_logic;
            sum : OUT std_logic;
            cout : OUT std_logic
        );
    END COMPONENT;

    SIGNAL ha1_sum, ha1_cout, ha2_cout : std_logic;

BEGIN
    ha1 : adder_part_1 PORT MAP(A, B, ha1_sum, ha1_cout);
    ha2 : adder_part_1 PORT MAP(ha1_sum, cin, sum, ha2_cout);
    cout <= ha1_cout OR ha2_cout;
END ciclos_add2;
