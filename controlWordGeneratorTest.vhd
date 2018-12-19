LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY controlWordGeneratorTest IS
END controlWordGeneratorTest;

ARCHITECTURE testbench OF controlWordGeneratorTest IS
		
	signal clock,rst		: std_logic := '1';
	signal flags			: std_logic_vector(3 downto 0);	
    signal IR_reg           : std_logic_vector(11 downto 0);
    signal mpc              : std_logic_vector(11 downto 0);
    signal run              : std_logic;
    signal control_word     : std_logic_vector(33 downto 0)	;

	
	BEGIN
	con_w_gen		:entity work.controlWordGenerator PORT MAP (rst,clock,flags,IR_reg,run,control_word,mpc);
	PROCESS
            BEGIN
                run <= '1';
				wait for 1 ns;
				assert (control_word = X"0000000000") REPORT "error in reading data at index 0" severity error;
                flags <= "0100";
                rst <= '0';
                wait for 1 ns;
                assert (control_word = X"0000000000") REPORT "error in reading data at index 1" severity error;
                wait for 1 ns;
                assert (control_word = X"0040000000") REPORT "error in reading data at index 2" severity error;
                wait for 1 ns;
                assert (control_word = X"0040000002") REPORT "error in reading data at index 3" severity error;
                
                wait for 1 ns;
                flags <= "0000";
                assert (control_word = X"0040000000") REPORT "error in reading data at index 2" severity error;
                wait for 1 ns;
                assert (control_word = X"0040000002") REPORT "error in reading data at index 3" severity error;

                wait for 1 ns;
                assert (control_word = X"00A0000000") REPORT "error in reading data at index 4" severity error;
                wait for 1 ns;
                assert (control_word = X"0100000000") REPORT "error in reading data at index 5" severity error;
                wait for 1 ns;
                assert (control_word = X"0060000004") REPORT "error in reading data at index 6" severity error;
                wait for 1 ns;
                assert (control_word = X"0000000001") REPORT "error in reading data at index 7" severity error;
                wait for 1 ns;
                assert (control_word = X"0000000000") REPORT "error in reading data at index 8" severity error;
                
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