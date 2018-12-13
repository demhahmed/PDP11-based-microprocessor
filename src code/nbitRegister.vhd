LIBRARY IEEE;
USE IEEE.std_Logic_1164.all;

entity nbitRegister is
generic(n: integer:= 16);
port( 
	input:in std_logic_vector(n-1 downto 0);
	output: out std_logic_vector(n-1 downto 0);
	en, rst, clk: in std_logic
);
end entity nbitRegister;

architecture a of nbitRegister is
begin
	output <= (others=>'0') when rst='1'
	else input when en='1' and rising_edge(clk);

end architecture;

