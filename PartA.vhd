LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PartA IS
  GENERIC( reg_size : integer := 16);
  PORT(
    A,B : IN std_logic_vector(reg_size-1 DOWNTO 0);
    Cin : IN std_logic;
    Sel : IN std_logic_vector(1 DOWNTO 0);
    Cout : OUT std_logic;
    F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
END ENTITY PartA;

ARCHITECTURE structural OF PartA IS
  COMPONENT my_nadder IS
    GENERIC( n : integer := 8);
      PORT(
        A,B : IN std_logic_vector(n-1 DOWNTO 0); 
        Cin : IN  std_logic;
        Cout : OUT std_logic;
        F : OUT std_logic_vector(n-1 DOWNTO 0));
  END COMPONENT my_nadder;
  SIGNAL operand: std_logic_vector(reg_size-1 DOWNTO 0);
  
  BEGIN
    operand <= (OTHERS => '0') WHEN Sel = "00"
    ELSE B WHEN Sel = "01"
    ELSE NOT B WHEN Sel = "10"
    ELSE (OTHERS => '1') WHEN Cin = '0'
    ELSE NOT A;
    addr : my_nadder GENERIC MAP(16) PORT MAP(A, operand, Cin, Cout, F);
    
END ARCHITECTURE structural;
