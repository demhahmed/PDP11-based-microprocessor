LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY romTest IS
END romTest;


ARCHITECTURE testbench OF romTest IS
		
	signal clock		: std_logic := '1';
	signal data			:	std_logic_vector(15 downto 0);	
	signal address		:	std_logic_vector(7 downto 0);	

	
	BEGIN
	rom		:	entity work.rom	PORT MAP (clk=>clock, address => address, control_word => data);
	PROCESS
			BEGIN

				address <= X"00";
				wait for 1 ns;
				
				assert (data = X"00C3") REPORT "error in reading data at index 0" severity error;
				address <= X"01";
				wait for 1 ns;

				assert (data = X"0038") REPORT "error in reading data at index 1" severity error;
				address <= X"38";
				wait for 1 ns;

				assert (data = X"00C3") REPORT "error in reading data at index 0" severity error;
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