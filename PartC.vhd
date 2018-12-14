LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PartC IS
  GENERIC( reg_size : integer := 16);
  PORT(
    A : IN std_logic_vector(reg_size-1 DOWNTO 0);
    Cin: IN std_logic;
		Sel : IN std_logic_vector(1 DOWNTO 0);
		Cout : OUT std_logic;
		F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
END ENTITY PartC;

ARCHITECTURE rights OF PartC IS
  BEGIN
    Cout <= A(0);
    F <= '0'&A(15 DOWNTO 1) WHEN Sel = "00"
    ELSE A(0)&A(15 DOWNTO 1) WHEN  Sel = "01"
    ELSE Cin&A(15 DOWNTO 1) WHEN Sel = "10"
    ELSE A(15)&A(15 DOWNTO 1);
END ARCHITECTURE rights;
  