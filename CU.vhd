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
SIGNAL alu_Cin			:	std_logic;
SIGNAL alu_Cout			:	std_logic;
SIGNAL alu_operation	:	std_logic_vector(3 downto 0);
SIGNAL dst				:	std_logic_vector(10 downto 0);
SIGNAL src				:	std_logic_vector(10 downto 0);
SIGNAL rst				:	std_logic_vector(3 downto 0);		-- rst(0) indicates general purpose registers reset
signal en_gen_reg_dst	:	std_logic;
signal en_gen_reg_src	:	std_logic;


BEGIN

	y 	: 	entity work.nbitRegister generic map(n => 16)
								port map(input => bus_A, output => yout, en => y_en, clk => clk, rst => y_clear);
	alu_module: entity work.ALU generic map(reg_size => 16) 
								port map( A => yout, B => bus_A, Cin => alu_Cin, sel => alu_operation,Cout => alu_Cout,F => bus_B);
	
	-- general puspose registers

	general_purpose_registers : entity work.generalRegisters 	generic map(REGS_COUNT => REGS_COUNT)
																port map(clk => clk, rst => rst(0) or rst_all, en_dst => en_gen_reg_dst, en_src => en_gen_reg_src, src => src(7 downto 0), dst => dst(7 downto 0), bus_A => bus_A, bus_B => bus_B);

	-- instruction register
	IR : entity work.nbitRegister 	generic map(n => 16)
									port map(input => bus_B, output => bus_A, en => dst(10), rst => rst_all OR rst(3), clk => clk);

END ARCHITECTURE arch;