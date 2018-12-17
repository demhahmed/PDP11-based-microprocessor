LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY adder IS
	PORT(
	  A,B,Cin : IN  std_logic;
	  F, Cout : OUT std_logic );
END adder;

ARCHITECTURE arch OF adder IS
	BEGIN
		PROCESS ( A ,B , Cin)
			BEGIN 
				F <= A XOR B XOR Cin;
				Cout <= (A AND B) OR (Cin AND (A XOR B));
		END PROCESS;
END adder;