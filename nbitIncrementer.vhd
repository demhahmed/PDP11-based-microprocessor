LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY nbitIncrementer IS 
 GENERIC( n : integer := 8);
 PORT (
	input : IN std_logic_vector (n-1 downto 0);
	output : OUT std_logic_vector (n-1 downto 0)
);
END ENTITY nbitIncrementer ;

ARCHITECTURE arch OF nbitIncrementer IS
SIGNAL Cin : std_logic_vector (n downto 0);
BEGIN
		Cin(0) <= '1';
		loop1: FOR i IN 0 TO n-1 GENERATE
			output(i) <= input(i) XOR Cin(i);
			Cin(i+1) <=  input(i) AND Cin(i);
		END GENERATE;
END ARCHITECTURE arch; 