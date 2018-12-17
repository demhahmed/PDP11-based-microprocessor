LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_test IS
END register_test;


ARCHITECTURE testbench OF register_test IS
		
	signal clock		: std_logic := '0';
	signal rst			: std_logic;

	signal src, dst		:	std_logic_vector(7 downto 0);
	signal en_src, en_dst:	std_logic;
	signal bus_A, bus_B	:	std_logic_vector(15 downto 0);	

	
	BEGIN
	gen_reg		:	entity work.generalRegisters 	GENERIC MAP (REGS_COUNT => 8, BUS_WIDTH => 16) 
										PORT MAP (clk=>clock, rst=>rst, en_dst=>en_dst, en_src=>en_src, src=>src, dst=>dst, bus_A=>bus_A, bus_B=>bus_B);
	PROCESS
			BEGIN

				en_src	<=	'0';
				rst <= '1';
				wait for 1 ns;
				rst <= '0';
				--	Load data 7777 to r1
			
				bus_B <= X"7777";
				-- rst <= '1';	
				en_dst <= '1';
				dst 	<= X"01";
				WAIT FOR 1 ns;
				en_dst	<=	'0';

				-- check
				bus_A <= "ZZZZZZZZZZZZZZZZ";
				WAIT FOR 1 ns;
				en_src	<=	'1';
				src	<= X"01";
				WAIT FOR 1 ns;
				
				ASSERT(bus_A = X"7777")
				REPORT  "Error in bus_A value read"
				SEVERITY ERROR;

				en_src	<= '0';	


				-- --	Load data 9889h to r0
				-- buss <= X"9889";
				-- en_dst <= '1';
				-- dst 	<= "000";
				-- WAIT FOR 1 ns;
				-- en_dst	<=	'0';
		
				-- -- check
				-- buss <= "ZZZZZZZZZZZZZZZZ";
				-- en_src	<=	'1';
				-- src	<= "000";
				-- WAIT FOR 1 ns;

				
				-- ASSERT(buss = X"9889")
				-- REPORT  "Error in second Read"
				-- SEVERITY ERROR;

				-- en_src	<= '0';				
				
				-- -- Load address 0008 to the MAR.
				-- buss <= X"0008";
				-- en_dst <= '1';
				-- dst 	<= "100";
				-- WAIT FOR 1 ns;

				-- -- check
				-- en_dst	<=	'0';
				-- buss <= "ZZZZZZZZZZZZZZZZ";
				-- en_src	<=	'1';
				-- src	<= "100";
				-- WAIT FOR 1 ns;

				-- ASSERT(buss = X"0008")
				-- REPORT  "Error in third Read"
				-- SEVERITY ERROR;

				-- en_src	<= '0';				
				
				-- -- Read data
				-- re	<= "1";
				-- wait for 1 ns;
				-- re	<= "0";

				-- --	Store the data read from memory in register r1.
				-- buss 	<= X"0008";
				-- en_dst 	<= '1';
				-- dst 	<= "001";
				-- en_src	<=	'1';
				-- src		<=	"101";
				-- WAIT FOR 1 ns;			
				-- en_src	<=	'0';
				-- en_dst	<=	'0';

				-- -- check


				-- -- Transfer data from r3 to the MDR.
				-- buss 	<= "ZZZZZZZZZZZZZZZZ";
				-- en_src 	<= '1';
				-- src		<= "011";
				-- en_dst	<=	'1';
				-- dst		<=	"101";
				-- WAIT FOR 1 ns;			
				-- en_dst	<=	'0';
				-- en_src	<=	'0';


				-- -- check
				-- buss <= "ZZZZZZZZZZZZZZZZ";
				-- en_src	<=	'1';
				-- src	<= "011";
				-- WAIT FOR 1 ns;
				
				-- ASSERT(buss = X"7777")
				-- REPORT  "Error in forth Read"
				-- SEVERITY ERROR;
				-- en_src	<= 	'0';
				

				-- -- Write the data to the RAM.
				-- we <= '1';
				-- WAIT FOR 1 ns;
				-- we <= '0';

				-- -- check

				-- --Load address 0001 to the MAR.
				-- buss <= X"0001";
				-- en_dst	<=	'1';
				-- dst	<=	"100";
				-- WAIT FOR 1 ns;
				-- en_dst	<=	'0';

				-- -- check


				-- -- Read data (the MDR should contain the initial value of the RAM).
				-- re <= "1";
				-- WAIT FOR 1 ns;
				-- re <= "0";



				-- -- Load address 0008 to the MAR.
				-- en_dst	<= '1';
				-- dst	<=	"100";
				-- buss <=	X"0008";
				-- WAIT FOR 1 ns;

				-- -- Read data (the MDR MUST contain 7777h).
				-- re <= "1";
				-- WAIT FOR 1 ns;

				-- re <= "0";
				WAIT;
		END PROCESS;

		
		process
		begin
			clock <= not clock;
			WAIT FOR 0.5 ns;
			clock <= not clock;
			wait FOR 0.5 ns;
		end process ; -- switch_clock
				
END ARCHITECTURE;