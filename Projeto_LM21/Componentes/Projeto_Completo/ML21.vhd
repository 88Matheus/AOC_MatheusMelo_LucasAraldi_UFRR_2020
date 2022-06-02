library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
ENTITY ML21_processor_8bits_AOC IS
    PORT(
        clock : IN std_logic;
        saida_pc : OUT std_logic_vector (7 DOWNTO 0);
	saida_somador : OUT std_logic_vector (7 DOWNTO 0);
        saida_rom : OUT std_logic_vector (7 DOWNTO 0);
        saida_opcode : OUT std_logic_vector (3 DOWNTO 0);
        saida_rs : OUT std_logic_vector (1 DOWNTO 0);
        saida_rt : OUT std_logic_vector (1 DOWNTO 0);
	saida_reg_A : OUT std_logic_vector (7 DOWNTO 0);
        saida_reg_B : OUT std_logic_vector (7 DOWNTO 0);
        saida_ula_result : OUT std_logic_vector(7 DOWNTO 0);
        saida_mram : OUT std_logic_vector(7 DOWNTO 0);
        saida_2X1ramula : OUT std_logic_vector(7 DOWNTO 0);
        saida_endereco : OUT std_logic_vector (3 DOWNTO 0);
	saida_overflow : OUT std_logic
    
	);
end ML21_processor_8bits_AOC;
---------------------------------------------------------
ARCHITECTURE ciclos OF ML21_processor_8bits_AOC IS

component pc IS
    PORT (
	clock : IN std_logic;
        in_port : IN std_logic_vector (7 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0)
    );
end component ;
---------------------------------------------------------
component somador IS
    PORT (
        clock : IN std_logic;
        in_port : IN std_logic_vector (7 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0)
	 );
end component ;
---------------------------------------------------------
component rom IS
    PORT (
        clock : IN std_logic;
        in_port : IN std_logic_vector(7 DOWNTO 0);
        out_port : OUT std_logic_vector(7 DOWNTO 0)
    );
end component;
-----banco_regs------------------------------------------------------
component banco_regs IS 
	PORT (
    	clock : IN std_logic;
   	reg_write : IN std_logic;
    	address_1,  address_2  : IN std_logic_vector(1 DOWNTO 0);
    	write_data : IN std_logic_vector (7 DOWNTO 0);
    	reg_out_A, reg_out_B : OUT std_logic_vector (7 DOWNTO 0)
);	
END component;
	
--divisão de instrução------------------------------------------------------------
	
component div_intru is port(
    in_port : IN std_logic_vector(7 DOWNTO 0);
    out_op_code : OUT std_logic_vector(3 DOWNTO 0);
    out_rs, out_rt : OUT std_logic_vector(1 DOWNTO 0);
    out_jump : OUT std_logic_vector(3 DOWNTO 0)
);
end component;


------------------------------------------------------------
----contole
component u_control IS
    PORT (
        clock : IN std_logic;
        op_code : IN std_logic_vector (3 DOWNTO 0);
        jump,branch,mem_read,mem_pro_reg,mem_volta,alu_src,reg_write : OUT std_logic;
        alu_controle : OUT std_logic_vector (3 DOWNTO 0)
     );
END component;


-------------------------------------------------------------
--ula
component ULA IS
    PORT (
        clock : IN std_logic;
        alu_controle : IN std_logic_vector(3 DOWNTO 0);
        in_port_A,in_port_B : IN std_logic_vector(7 DOWNTO 0);
        re_out_ula : OUT std_logic_vector(7 DOWNTO 0);
        zero : OUT std_logic;
        overflow : OUT std_logic
    );
END component;
-------------------------------------------------------------
--ram
component ram IS
    PORT (
        clock : IN std_logic;
        mem_volta,mem_read : IN std_logic;
        adress : IN std_logic_vector(7 DOWNTO 0);
		  in_port_ram : IN std_logic_vector(7 DOWNTO 0);
        out_port : OUT std_logic_vector(7 DOWNTO 0)
    );
END component;
-------------------------------------------------------------
--multiplexador
component multiplex_2x1 IS
    PORT (
        in_port : IN std_logic;
        in_A, in_B: IN std_logic_vector (7 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0)
    );
END component;
-------------------------------------------------------------
--extensor  2 => 8// extensor 4 => 8
component extensor_2x8 IS
    PORT (
        in_port : IN std_logic_vector (1 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0)
    );
END component;

component extensor_4x8 IS
    PORT (
        in_port : IN std_logic_vector (3 DOWNTO 0);
        out_port : OUT std_logic_vector (7 DOWNTO 0)
    );
END component;
-------------------------------------------------------------
--port_and
component port_and IS
    PORT (
        in_port_A,  in_port_B: IN STD_LOGIC;
        out_port : OUT STD_LOGIC
    );
