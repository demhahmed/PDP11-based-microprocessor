LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY startingAddressGeneratorTest IS
END startingAddressGeneratorTest;


ARCHITECTURE testbench OF startingAddressGeneratorTest IS
		
	signal flags		:	std_logic_vector(3  downto 0) := (others => '0');	
	signal IR_reg		:	std_logic_vector(15  downto 0) := (others => '0');
	signal mPC			:	std_logic_vector(15 downto 0) := (others => '0');
	signal control_word	:	std_logic_vector(39 downto 0) := (others => '0');
	signal new_mPC		:	std_logic_vector(15 downto 0) := (others => '0');

	signal zero_flag	:		std_logic;
	signal carry_flag	:		std_logic;
	signal IR_reg      :     std_logic_vector(15 downto 0);
	signal mPC         :     std_logic_vector(15 downto 0);
	signal branch_z	:		std_logic;
	signal branch_c	:		std_logic;
	signal branch	:		std_logic;
	signal new_mPC	:	std_logic_vector(15 downto 0);
	
	BEGIN
	add_gen		:	entity work.startingAddressGenerator	PORT MAP (flags, IR_reg, mPC, control_word, new_mPC);
	PROCESS
			BEGIN
		    -- flags(2) = zero flag, flags(0) = carry flag, control_Word(0) = unconditional Branch, control_word(1) = branch if zero, control_word(2) = branch if carry
				flags <= "010	src(12 downto 8) = control(5)&)&&
				0";
				wait for 1 ns;
				-- no branch
				assert (new_mPC = X"0001") REPORT "error in 1" severity error;

				control_word(0) <= '1';
				wait for 1 ns;
				-- branch unconditional
				assert (new_mPC = X"0000") REPORT "error in 2" severity error;

				control_word(0) <= '0';
				control_word(1) <= '1';
				wait for 1 ns;
				-- branch because of zero
				assert (new_mPC = X"0000") REPORT "error in 3" severity error;

				control_word(2) <= '1';
				wait for 1 ns;
				-- no branch because of zero and carry
				assert (new_mPC = X"0001") REPORT "error in 4" severity error;

				flags <= "0101";
				wait for 1 ns;
				-- branch because of zero
				assert (new_mPC = X"0000") REPORT "error in 5" severity error;

				WAIT;
		END PROCESS;				
END ARCHITECTURE;