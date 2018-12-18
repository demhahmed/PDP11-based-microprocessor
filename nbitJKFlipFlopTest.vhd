LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY nbitJKFlipFlopTest IS
END nbitJKFlipFlopTest;


ARCHITECTURE testbench OF nbitJKFlipFlopTest IS
		
	signal clock		: std_logic := '0';
	signal j			: std_logic_vector(0 downto 0);
	signal k			: std_logic_vector(0 downto 0);
	signal q			: std_logic_vector(0 downto 0);
	signal q_bar		: std_logic_vector(0 downto 0);
	
	
	
	BEGIN
	ff		:	entity work.nbitJKFlipFlop	generic map(n => 1) 
		PORT MAP (clk=>clock, j => j, k => k, q => q, q_bar => q_bar);
	PROCESS
			BEGIN

				j(0) <= '0';
				k(0) <= '1';
				wait for 1 ns;
				assert (q(0) = '0' and q_bar(0) = '1')
					report "error in 1st assert" severity error;
			
				j(0) <= '1';
				k(0) <= '0';
				wait for 1 ns;
				assert (q(0) = '1' and q_bar(0) = '0')
					report "error in 2 assert" severity error;
				j(0) <= '1';
				k(0) <= '1';
				wait for 1 ns;
				assert (q(0) = '0' and q_bar(0) = '1')
					report "error in 3 assert" severity error;
				j(0) <= '0';
				k(0) <= '0';
				wait for 1 ns;
				assert (q(0) = '0' and q_bar(0) = '1')
					report "error in 4 assert" severity error;
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