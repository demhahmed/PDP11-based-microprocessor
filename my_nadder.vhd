LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY my_nadder IS
  GENERIC( n : integer := 8);
	PORT(
	  A,B : IN std_logic_vector(n-1 DOWNTO 0); 
	  Cin : IN  std_logic;
		Cout : OUT std_logic;
		F : OUT std_logic_vector(n-1 DOWNTO 0));
END my_nadder;

ARCHITECTURE a_my_adder OF my_nadder IS
	SIGNAL temp : std_logic_vector(n DOWNTO 0);
	COMPONENT my_adder IS
	   PORT(
	     A,B,Cin : IN  std_logic;
	     F, Cout : OUT std_logic );
  END COMPONENT my_adder;
  
	BEGIN
	  temp(0) <= Cin;
	  loop1: FOR i IN 0 TO n-1 GENERATE
	     addr: my_adder PORT MAP(A(i), B(i), temp(i), F(i), temp(i+1));
	  END GENERATE;
	  Cout <= temp(n);
	  	  
END ARCHITECTURE a_my_adder;
