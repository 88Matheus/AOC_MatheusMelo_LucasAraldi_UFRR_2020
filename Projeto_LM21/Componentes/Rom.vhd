LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
--memroria rom == instuction memory
ENTITY rom IS
    PORT (
        clock : IN std_logic;
        in_port : IN std_logic_vector(7 DOWNTO 0);
        out_port : OUT std_logic_vector(7 DOWNTO 0)
    );
END rom;

ARCHITECTURE ciclo_rom OF rom IS
    TYPE memoriaRom IS ARRAY (0 TO 255) OF std_logic_vector(7 DOWNTO 0);
    CONSTANT m_rom : memoriaRom := (
     --Teste addi, add, subi, li e jump//lebrar quetroquei os operadoreskkkkkkkk
   0 => "00100010", -- addi S0 2 -- S0 == 2
   1 => "00100111", -- addi S1 3 -- S1 == 3
   2 => "00000001", -- add S0 S1 -- S0 == 5
   3 => "00100011", -- addi S0 3 -- S0 == 8
   4 => "00110010", -- subi S0 2 -- S0 == 6
   5 => "10000000", -- li S0 0
   6 => "10000100", -- li S1 0
   7 => "10100000", -- jump 0000
    OTHERS => "00000000"
	 	 );

		 
BEGIN
    PROCESS (clock)
    BEGIN
        out_port <= m_rom(conv_integer(unsigned(in_port)));
    END PROCESS;
END ciclo_rom;
