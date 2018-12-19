LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY op_type_decoder IS
  PORT
  (
    ir  : IN    std_logic_vector(15 DOWNTO 0);
    op_type      : out std_logic_vector(1 DOWNTO 0)
  );
END ENTITY op_type_decoder;

ARCHITECTURE a OF op_type_decoder IS
begin

op_type <= "00" when (ir(15) and ir(14) and ir(13) and ir(12)) = '1'  --nop
else "01" when ((not(ir(15)) and not(ir(14))) or (not(ir(15)) and ir(14)) or (ir(15) and not(ir(14)))) = '1' --twop
else "10" when (ir(15) and ir(14) and not(ir(13))) = '1' --oneop
else "11" when (ir(15) and ir(14) and ir(13) and not(ir(12))) = '1'; --branch

end architecture;
