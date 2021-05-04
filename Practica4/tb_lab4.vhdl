

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use ieee.std_logic_textio.all;

entity tb_lab4 is
--  Port ( );
end tb_lab4;

architecture Structural of tb_lab4 is
    component lab_4 is 
    port( clk, rst: in std_logic;  
         pixel_data: in std_logic_vector(7 downto 0);
         hsync, vsync: out std_logic;
         rgb_data: out  std_logic_vector(7 downto 0);
         read_addr: out std_logic_vector(18 downto 0)
         );
    end component;
    signal clk, rst, hsync, vsync:std_logic;  
    signal pixel_data, rgb_data: std_logic_vector(7 downto 0);
    signal read_addr:std_logic_vector(18 downto 0);
begin
    DUT : lab_4 port map(clk => clk,
     rst=> rst,
      hsync=>hsync,
      vsync=>vsync,      
      pixel_data=>pixel_data,
      rgb_data=>rgb_data,
      read_addr=>read_addr);
    
    process begin
       clk <= '1'; wait for 10ns;
       clk <= '0'; wait for 10ns;
    end process;
    process begin
    rst<= '1';
    wait;
    end process;
process is 
file infile, outfile : text;
variable fstatus: file_open_status;
variable wline, rline: line;
variable x_file, y_file : std_logic_vector(7 downto 0);
variable cin_file: std_logic;
variable COMA : character;
begin

file_open(fstatus, outfile, "C:\project_1\p4out.txt", write_mode);
assert fstatus = open_ok 
report "error"
   severity failure;
while (true) loop
   write(wline, now);
   write(wline, string'(": "));
   write(wline, hsync, right, 1);
   write(wline, string'(" "));
   write(wline, vsync, right, 1);
   write(wline, string'(" "));
   write(wline, rgb_data( 7 downto 5));
   write(wline, string'(" "));
   write(wline, rgb_data( 4 downto 2));
   write(wline, string'(" "));
   write(wline, rgb_data( 1 downto 0));
   writeline(outfile, wline); wait for 10ns;
end loop;
file_close(outfile);
file_close(infile);
end process;
end Structural;
