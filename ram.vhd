LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
	generic( 
		ram_size: integer:=64;
		bus_width: integer:=16; 
	   	ram_address_size: integer:=6
	);
	
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(ram_address_size-1 DOWNTO 0);
		datain  : IN  std_logic_vector(bus_width-1 DOWNTO 0);
		dataout : OUT std_logic_vector(bus_width-1 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS

	TYPE ram_type IS ARRAY(0 TO ram_size - 1) OF std_logic_vector(bus_width-1 DOWNTO 0);
	SIGNAL ram : ram_type := (others => X"0000");
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF falling_edge(clk) and we = '1' THEN  
					ram(to_integer(unsigned(address))) <= datain;
				END IF;
		END PROCESS;
		dataout <= ram(to_integer(unsigned(address)));
END syncrama;
