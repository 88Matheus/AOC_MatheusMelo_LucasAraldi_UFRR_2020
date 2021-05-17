LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY u_control IS
    PORT (
        clock : IN std_logic;
        op_code : IN std_logic_vector (3 DOWNTO 0);
        jump,  branch,  mem_read,  mem_volta,  mem_pro_reg,  alu_src,  reg_write : OUT std_logic;
        alu_controle : OUT std_logic_vector (3 DOWNTO 0)
     );
END u_control;

ARCHITECTURE ciclo_contole OF u_control IS
BEGIN
    PROCESS (clock)
    BEGIN
        CASE op_code IS
            when "0000" => -- 0000 
				
               alu_controle <= "0000";
				   alu_src <= '0';
				   mem_pro_reg <= '0';
				   branch <= '0';
				   mem_read <= '0';
				   mem_volta <= '0';
				   reg_write <= '1';
				   jump <= '0';
				  
				 when "0001" => 
				 
				  alu_controle <= "0001";
				  alu_src <= '0';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <= '0';
				  reg_write <= '1';
				  jump <= '0';
				
				when "0010" =>
				
				  alu_controle <= "0010";
				  alu_src <= '1';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <= '0';
				  reg_write <= '1';
				  jump <= '0';
				
				when "0011" =>
					
				  alu_controle <= "0011";
				  alu_src <= '1';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <= '0';
				  reg_write <= '1';
				  jump <= '0';
					
				when "0100" =>
				
				  alu_controle <= "0100";
				  alu_src <= '0';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <= '1';
				  reg_write <= '0';
				  jump <= '0';
					
				when "0101" =>
				  alu_controle <= "0101";
				  alu_src <= '0';
				  mem_pro_reg <= '1';
				  branch <= '0';
				  mem_read <= '1';
				  mem_volta <= '0';
				  reg_write <= '0';
				  jump <= '0';
				   
				when "0110" =>
					 alu_controle <= "0110";
				  alu_src <= '0';
				  mem_pro_reg <= '0';
				  branch <= '1';
				  mem_read <= '0';
				  mem_volta <= '0';
				  reg_write <= '0';
				  jump <= '0';
				  
				when "0111" =>
					 alu_controle <= "0111";
				  alu_src <= '0';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <= '1';
				  reg_write <= '0';
				  jump <= '0';
				  
				when "1000" =>
					 alu_controle <= "1000";
				  alu_src <= '1';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <='0';
				  reg_write <= '1';
				  jump <= '0';
				  
				when"1001" =>
					 alu_controle <= "1001";
				  alu_src <= '0';
				  mem_pro_reg <= '0';
				  branch <= '1';
				  mem_read <= '0';
				  mem_volta <= '0';
				  reg_write <= '0';
				  jump <= '0';
				  
				when "1010" =>
					 alu_controle <= "1010";
				  alu_src <= '0';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <= '0';
				  reg_write <= '0';
				  jump <= '1';
				  
				when "1011" =>
					 alu_controle <= "1011";
				  alu_src <= '0';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <= '0';
				  reg_write <= '1';
				  jump <= '0';
				  
				when "1111" =>
					 alu_controle <= "1111";
				  alu_src <= '0';
				  mem_pro_reg <= '0';
				  branch <= '0';
				  mem_read <= '0';
				  mem_volta <= '0';
				  reg_write <= '0';
				  jump <= '0';
				  
				  WHEN OTHERS =>
                alu_controle <= "1111";
                alu_src <= '0';
                mem_pro_reg <= '0';
                branch <= '0';
                mem_read <= '0';
                mem_volta <= '0';
                reg_write <= '0';
                jump <= '0';

				  END CASE;
    END PROCESS;
END ciclo_contole;
