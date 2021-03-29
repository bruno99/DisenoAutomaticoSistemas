

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use ieee.std_logic_textio.all;

entity tb_sumador_n is
--  Port ( );
end tb_sumador_n;

architecture Behavioral of tb_sumador_n is
component sumador_n is
    generic (n : integer := 8);
    Port(CLK, RST: in std_logic; 
         a, b: in std_logic_vector(n-1 downto 0);
         c_in: in std_logic;
         s: out std_logic_vector(n-1 downto 0); 
         c_out: out std_logic);
end component;
signal CLK, RST, c_in, c_out: std_logic;
signal a, b, s: std_logic_vector(7 downto 0);

begin
DUT: sumador_n generic map (n => 8) port map 
(CLK => CLK,
 RST => RST,
 a => a,
 b=> b,
 c_in => c_in,
 s => s,
 c_out => c_out
 );
 process begin
 RST <= '0';
 CLK <= '0'; wait for 10ns;
 CLK <= '1'; wait for 10ns;
 end process;
process is
   file infile, outfile : text;
   variable fstatus: file_open_status;
   variable ESPACIO : character;
   variable wline, rline: line;
   variable datos_a: std_logic_vector(7 downto 0);
   variable datos_b: std_logic_vector(15 downto 8);
   variable datos_c: std_logic;
   
   
begin
file_open(fstatus, infile, "D:\p3.txt", read_mode);
file_open(fstatus, outfile, "D:\p3out.txt", write_mode);

while not endfile(infile) loop

readLine(infile, rline);
read(rline, datos_a);
read (rline, ESPACIO);
read(rline, datos_b);
read (rline, ESPACIO);
read(rline, datos_c);

a <= datos_a;
b<= datos_b;
c_in <= datos_c;

wait for 10ns;


write(wline, s, right, 8);
writeline(outfile, wline);

end loop;
file_close(outfile);
file_close(infile); wait;
end process;


end Behavioral;
