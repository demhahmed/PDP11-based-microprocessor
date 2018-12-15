library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity reg_file is
    generic (n: integer :=16);
    port (
        clk, mem_clk, src_en, dst_en, mdr_en, write_en : in std_logic;
        src_sel, dst_sel : in std_logic_vector(2 downto 0);
	rst : in std_logic_vector(9 downto 0);
        busb : in std_logic_vector(n-1 downto 0);
        busa : out std_logic_vector(n-1 downto 0)
    );
end entity reg_file;

architecture a of reg_file is

type outp is array (natural range <>) of std_logic_vector(n-1 DOWNTO 0);
signal reg_op : outp(7 DOWNTO 0);
    
signal tsb_en, reg_en:std_logic_vector(9 DOWNTO 0);
signal mar_out, mdr_in, mdr_out, mem_out : std_logic_vector(n-1 downto 0);
signal en : std_logic;

begin

decodeSrc: entity work.decoder generic map (3) port map(src_sel, tsb_en, src_en);
decodeDist: entity work.decoder generic map (3) port map(dst_sel, reg_en, dst_en);

loop1: for i in 0 to 7 generate
   	regs: entity work.nbitRegister generic map (16) port map(busb, reg_op(i), reg_en(i), rst(i), clk);
end generate;

loop2: for i in 0 to 7 generate
	tsbs: entity work.tristate generic map (16) port map(reg_op(i), busa, tsb_en(i));
end generate;

en <= reg_en(8) when mdr_en = '0' else '1'; 
mdr_in <= busb when mdr_en = '0' else mem_out;
MDR: entity work.nbitRegister generic map(16) port map(mdr_in, mdr_out, en, rst(8), clk);
MDR_tri: entity work.tristate generic map(16) port map(mdr_out, busa, tsb_en(8));

MAR: entity work.nbitRegister generic map(16) port map(busb, mar_out, reg_en(9), rst(9), clk);

RAM: entity work.ram port map(mem_clk, write_en, mar_out, mdr_out, mem_out);
	
end architecture;
