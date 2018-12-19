LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity startingAddressGenerator is
	port (
		zero_flag	:	IN	std_logic;
		carry_flag	:	IN	std_logic;
        IR_reg      :   IN  std_logic_vector(15 downto 0);
        mPC         :   IN  std_logic_vector(11 downto 0);
		branch_z	:	IN	std_logic;
		branch_c	:	IN	std_logic;
		branch		:	IN	std_logic;
		state		:	IN	std_logic_vector(1 downto 0);
		new_mPC     :	OUT	std_logic_vector(11 downto 0)
	) ;
end startingAddressGenerator;

architecture arch of startingAddressGenerator is

	signal inc_out : std_logic_vector(11 downto 0);
    signal branch_true : std_logic_vector (0 downto 0);
    signal new_address  :   std_logic_vector(11 downto 0);  


begin

	-- bitORing mechanism
	bitORing	:	entity work.addressBitORing port map(state => state, IR => IR_reg, address => new_address);
	-- micro program counter incrementer
	mPC_incrementer	:	entity work.nbitIncrementer generic map(n => 12)
									port map(input => mPC, output => inc_out);
	branch_true(0) <= 	branch OR (branch_z AND (NOT branch_c) and zero_flag) OR (branch_c AND (NOT branch_z) and carry_flag) OR (branch_z and branch_c and zero_flag and carry_flag);	
    -- micro pc address selector 								
	mPC_mux	: entity work.nbitMux	generic map	(SEL_LINES => 1, DATA_WIDTH => 12)
                                    port map	(sel => branch_true, input => new_address&inc_out, output => new_mPC);

end arch ; -- arch