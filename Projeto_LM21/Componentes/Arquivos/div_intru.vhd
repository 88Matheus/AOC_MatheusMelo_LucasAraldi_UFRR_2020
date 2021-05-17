--divisao de intução 4x2x2;4x2x2;3;4
--

library ieee;
use ieee.std_logic_1164.all;

entity div_intru is port(
    in_port : IN std_logic_vector(7 DOWNTO 0);
    out_op_code : OUT std_logic_vector(3 DOWNTO 0);
    out_rs, out_rt : OUT std_logic_vector(1 DOWNTO 0);
    out_jump : OUT std_logic_vector(3 DOWNTO 0)
);
end div_intru;

architecture ciclo_instru of div_intru is
begin

    out_op_code <= in_port(7 DOWNTO 4);
    out_rs <= in_port(3 DOWNTO 2);
    out_rt <= in_port(1 DOWNTO 0);
    out_jump <= in_port(3 DOWNTO 0);

end ciclo_instru;