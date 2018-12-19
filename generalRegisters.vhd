LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY generalRegisters IS
	GENERIC
	(
		REGS_COUNT  : integer := 8;
		BUS_WIDTH : integer := 16
	);
	PORT
	(
		clk			: IN    std_logic;
		rst			: IN    std_logic;
		en_dst		: IN    std_logic;
		en_src		: IN    std_logic;
		src, dst	: IN    std_logic_vector(REGS_COUNT-1 DOWNTO 0);
		bus_A		: OUT 	std_logic_vector(BUS_WIDTH-1 DOWNTO 0);
		bus_B		: IN 	std_logic_vector(BUS_WIDTH-1 DOWNTO 0)
	);
END ENTITY generalRegisters;

ARCHITECTURE behavioural OF generalRegisters IS
  
  -- a temp to connect each register with its corresponding tri_state_buffer
  -- its size = number of registers * width of each register
  SIGNAL  temp	: std_logic_vector((REGS_COUNT)*(BUS_WIDTH)-1 DOWNTO 0);
  
  BEGIN

		loop1:  FOR i IN  0 TO  REGS_COUNT-1 GENERATE
		-- tri_state_buffer of i's register
		tri_st_buffer : entity work.nbitTristate GENERIC MAP(n => BUS_WIDTH) 
						PORT MAP (en=>src(i) and en_src, input=>temp((i+1)*BUS_WIDTH -1 DOWNTO i*BUS_WIDTH), output=>bus_A);
		reg           : entity work.nbitRegister GENERIC MAP(n => BUS_WIDTH) 
						PORT MAP (clk=>clk, rst=>rst, en=>dst(i) and en_dst, input=>bus_B, output=>temp((i+1)*BUS_WIDTH -1 DOWNTO i*BUS_WIDTH));
		END GENERATE;

            
END ARCHITECTURE;

