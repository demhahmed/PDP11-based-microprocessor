LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PartD is
  GENERIC( reg_size : integer := 16);  
PORT(
    A : IN std_logic_vector(reg_size-1 DOWNTO 0);
		Cin: IN std_logic;
		Sel : IN std_logic_vector(1 DOWNTO 0);
		Cout : OUT std_logic;
		F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
END ENTITY PartD;

ARCHITECTURE lefts OF PartD IS
  BEGIN
    Cout <= A(15);
    F <= A(14 DOWNTO 0)&'0' WHEN Sel = "00"
    ELSE A(14 DOWNTO 0)&A(15) WHEN Sel = "01"
    ELSE A(14 DOWNTO 0)&Cin WHEN Sel = "10"
    ELSE "0000000000000000";
END ARCHITECTURE lefts;
	