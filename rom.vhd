LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY rom IS
	generic( 
		rom_size: integer:=65536;	-- number of rows
		cw_width: integer:=40; 	-- width of cw
	   	rom_address_size: integer:=16	-- address selection lines
	);
	
	PORT(
		clk : IN std_logic;
		address : IN  std_logic_vector(rom_address_size-1 DOWNTO 0);
		control_word : OUT std_logic_vector(cw_width-1 DOWNTO 0));
END ENTITY rom;

ARCHITECTURE syncrom OF rom IS

	TYPE rom_type IS ARRAY(0 TO rom_size - 1) OF std_logic_vector(cw_width-1 DOWNTO 0);
	-- SIGNAL rom : rom_type := (0 => X"00C3", 16#38# => X"00C3", 16#39# => X"0000", 1=> X"0038", 2=>X"0000", 16#3A# => X"00C3", others => X"0000");
	SIGNAL rom : rom_type := (others => X"0000000000");
	
	BEGIN
		PROCESS(clk) IS
            BEGIN
                if falling_edge(clk) then 
		            control_word <= rom(to_integer(unsigned(address)));
				END IF;
		END PROCESS;
END syncrom;
