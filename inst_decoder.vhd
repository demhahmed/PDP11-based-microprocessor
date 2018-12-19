LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY inst_decoder IS
  PORT
  (
    ir  : IN    std_logic_vector(15 DOWNTO 0);
    op_type : out std_logic_vector(1 downto 0);
    inst_type      : out std_logic_vector(3 DOWNTO 0)    

  );
END ENTITY inst_decoder;

ARCHITECTURE a OF inst_decoder IS
signal temp: std_logic_vector(1 downto 0);
begin
optype: entity work.op_type_decoder  port map( ir  ,temp);

instype: entity work.operation_decoder port map(temp, ir, inst_type);
op_type <= temp;
end architecture;
