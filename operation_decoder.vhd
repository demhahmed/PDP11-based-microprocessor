LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY operation_decoder IS
  PORT
  (
    op_type  : IN    std_logic_vector(1 DOWNTO 0);
    ir  : IN    std_logic_vector(15 DOWNTO 0);
    inst      : out std_logic_vector(3 DOWNTO 0)
  );
END ENTITY operation_decoder;

ARCHITECTURE a OF operation_decoder IS
begin

inst <= "00"&ir(1 downto 0) when op_type = "00"
else ir(15 downto 12) when op_type = "01"
else ir(9 downto 6) when op_type = "10"
else '0'&ir(10 downto 8) when op_type = "11";  
end architecture;
