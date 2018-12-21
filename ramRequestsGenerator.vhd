LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity ramRequestsGenerator is
	port (
		clk     			:   IN  std_logic;
		read_c, write_c 	:	IN	std_logic;  -- control signals of read and write
		MFC, WMFC			:	IN	std_logic;
		mem_read, mem_write :	OUT	std_logic;
		run					:	OUT	std_logic
) ;
end ramRequestsGenerator ;

architecture arch of ramRequestsGenerator is

	signal ff_out	:	std_logic_vector(1 downto 0);

begin

	ff	:	entity work.nbitJKFlipFlop	generic map(n => 2)
										port map(clk => clk, j => read_c&write_c, k => MFC&MFC, q => ff_out);
	run <= not (WMFC and (mem_read OR mem_write) and (not MFC));
	mem_write <= ff_out(0);
	mem_read <= ff_out(1);

end architecture ; -- arch