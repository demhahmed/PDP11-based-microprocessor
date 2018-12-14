LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ALU IS
GENERIC (reg_size: integer:=16);
  PORT(
    A,B : IN std_logic_vector(reg_size-1 DOWNTO 0);
    Cin : IN std_logic;
    Sel : IN std_logic_vector(3 DOWNTO 0);
    Cout : OUT std_logic;
    F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
END ENTITY ALU;

ARCHITECTURE structural_behavioural OF ALU IS
  COMPONENT PartA IS
    GENERIC (reg_size: integer:=16);
    PORT(
      A,B : IN std_logic_vector(reg_size-1 DOWNTO 0);
      Cin : IN std_logic;
      Sel : IN std_logic_vector(1 DOWNTO 0);
      Cout : OUT std_logic;
      F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
  END COMPONENT PartA;
  COMPONENT PartB IS
    GENERIC (reg_size: integer:=16);
    PORT(
      A,B : IN std_logic_vector(reg_size-1 DOWNTO 0);
      Sel : IN std_logic_vector(1 DOWNTO 0);
      F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
  END COMPONENT PartB;
  COMPONENT PartC IS
    
	GENERIC (reg_size: integer:=16);
	PORT(
		  A : IN std_logic_vector(reg_size-1 DOWNTO 0);
		  Cin: IN std_logic;
		  Sel : IN std_logic_vector(1 DOWNTO 0);
		  Cout : OUT std_logic;
		  F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
  END COMPONENT PartC;
  COMPONENT PartD is
    GENERIC (reg_size: integer:=16);
    PORT(
      A : IN std_logic_vector(reg_size-1 DOWNTO 0);
      Cin: IN std_logic;
      Sel : IN std_logic_vector(1 DOWNTO 0);
      Cout : OUT std_logic;
      F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
  END COMPONENT PartD;
  SIGNAL C1 : std_logic;
  SIGNAL F1 : std_logic_vector(reg_size-1 DOWNTO 0);
  SIGNAL F2 : std_logic_vector(reg_size-1 DOWNTO 0);
  SIGNAL C3 : std_logic;
  SIGNAL F3 : std_logic_vector(reg_size-1 DOWNTO 0);
  SIGNAL C4 : std_logic;
  SIGNAL F4 : std_logic_vector(reg_size-1 DOWNTO 0);
  
  BEGIN
    PartA_com : PartA PORT MAP(A, B, Cin, Sel(1 DOWNTO 0), C1, F1);
    PartB_com : PartB PORT MAP(A, B, Sel(1 DOWNTO 0), F2);
    PartC_com : PartC PORT MAP(A, Cin, Sel(1 DOWNTO 0), C3, F3);
    PartD_com : PartD PORT MAP(A, Cin, Sel(1 DOWNTO 0), C4, F4);
    
    PROCESS(A, B, Cin, Sel, F1, F2, F3, F4, C1, C3, C4)
      BEGIN
        Case Sel(3 DOWNTO 2) IS
          WHEN "00" =>
            F <= F1;
            Cout <= C1;
          WHEN "01" =>
            F <= F2;
          WHEN "10" =>
            F <= F3;
            Cout <= C3;
          WHEN "11" =>
            F <= F4;
            Cout <= C4;
          WHEN OTHERS =>
            F <= x"0000";
            Cout <= '0';
        END CASE;
    END PROCESS;
    
END ARCHITECTURE structural_behavioural;

