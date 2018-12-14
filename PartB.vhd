LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PartB IS
  GENERIC( reg_size : integer := 16);
  PORT(
    A,B : IN std_logic_vector(reg_size-1 DOWNTO 0);
		Sel : IN std_logic_vector(1 DOWNTO 0);
		F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
END ENTITY PartB;

ARCHITECTURE basic OF PartB IS
  BEGIN
    F <= A AND B WHEN Sel = "00"
    ELSE A OR B WHEN  Sel = "01"
    ELSE A XOR B WHEN Sel = "10"
    ELSE NOT A;
END ARCHITECTURE basic;
  