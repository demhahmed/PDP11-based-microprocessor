LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY main IS
  GENERIC( reg_size : integer := 16);
  PORT(
    busA,busB : INOUT std_logic_vector(reg_size-1 DOWNTO 0);
    Sel_operation : IN std_logic_vector(3 DOWNTO 0) ;
    alu_Cout: OUT std_logic;
    alu_en,alu_clk,alu_rst,alu_Cin: IN std_logic);
END ENTITY main;


ARCHITECTURE arch OF main IS
COMPONENT nRegister IS
	GENERIC (n: integer:=16);
	PORT (	input: IN std_logic_vector (n-1 DOWNTO 0);
		output: OUT std_logic_vector (n-1 DOWNTO 0);
		en,clk,rst: IN std_logic);
END COMPONENT nRegister;

COMPONENT ALU IS
GENERIC (reg_size: integer:=16);
  PORT(
    A,B : IN std_logic_vector(reg_size-1 DOWNTO 0);
    Cin : IN std_logic;
    Sel : IN std_logic_vector(3 DOWNTO 0);
    Cout : OUT std_logic;
    F : OUT std_logic_vector(reg_size-1 DOWNTO 0));
END COMPONENT ALU;

SIGNAL yout : std_logic_vector(reg_size-1 DOWNTO 0);
BEGIN

y: nRegister generic map(16) port map(busA,yout,alu_en,alu_clk,alu_rst);
alu_module: ALU generic map(16) port map(yout,busA,alu_Cin,Sel_operation,alu_Cout,busB);

END ARCHITECTURE arch;