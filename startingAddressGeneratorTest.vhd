LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY startingAddressGeneratorTest IS
END startingAddressGeneratorTest;


ARCHITECTURE testbench OF startingAddressGeneratorTest IS
		
	
	signal zero_flag	:	std_logic :='0';
	signal carry_flag	:	std_logic :='0';
	signal IR_reg    	:	std_logic_vector(15 downto 0) := (others =>'0');
	signal mPC         	:	std_logic_vector(11 downto 0) := (others =>'0');
	signal branch_z		:	std_logic :='0';
	signal branch_c		:	std_logic :='0';
	signal branch		:	std_logic :='0';
	signal state		:	std_logic_vector(1 downto 0) := (others => '0');
	signal new_mPC		:	std_logic_vector(11 downto 0);
	
	BEGIN
	add_gen		:	entity work.startingAddressGenerator	PORT MAP (zero_flag => zero_flag,carry_flag => carry_flag,IR_reg => IR_reg, mPC => mPC,branch_z => branch_z,branch_c => branch_c,branch => branch,state => state,new_mPC => new_mPC);
	PROCESS
			BEGIN
		    -- flags(2) = zero flag, flags(0) = carry flag, control_Word(0) = unconditional Branch, control_word(1) = branch if zero, control_word(2) = branch if carry
				zero_flag <= '1';
				wait for 1 ns;
				-- no branch
				assert (new_mPC = "000000000001") REPORT "error in 1" severity error;

				branch_z <= '1';
				wait for 1 ns;
				-- branch due to zero flag and branch zero
				assert (new_mPC = "000000000000") REPORT "error in 2" severity error;
				zero_flag <= '0';
				branch_z <= '0';
				mPC <= "000000000000";
				wait for 1 ns;
				-- branch because of zero
				assert (new_mPC = "000000000001") REPORT "error in 3" severity error;
				mPC <= "000000000001";
				wait for 1 ns;
				-- no branch because of zero and carry
				assert (new_mPC = "000000000010") REPORT "error in 4" severity error;
				branch_c <= '1';
				mPC <= "000000000010";
				wait for 1 ns;
				-- branch because of zero
				assert (new_mPC = "000000000011") REPORT "error in 5" severity error;
				mPC <= "000000000011";
				carry_flag <= '1';
				wait for 1 ns;
				-- branch because of zero
				assert (new_mPC = "000000000000") REPORT "error in 6" severity error;


				WAIT;
		END PROCESS;				
END ARCHITECTURE;
