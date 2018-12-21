library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;
USE IEEE.math_real.all;

entity decoder is
generic(n: integer:=2);
port(
	input :in std_logic_vector(n-1 downto 0);
	output :out std_logic_vector((2**n)-1 downto 0);
	en :in std_logic
);
end decoder;

architecture a of decoder is
begin

	output <= (to_integer(unsigned(input))=>'1', others => '0') when en = '1'
	else  (others => '0') ;

end architecture;

