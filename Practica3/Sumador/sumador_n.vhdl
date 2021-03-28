library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; use ieee.std_logic_unsigned.all;

entity sumador_n is
  generic(n: integer:=8);
  port (CLK, RST: in std_logic;
        a, b: in std_logic_vector(n-1 downto 0);
        c_in: in std_logic;
        s: out std_logic_vector(n-1 downto 0); 
        c_out: out std_logic);
end sumador_n;

architecture circuito of sumador_n is
  signal c: std_logic_vector(n downto 0);
begin
  c(0) <= c_in;
  sumador: for i in 0 to n-1 generate
    puertas: entity work.sumador port map (a(i), b(i), c(i), c(i+1), s(i)); 
  end generate;
  c_out <= c(n);
end circuito;
