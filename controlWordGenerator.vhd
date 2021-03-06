LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity controlWordGenerator is
	port (
		rst, clk	: 	IN	std_logic;
		flags		:	IN	std_logic_vector(3 downto 0);	-- NZVC
		flags_v		:	IN	std_logic_vector(1 downto 0);	--	bc_v,bz_v
		branch		:	IN	std_logic_vector(2 downto 0);	--	bc,bz,b
		IR_reg 		: 	IN 	std_logic_vector(15 downto 0);
		run			:	IN	std_logic;		-- signal to indicate whether the mPC should stop or continue counting to next instruction
		state		:	IN	std_logic_vector(1 downto 0);
		control_word:	OUT	std_logic_vector(33 downto 0);
		branch_true	:	OUT	std_logic_vector(0 downto 0);
		temp_mpc	:	OUT	std_logic_vector(11 downto 0)   -- just to see mPC
	) ;
end controlWordGenerator;

architecture arch of controlWordGenerator is

	signal mPC_out : std_logic_vector(11 downto 0);
	signal mPC_in  : std_logic_vector(11 downto 0);
	constant rom_size : integer := 4096;
	constant cw_size :  integer := 34;
	constant rom_address_size :  integer := 12;

begin

	 -- mpc address _generator 
	-- flags(2) = zero flag, flags(0) = carry flag, control_Word(0) = unconditional Branch, control_word(1) = branch if zero, control_word(2) = branch if carry
	str_address: entity work.startingAddressGenerator port map(zero_flag => flags(2), carry_flag => flags(0), zero_flag_v => flags_v(0), carry_flag_v => flags_v(1), branch => branch (0), branch_z => branch(1), branch_c => branch(2), IR_reg => IR_reg ,mPC => mPC_out, state => state, new_mPC => mPC_in, branch_true=>branch_true);
							
	-- micro program counter register
	mPC	: entity work.nbitRegister 	generic map(n => 12)
									port map(input => mPC_in, output => mPC_out, en => run, rst => rst, clk => clk);
	-- Rom of Control word
	Rom : entity work.rom	generic map (rom_size => rom_size, cw_width => cw_size,rom_address_size =>rom_address_size)
							port 	map(clk => clk, address =>mPC_out, control_word =>control_word);


	temp_mpc <= mPC_out;

end arch ; -- arch
