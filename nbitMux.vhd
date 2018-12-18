LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


ENTITY nbitMux is
    GENERIC
    (
        SEL_LINES   : integer := 1;
        DATA_WIDTH  : integer := 16
    );
    PORT
    (
        sel     : IN    std_logic_vector(SEL_LINES-1 DOWNTO 0);
        input   : IN    std_logic_vector((2**SEL_LINES * DATA_WIDTH)-1 DOWNTO 0);
        output  : OUT   std_logic_vector(DATA_WIDTH-1 DOWNTO 0)
    );
    
END ENTITy nbitMux;

architecture behavioural of nbitMux is

begin

    output <= input((to_integer(unsigned(sel))+1)*DATA_WIDTH - 1 DOWNTO to_integer(unsigned(sel)) * DATA_WIDTH);

end behavioural ; -- behavioural