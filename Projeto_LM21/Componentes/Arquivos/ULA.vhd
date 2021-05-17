-- unidade ligica aritimetica


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ULA IS
    PORT (
        clock : IN std_logic;
        alu_controle : IN std_logic_vector (3 DOWNTO 0);
        in_port_A,in_port_B : IN std_logic_vector(7 DOWNTO 0);
        re_out_ula : OUT std_logic_vector(7 DOWNTO 0);
		  zero : OUT std_logic;
		  overflow : OUT std_logic

    );
END ULA;
------------------------------------------------
ARCHITECTURE ciclos_ula OF ULA IS
    COMPONENT tempoprary IS
        PORT (
            in_port : IN std_logic;
            out_port : OUT std_logic
        );
    END COMPONENT;
---------------------------------------------------	 
    COMPONENT mult IS
        PORT (
            in_port_A : IN std_logic_vector(7 DOWNTO 0);
            in_port_B : IN std_logic_vector(7 DOWNTO 0);
            out_port : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT adder_8 IS
        PORT (
            A : IN std_logic_vector(7 DOWNTO 0);
            B : IN std_logic_vector(7 DOWNTO 0);
            sinal : IN std_logic;
            result : OUT std_logic_vector(7 DOWNTO 0);
            cout : OUT std_logic
        );
    END COMPONENT;

    COMPONENT sub_8 IS
        PORT (
            A : IN std_logic_vector(7 DOWNTO 0);
            B : IN std_logic_vector(7 DOWNTO 0);
            result : OUT std_logic_vector(7 DOWNTO 0);
            cout : OUT std_logic
        );
    END COMPONENT;

    -- Para usar na instrução (1010) if para o beq e bne
    SIGNAL in_temp : std_logic; 
    SIGNAL out_temp : std_logic;

    -- Usado no resultado da multiplicação
    SIGNAL out_multi : std_logic_vector(15 DOWNTO 0);

    --Para ver se ocorreu overflow nas intruções add e addi
    SIGNAL temp_in_A : std_logic_vector(8 DOWNTO 0);
    SIGNAL temp_in_B : std_logic_vector(8 DOWNTO 0);
    SIGNAL temp_result : std_logic_vector(8 DOWNTO 0);
    --Usados nas operações de adição e subtração
    SIGNAL r_adder : std_logic_vector(7 DOWNTO 0);
    SIGNAL r_sub : std_logic_vector(7 DOWNTO 0);
    SIGNAL overflowadder : std_logic;
    SIGNAL overflowsub : std_logic;

BEGIN
    port_map_temp: tempoprary PORT MAP(in_temp, out_temp);
    port_map_multi : mult PORT MAP(in_port_A, in_port_B, out_multi);
    port_map_adder : adder_8 PORT MAP(in_port_A, in_port_B, '0', r_adder, overflowadder);
    port_map_sub : sub_8 PORT MAP(in_port_A, in_port_B, r_sub, overflowsub);
    PROCESS (clock)
    BEGIN
        CASE alu_controle IS
            WHEN "0000" => --add
                temp_in_A <= "0" & in_port_A;
                temp_in_B <= "0" & in_port_B;
                temp_result <= temp_in_A + temp_in_B;

                IF temp_result(8) = '1' THEN
                    overflow <= '1';
                ELSE
                    overflow <= '0';
                END IF;
                re_out_ula <= temp_result(7 DOWNTO 0);
                re_out_ula <= r_adder;
                overflow <= overflowadder;

            WHEN "0010" => --addi
                temp_in_A <= "0" & in_port_A;
                temp_in_B <= "0" & in_port_B;
                temp_result <= temp_in_A + temp_in_B;
                re_out_ula <= r_adder;
                overflow <= overflowadder;

                IF temp_result(8) = '1' THEN
                    overflow <= '1';
                ELSE
                    overflow <= '0';
                END IF;
                re_out_ula <= temp_result(7 DOWNTO 0);
            WHEN "0001" => --sub
                re_out_ula <= in_port_A - in_port_B;
                re_out_ula <= r_sub;

            WHEN "0011" => --subi
                re_out_ula <= in_port_A - in_port_B;
                re_out_ula <= r_sub;

            WHEN "0101" => -- lw
                re_out_ula <= in_port_A;

            WHEN "0100" => -- sw
                re_out_ula <= in_port_A;

            WHEN "1011" => -- move
                re_out_ula <= in_port_B;

            WHEN "1000" => -- li
                re_out_ula <= in_port_B;

            WHEN "0110" => -- beq
                IF out_temp = '1' THEN
                    zero <= '1';
                ELSE
                    zero <= '0';
                END IF;
                re_out_ula <= "00000000";

            WHEN "1001" => -- bne
                IF out_temp = '0' THEN
                    zero <= '1';
                ELSE
                    zero <= '0';
                END IF;
                re_out_ula <= "00000000";

            WHEN "1111" => -- if beq e bne
                IF in_port_A = in_port_B THEN
                    in_temp <= '1';
                ELSE
                    in_temp<= '0';
                END IF;
                re_out_ula <= "00000000";

            WHEN "0111" => -- mul
                re_out_ula <= out_multi(7 DOWNTO 0);
                IF out_multi(8) = '1' OR out_multi(9) = '1' OR out_multi(10) = '1' OR out_multi(11) = '1' OR out_multi(12) = '1' OR out_multi(13) = '1' OR out_multi(14) = '1' OR out_multi(15) = '1' THEN
                    overflow <= '1';
                ELSE
                    overflow <= '0';
                END IF;

            WHEN OTHERS =>
                re_out_ula <= "00000000";
        END CASE;
		 END PROCESS;
	END ciclos_ula;