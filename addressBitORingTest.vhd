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

				state <= "01";
				IR_reg <= "0001010111111111";
				wait for 1 ns;	
                assert (address ="001000010000") REPORT "error in 1" severity error; -- fetch 1st operand for add
                
				state <= "10";
				wait for 1 ns;	
                assert (address ="010000111000") REPORT "error in 2" severity error; -- fetch 2nd operand for add

				state <= "11";
				wait for 1 ns;	
                assert (address = "011010001000") REPORT "error in 3" severity error; -- operate for add


				state <= "01";
				IR_reg <= "0001000111111111";
				wait for 1 ns;	
                assert (address ="001000000000") REPORT "error in 4" severity error; -- fetch 1st operand for add
                
				state <= "10";
				wait for 1 ns;	
                assert (address ="010000111000") REPORT "error in 5" severity error; -- fetch 2nd operand for add

				state <= "11";
				wait for 1 ns;	
                assert (address = "011010001000") REPORT "error in 6" severity error; -- operate for add
				
				state <= "01";
				IR_reg <= "0001010111000111";
				wait for 1 ns;	
                assert (address ="001000010000") REPORT "error in 7" severity error; -- fetch 1st operand for add
                
				state <= "10";
				wait for 1 ns;	
                assert (address ="010000000000") REPORT "error in 8" severity error; -- fetch 2nd operand for add

				state <= "11";
				wait for 1 ns;	
				assert (address = "011010001100") REPORT "error in 9" severity error; -- operate for add
				
				state <= "01";
				IR_reg <= "1100000000010111";
				wait for 1 ns;	
                assert (address ="010000010000") REPORT "error in 10" severity error; -- fetch 1st operand for inc
                
				state <= "10";
				wait for 1 ns;	
                assert (address ="011100000000") REPORT "error in 11" severity error; -- fetch 2nd operand for inc

				state <= "01";
				IR_reg <= "1100000000000111";
				wait for 1 ns;	
                assert (address ="010000000000") REPORT "error in 12" severity error; -- fetch 1st operand for inc
                
				state <= "10";
				wait for 1 ns;	
				assert (address ="011100000100") REPORT "error in 13" severity error; -- fetch 2nd operand for inc
				


				state <= "01";
				IR_reg <= "1110001000000111";
				wait for 1 ns;	
                assert (address ="011110010000") REPORT "error in 14" severity error; -- fetch 1st operand for BNE
                
				state <= "10";
				wait for 1 ns;	
                assert (address ="011110010100") REPORT "error in 15" severity error; -- fetch 2nd operand for BNE
				-- state <= "01";
				-- wait for 1 ns;
                -- assert (address = "001000000000") REPORT "error in 2" severity error;
                
                -- IR_reg <= "0000010000011000";
				-- wait for 1 ns;
                -- assert (address = "001000010000") REPORT "error in 2" severity error;

                -- state <= "10";
                -- wait for 1 ns;
                -- assert (address = "001000010000") REPORT "error in 2" severity error;

				WAIT;
		END PROCESS;				
END ARCHITECTURE;