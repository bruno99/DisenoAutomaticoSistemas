
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.ALL;
use ieee.std_logic_textio.all;


entity tb_sumador is
--  Port ( );
end tb_sumador;

architecture Behavioral of tb_sumador is
component add_n is
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
DUT: add_n generic map (n => 8) port map 
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
   variable wline, rline: line;
   variable datos: std_logic_vector(16 downto 0);
   
begin
file_open(fstatus, infile, "D:\p3.txt", read_mode);--como ignorar las comas
--while haya datos en el fichero
readLine(infile, rline);
read(rline, datos);
a <= datos(7 downto 0);
b<= datos (15 downto 8);
c_in <= datos(16);
wait for 10ns;
--fichero en modo escritura para la salida file_open(fstatus, infile, "D:\p3out.txt", write_mode);
file_close(infile); wait;
end process;


end Behavioral;
