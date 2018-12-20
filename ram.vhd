LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
	generic( 
		ram_size: integer:=65536;
		bus_width: integer:=16; 
	   	ram_address_size: integer:=16
	);
	
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		re	: IN std_logic;
		address : IN  std_logic_vector(ram_address_size-1 DOWNTO 0);
		datain  : IN  std_logic_vector(bus_width-1 DOWNTO 0);
		dataout : OUT std_logic_vector(bus_width-1 DOWNTO 0);
		MFC		: OUT std_logic		-- to indicate that ram has finished its job
	);
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS

	TYPE ram_type IS ARRAY(0 TO ram_size - 1) OF std_logic_vector(bus_width-1 DOWNTO 0);
	SIGNAL ram : ram_type := (others => X"0000");
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF falling_edge(clk) and we = '1' THEN  
					ram(to_integer(unsigned(address))) <= datain;
					MFC <= '1';
				ELSIF falling_edge(clk) and re = '1' THEN
					dataout <= ram(to_integer(unsigned(address)));
					MFC <= '1';
				ELSE
					MFC	<= '0';
				END IF;
		END PROCESS;
END syncrama;
