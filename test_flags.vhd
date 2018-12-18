LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu_test IS
END alu_test;


ARCHITECTURE testbench OF alu_test IS

	signal A,B 			: std_logic_vector(7 DOWNTO 0);
	signal Cin			: std_logic;
	signal Sel 			: std_logic_vector(3 DOWNTO 0);
	signal Cout,Zout,Vout,Nout 	: std_logic;
	signal F 			: std_logic_vector(7 DOWNTO 0);

	
	BEGIN
	alu_new		:	entity work.ALU 	GENERIC MAP (reg_size => 8) 
										PORT MAP (A=>A, B=>B, Cin=>Cin, sel=>sel, F=>F, Cout=>Cout,Zout=>Zout,Vout=>Vout,Nout=>Nout);
	PROCESS
			BEGIN
--------------------------------------------ZERO FLAG----------------------------------------------------------
				A	<= "00000000";
				B       <= "00000000";
				Cin     <= '0';
 				sel     <= "0000";
				
				ASSERT(Zout = '1')
				REPORT  "Error in Zero flag - partA"
				SEVERITY ERROR;
				

				A	<= "00000000";
				B       <= "00000000";
				Cin     <= '0';
 				sel     <= "0100";
				
				ASSERT(Zout = '1')
				REPORT  "Error in Zero flag - partB"
				SEVERITY ERROR;
				
				A	<= "00000000";
				B       <= "00000000";
				Cin     <= '0';
 				sel     <= "1000";
				
				ASSERT(Zout = '1')
				REPORT  "Error in Zero flag - partC"
				SEVERITY ERROR;
				
				A	<= "00000000";
				B       <= "00000000";
				Cin     <= '0';
 				sel     <= "1100";
				
				ASSERT(Zout = '1')
				REPORT  "Error in Zero flag - partD"
				SEVERITY ERROR;

---------------------------------------------OVERFLOW FLAG---------------------------------------------------------------
				A	<= "01111111";
				B       <= "01111111";
				Cin     <= '0';
 				sel     <= "0001";
				
				ASSERT(Vout = '1')
				REPORT  "Error in overflow flag at adding"
				SEVERITY ERROR;

				
				A	<= "01111111";
				B       <= "10001111";
				Cin     <= '0';
 				sel     <= "0010";
				
				ASSERT(Vout = '1')
				REPORT  "Error in overflow flag at subtracting"
				SEVERITY ERROR;
	
				WAIT;
		END PROCESS;

		
		process
		begin
			--clock <= not clock;
			--WAIT FOR 0.5 ns;
			--clock <= not clock;
			--wait FOR 0.5 ns;
		end process ; -- switch_clock
				
END ARCHITECTURE;