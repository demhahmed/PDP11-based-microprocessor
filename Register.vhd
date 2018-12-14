LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY nRegister IS
GENERIC (n: integer:=16);
PORT (	input: IN std_logic_vector (n-1 DOWNTO 0);
	output: OUT std_logic_vector (n-1 DOWNTO 0);
	en,clk,rst: IN std_logic);
END ENTITY nRegister;


ARCHITECTURE nRegArc OF nRegister IS
BEGIN

output <= (others => '0') when rst = '1'
else input when en='1' AND rising_edge(clk);

END ARCHITECTURE;