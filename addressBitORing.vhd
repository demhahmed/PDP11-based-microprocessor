LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity addressBitORing is
    port (
        state   :   IN  std_logic_vector(1 downto 0);
        IR      :   IN  std_logic_vector(15 downto 0);
        address :   OUT std_logic_vector(11 downto 0)
    );
end addressBitORing ;

architecture arch of addressBitORing is

    signal base_address :   std_logic_vector(11 downto 0);
    signal to_be_ORd    :   std_logic_vector(11 downto 0);

    signal sel          :   std_logic_vector(1 downto 0);
    signal address_mode :   std_logic_vector(2 downto 0);
    signal op_id        :   std_logic_vector(3 downto 0);
    signal op_type      :   std_logic_vector(1 downto 0);
    signal address_sel  :   std_logic_vector(0 downto 0);
    signal reg_direct   :   std_logic;

begin

    inst_decoder    :   entity work.inst_decoder port map(ir => IR, op_type => op_type, inst_type => op_id);

    base_mux    :   entity work.nbitMux generic map(SEL_LINES => 2, DATA_WIDTH => 12)
                                        port map(sel => sel, input => "011000000000" & "010000000000" & "001000000000" & "000000000000", output => base_address);
    or_mux      :   entity work.nbitMux generic map(SEL_LINES => 2, DATA_WIDTH => 12)
                                        port map(sel => sel, input => ("000"&op_type&op_id&"000")&("000000"&address_mode&reg_direct&"00")&("000000"&address_mode&reg_direct&"00")&"000000000000", output => to_be_ORd);
    address_mux :   entity work.nbitMux generic map(SEL_LINES => 1, DATA_WIDTH => 3)
                                        port map(sel => address_sel, input => IR(11 downto 9) & IR(5 downto 3), output => address_mode);
    reg_direct <=   '1' when not (address_mode(0) and address_mode(1) and address_mode(2))
            else    '0';
    address_sel <=  "1" when (state = "01" and op_type = "10") or (state = "10" and op_type = "01")
            else    "0";
    address <= base_address OR to_be_ORd;

    sel    <=   "00" when (state = "00")
        else    "01" when (state = "01" and op_type = "01")
        else    "10" when (state = "01" and op_type = "10") or (state = "10" and op_type = "01")
        else    "11" when (state = "01" and op_type = "11") or (state = "10" and op_type = "10") or (state = "11" and op_type = "01") or (state = "01" and op_type = "00");


end architecture ; -- arch