END component;
-------------------------------------------------------------
--SINAIS DE SAIDA---regs
		
	signal out_pc : std_logic_vector(7 downto 0);
		
	signal out_somador : std_logic_vector(7 downto 0);
		
	signal out_rom : std_logic_vector(7 downto 0);
		
	signal out_reg_A : std_logic_vector (7 downto 0); 
		
	signal out_reg_B : std_logic_vector (7 downto 0);		
		
--div instuct
	 
        signal flagout_3_2 : std_logic_vector (1 DOWNTO 0);
		
	signal flagout_7_4 : std_logic_vector (3 DOWNTO 0);
				
        signal flagout_3_0 : std_logic_vector (3 DOWNTO 0);
	 	
	signal flagout_1_0 : std_logic_vector (1 DOWNTO 0);
		
		
--saida_multiplexadres----------------------------------------------------------

    	SIGNAL out_2X1_rem_reg_ula : std_logic_vector (7 DOWNTO 0);
	SIGNAL out_2X1_ramula : std_logic_vector (7 DOWNTO 0);
	SIGNAL out2X1_add_pc_jump : std_logic_vector (7 DOWNTO 0);
	SIGNAL out_2X1_jump : std_logic_vector (7 DOWNTO 0);
	
	--control---------------------------
	
	SIGNAL outc_jump : std_logic;
    	SIGNAL outc_branch : std_logic;
    	SIGNAL outc_mem_read : std_logic;
    	SIGNAL outc_mem_pro_reg : std_logic;
    	SIGNAL outc_mem_volta : std_logic;
    	SIGNAL outc_alu_src : std_logic;
    	SIGNAL outc_reg_write : std_logic;
	SIGNAL outc_alucontrole: std_logic_vector (3 DOWNTO 0);
	 
--------ula------------------------------------------------	 

	SIGNAL out_ula_re : std_logic_vector (7 DOWNTO 0);
	SIGNAL out_ula_zero : std_logic;
	SIGNAL out_overflow : std_logic;
--RAM------------------------------------------
	signal out_mem_ram : std_logic_vector (7 DOWNTO 0);

---extensores

 	SIGNAL out_extensor_2x8 : std_logic_vector (7 DOWNTO 0);
 	SIGNAL out_extensor_4x8 : std_logic_vector (7 DOWNTO 0);
 
 --portand
 SIGNAL out_port_and : std_logic;

begin
--port maps--------------------------------------------------------------------

portmap_pc : pc port map (clock, out_somador, out_pc);


portmap_somador: somador port map (clock, out_pc, out_somador);


portmap_rom : rom port map (clock, out_pc,out_rom );


portmap_regs : banco_regs port map (clock, outc_reg_write, flagout_3_2, flagout_1_0, out_2X1_ramula, out_reg_A, out_reg_B);


portmap_instrucao : div_intru port map ( out_rom, flagout_7_4, flagout_3_2, flagout_1_0, flagout_3_0);


portmap_ula : ULA port map ( clock, outc_alucontrole, out_reg_A, out_2X1_rem_reg_ula, out_ula_re, out_ula_zero, out_overflow);


portmap_contole : u_control port map (clock, flagout_7_4, outc_jump, outc_branch, outc_mem_read, outc_mem_pro_reg,outc_mem_volta, outc_alu_src, outc_reg_write);


portmap_ram : ram port map (clock, outc_reg_write, outc_mem_read, out_extensor_2x8, out_ula_re, out_mem_ram);

--MULTIPLEXADORES	------------------------------------------------------------
portmap_2x1_ram_reg_ula: multiplex_2x1 port map (outc_alu_src, out_reg_B, out_extensor_2x8, out_2X1_rem_reg_ula);


portmap_2x1_ramula : multiplex_2x1 port map (outc_mem_pro_reg, out_ula_re, out_mem_ram, out_2X1_ramula);


portmap_2x1_soma_jump : multiplex_2x1 port map (out_port_and, out_somador, out_extensor_4x8, out2X1_add_pc_jump);


portmap_2x1_jump : multiplex_2x1 port map ( outc_jump, out2X1_add_pc_jump, out_extensor_4x8, out_2X1_jump);
------------------------------------------------------------------------------------------------------------
portmap_and : port_and port map (outc_branch, out_ula_zero, out_port_and);


portmap_ext_4x8 : extensor_4x8 port map (flagout_3_0, out_extensor_4x8);

portmap_ext_2x8 : extensor_2x8 port map (flagout_1_0, out_extensor_2x8);


  -- Resultados Saidas
	saida_pc <=  out_pc;
        saida_rom <=  out_rom;                   
        saida_opcode <= flagout_7_4;
        saida_rs <= flagout_3_2;
	saida_rt<= flagout_1_0;
	saida_reg_A <= out_reg_A;
        saida_reg_B <= out_reg_B;
        saida_ula_result <= out_ula_re;
        saida_mram <= out_mem_ram;
        saida_2X1ramula <= out_2X1_ramula;
        saida_endereco <= flagout_3_0;
	saida_overflow <= out_overflow;
	saida_somador <= out_somador;

end ciclos;
