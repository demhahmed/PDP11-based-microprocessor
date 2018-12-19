LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ramRequestsGeneratorTest IS
END ramRequestsGeneratorTest;


ARCHITECTURE testbench OF ramRequestsGeneratorTest IS
		
	signal clock		: std_logic := '0';
	signal rd, wr		: std_logic := '0';
	signal mfc, wmfc	: std_logic := '0';
	signal mr, mw   	: std_logic := '0';
	signal run			: std_logic := '1';
	
	BEGIN
	gen		:	entity work.ramRequestsGenerator    PORT MAP (clk=>clock, read_c => rd, write_c => wr, mem_read => mr, mem_write => mw, MFC => mfc, WMFC => wmfc, run => run);
	PROCESS
			BEGIN

				rd <= '1';
				wmfc <= '1';
				wait for 1 ns;
				rd <= '0';
				wait for 0.5 ns;
				assert (mr = '1' and run = '1')
					report "error in 1st cycle" severity error;

				wait for 0.5 ns;

				wait for 0.5 ns;
				assert (mr = '1' and run = '0')
					report "error in 2nd cycle" severity error;
				wait for 0.5 ns;
				
				-- simulate waiting for memory
				for i in 0 to 1 loop
					wait for 1 ns;
					assert (mr = '1' and run = '0')
					report "error in cycle number"&integer'image(i) severity error;
				end loop;
				-- memory data arrival
				mfc <= '1';
				wait for 0.5 ns;
				assert (mr = '1'and run = '1')
					report "error in 3rd cycle" severity error;
				wait for 0.5 ns;
				mfc <= '0';
				wmfc <= '0';
				wait for 1 ns;

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