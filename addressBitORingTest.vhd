LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY addressBitORingTest IS
END addressBitORingTest;


ARCHITECTURE testbench OF addressBitORingTest IS

	signal state		:	std_logic_vector(1  downto 0) := (others => '0');	
	signal IR_reg		:	std_logic_vector(15  downto 0) := (others => '0');
	signal address		:	std_logic_vector(11 downto 0) := (others => '0');
	
	BEGIN   
	add_gen		:	entity work.addressBitORing	PORT MAP (state => state, IR => IR_reg, address => address);
	PROCESS
			BEGIN
		    -- flags(2) = zero flag, flags(0) = carry flag, control_Word(0) = unconditional Branch, control_word(1) = branch if zero, control_word(2) = branch if carry
				wait for 1 ns;
				-- no branch001
                assert (address ="000000000000") REPORT "error in 1" severity error; -- move
                

				state <= "01";
				wait for 1 ns;
                assert (address = "001000000000") REPORT "error in 2" severity error;
                
                IR_reg <= "0000010000011000";
				wait for 1 ns;
                assert (address = "001000010000") REPORT "error in 2" severity error;

                state <= "10";
                wait for 1 ns;
                assert (address = "001000010000") REPORT "error in 2" severity error;

                

				-- control_word(0) <= '0';
				-- control_word(1) <= '1';
				-- wait for 1 ns;
				-- -- branch because of zero
				-- assert (new_mPC = X"0000") REPORT "error in 3" severity error;

				-- control_word(2) <= '1';
				-- wait for 1 ns;
				-- -- no branch because of zero and carry
				-- assert (new_mPC = X"0001") REPORT "error in 4" severity error;

				-- flags <= "0101";
				-- wait for 1 ns;
				-- -- branch because of zero
				-- assert (new_mPC = X"0000") REPORT "error in 5" severity error;

				WAIT;
		END PROCESS;				
END ARCHITECTURE;