LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity nbitJKFlipFlop is
    generic (
        n   :   integer := 1
    );
    port (
        clk     :   IN  std_logic;
        j       :   IN  std_logic_vector(n-1 downto 0);
        k       :   IN  std_logic_vector(n-1 downto 0);
        q       :   OUT std_logic_vector(n-1 downto 0);
        q_bar   :   OUT std_logic_vector(n-1 downto 0)
    ) ;
end nbitJKFlipFlop ;

architecture arch of nbitJKFlipFlop is


begin
    update_ff : process( clk )
    begin
        if rising_edge(clk) then
            for i in 0 to n-1 loop
                if j(i) = '0' and k(i) = '1' then
                    q(i)        <= '0';
                    q_bar(i)    <= '1';
                elsif j(i) = '1' and k(i) = '0' then
                    q(i)        <= '1';
                    q_bar(i)    <= '0';
                elsif j(i) = '1' and k(i) = '1' then
                    q(i)        <= not q(i);
					q_bar(i)	<= not q_bar(i);
				end if;
			end loop;
		end if;
    end process ; -- update_ff

end architecture ; -- arch