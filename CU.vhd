LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY CU IS
  GENERIC( reg_size : integer := 16);
  PORT(
	bus_A,bus_B : INOUT std_logic_vector(reg_size-1 DOWNTO 0);
	clk, rst_all: IN std_logic
	);

END ENTITY CU;


ARCHITECTURE arch OF CU IS

CONSTANT REGS_COUNT	:	integer	:=	8;


SIGNAL yout 			: 	std_logic_vector(reg_size-1 DOWNTO 0);
SIGNAL y_en				:	std_logic;
SIGNAL y_clear			:	std_logic;
SIGNAL alu_operation	:	std_logic_vector(3 downto 0);
SIGNAL dst				:	std_logic_vector(13 downto 0);
SIGNAL src				:	std_logic_vector(13 downto 0);
SIGNAL rst				:	std_logic_vector(6 downto 0);		-- rst(0) indicates general purpose registers reset
signal en_gen_reg_dst	:	std_logic;
signal en_gen_reg_src	:	std_logic;


signal reg_to_tristate	: 	std_logic_vector(reg_size*5-1 downto 0);
signal mem_address		:	std_logic_vector(15 downto 0);
signal mem_data_out		:	std_logic_vector(15 downto 0);
signal rom_address		:	std_logic_vector(15 downto 0);
signal mux_to_mdr		:	std_logic_vector(15 downto 0);

signal mem_read_c		:	std_logic_vector(0 downto 0);	-- control signal of memory read coming from control bus (cw)
signal mem_write_c		:	std_logic_vector(0 downto 0);	-- control signal of memory write coming from control bus (cw)
signal mem_read			:	std_logic;
signal mem_write		:	std_logic;
signal wmfc_c			:	std_logic;
signal mfc				:	std_logic;
signal run				:	std_logic;
--              FLAG    -- NZVC
signal alu_flags	:	std_logic_vector(3 downto 0);
SIGNAL alu_Cin			:	std_logic;
SIGNAL alu_Cout			:	std_logic;
SIGNAL f_en				:	std_logic;
SIGNAL f_clear			:	std_logic;
signal alu_Zout			:	std_logic;	
signal alu_Vout			:	std_logic;	
signal alu_Nout			:	std_logic;

signal state_inc_out	:	std_logic_vector(2 downto 0);									
signal state_inc_in		:	std_logic_vector(2 downto 0);		
signal state_rst		:	std_logic;							
signal state_clk		:	std_logic;				

BEGIN
		-- flag register   -- NZVC
	flag_reg 	: 	entity work.nbitRegister generic map(n => 4)
								port map(input => alu_Nout&alu_Zout&alu_Vout&alu_Cout, output => alu_flags, en => f_en, clk => clk, rst => f_clear);
		
	y 	: 	entity work.nbitRegister generic map(n => 16)
								port map(input => bus_A, output => yout, en => y_en, clk => clk, rst => y_clear);
	alu_module: entity work.ALU generic map(reg_size => 16) 
								port map( A => yout, B => bus_A, Cin => alu_flags(0), sel => alu_operation,Cout => alu_Cout,F => bus_B , Zout => alu_Zout, Vout => alu_Vout, Nout => alu_Nout);
	
	-- general puspose registers

	general_purpose_registers : entity work.generalRegisters 	generic map(REGS_COUNT => REGS_COUNT)
																port map(clk => clk, rst => rst(0) or rst_all, en_dst => en_gen_reg_dst, en_src => en_gen_reg_src, src => src(7 downto 0), dst => dst(7 downto 0), bus_A => bus_A, bus_B => bus_B);

	-- instruction register
	IR	: entity work.nbitRegister 	generic map(n => 16)
									port map(input => bus_B, output => reg_to_tristate(reg_size-1 downto 0), en => dst(8), rst => rst_all OR rst(1), clk => clk);
	-- program counter register
	PC	: entity work.nbitRegister 	generic map(n => 16)
									port map(input => bus_B, output => reg_to_tristate(2*reg_size-1 downto reg_size), en => dst(9), rst => rst_all OR rst(2), clk => clk);
	-- temp register
	temp	: entity work.nbitRegister 	generic map(n => 16)
										port map(input => bus_B, output => reg_to_tristate(3*reg_size-1 downto 2*reg_size), en => dst(10), rst => rst_all OR rst(3), clk => clk);
	-- MDR input data selection by mux 2 x 1
	MDR_mux	: entity work.nbitMux	generic map	(SEL_LINES => 1, DATA_WIDTH => reg_size)
									port map	(sel => mem_read_c, input => mem_data_out&bus_B, output => mux_to_mdr);
	-- memory data register
	MDR	: entity work.nbitRegister 	generic map(n => 16)
									port map(input => mux_to_mdr, output => reg_to_tristate(4*reg_size-1 downto 3*reg_size), en => dst(11) OR mem_read_c(0), rst => rst_all OR rst(4), clk => clk);

	-- memory address register
	MAR	: entity work.nbitRegister 	generic map(n => 16)
									port map(input => bus_B, output => mem_address, en => dst(12), rst => rst_all OR rst(5), clk => clk);

	add_tri:  FOR i IN  0 TO  4 GENERATE
	-- tri_state_buffer of each special register
	tri_st_buffer : entity work.nbitTristate GENERIC MAP(n => reg_size) 
					PORT MAP (en=>src(i+8), input=>reg_to_tristate((i+1)*reg_size -1 DOWNTO i*reg_size), output=>bus_A);
	END GENERATE;

	-- ram requests generator
	req_gen	:	entity work.ramRequestsGenerator port map(clk => clk, read_c => mem_read_c(0), write_c => mem_write_c(0), WMFC => wmfc_c, MFC => mfc, run => run);

	-- ram 
	ram	: entity work.ram	generic map (ram_size	=> 2000, bus_width => 16, ram_address_size => 11)
							port map	(clk => clk, we => mem_write, re => mem_read, address => mem_address, datain => reg_to_tristate(4*reg_size-1 downto 3*reg_size), dataout => mem_data_out, mfc => mfc);
	
	-- state register
	state	:	entity work.nbitRegister	generic map(n => 2)
											port map(input => state_inc_out, output => state_inc_in, en => '1', rst => state_rst, clk => state_clk);
	-- incrementer for the state register
	state_inc	:	entity work.nbitIncrementer generic map(n => 2) port map(input => state_inc_in, output => state_inc_out);
	
END ARCHITECTURE arch;
