
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use ieee.std_logic_textio.all;

entity tb_lab4 is
--  Port ( );
end tb_lab4;

architecture Behavioral of tb_lab4 is
component controlador is 
    port(
clk, rst: in std_logic; 
pixelData: in std_logic_vector(7 downto 0); 
hsync, vsync: out std_logic;
rgb_data: out std_logic_vector(7 downto 0); 
read_addr: out std_logic_vector(18 downto 0)
);
end component;
component memory_wrapper is
port(
    clk : IN STD_LOGIC;
    addr : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;
signal clk, rst, hsync, vsync: std_logic;
signal pixelData, rgb_data, data: std_logic_vector(7 downto 0); 
signal read_addr, addr: std_logic_vector(18 downto 0); 
signal r: std_logic_vector(2 downto 0);
signal g: std_logic_vector(2 downto 0);
signal b: std_logic_vector(1 downto 0);
begin
DUT: controlador port map(
clk => clk,
rst => rst,
pixelData => pixelData,
hsync => hsync,
vsync => vsync,
rgb_data => rgb_data,
read_addr => read_addr
);
DUT2: memory_wrapper port map(
clk => clk,
addr => addr,
data => data
);
process is 

file infile, outfile : text;
variable fstatus: file_open_status;
variable ESPACIO : character;
variable wline, rline: line;
variable pixel_data: std_logic_vector(7 downto 0);
variable hsync: std_logic;
variable vsync: std_logic;
variable r: std_logic_vector(2 downto 0);
variable g: std_logic_vector(2 downto 0);
variable b: std_logic_vector(1 downto 0);

begin
file_open(fstatus, infile, "C:\project_1\pattern.coe", read_mode);
file_open(fstatus, outfile, "C:\project_1\p4out.txt", write_mode);
while not endfile(infile) loop

--leemos la entrada
readLine(infile, rline);
read(rline, pixel_data);

wait for 10ns;

write(wline, hsync, right, 1);
write(wline, vsync, right, 1);
write(wline, r, right, 3);
write(wline, g, right, 3);
write(wline, b, right, 3);
writeline(outfile, wline);


end loop;
file_close(outfile);
file_close(infile); wait;
end process;
r <= std_logic_vector(rgb_data(7 downto 5));
g <= std_logic_vector(rgb_data(4 downto 2));
b <= std_logic_vector(rgb_data(1 downto 0));
end Behavioral;
