LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity controlWordGenerator is
	port (
		rst, clk	: 	IN	std_logic;
		flags		:	IN	std_logic_vector(3 downto 0);
		new_address	:	IN	std_logic_vector(15 downto 0);
		control_word:	OUT	std_logic_vector(0 downto 0)	-- TODO: ahmed input
	) ;
end controlWordGenerator;

architecture arch of controlWordGenerator is

	signal mPC_out : std_logic_vector(15 downto 0);
	signal mPC_in  : std_logic_vector(15 downto 0);
	signal inc_out : std_logic_vector(15 downto 0);
	signal branch_true : std_logic_vector (0 downto 0);
	 constant rom_size : integer := 12; -- todo ahmed input
	 constant cw_size :  integer := 12; -- todo ahmed input
	 constant rom_address_size :  integer := 12; -- todo ahmed input


begin

	-- micro program counter incrementer
	mPC_incrementer	:	entity work.nbitIncrementer generic map(n => 16)
									port map(input => mPC_out, output => inc_out );

	-- micro pc address selector 								
	mPC_mux	: entity work.nbitMux	generic map	(SEL_LINES => 1, DATA_WIDTH => 16)
									port map	(sel => branch_true, input => new_address&inc_out, output => mPC_in);
							
	-- micro program counter register
	mPC	: entity work.nbitRegister 	generic map(n => 16)
									port map(input => mPC_in, output => mPC_out, en => '1', rst => rst, clk => clk);
	-- Rom of Control word
	Rom : entity work.rom	generic map (rom_size => rom_size, cw_width => cw_size,rom_address_size =>rom_address_size)
							port 	map(clk =>clk, address =>mPC_out, control_word =>control_word);



end arch ; -- arch