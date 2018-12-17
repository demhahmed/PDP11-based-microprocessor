LIBRARY IEEE;
USE IEEE.std_Logic_1164.all;

entity nbitTristate is
generic(n: integer:= 16);
port(
	input: in std_logic_vector(n-1 downto 0);
	output: out std_logic_vector(n-1 downto 0);
	en: in std_logic
); 

end entity nbitTristate;

architecture a of nbitTristate is
begin
	output <= input when en='1'
	else (others=>'Z');

end architecture;