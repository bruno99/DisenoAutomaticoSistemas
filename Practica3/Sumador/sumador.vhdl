library ieee;
use ieee.std_logic_1164.all;
entity sumador is
  port (a, b, c_in: in std_logic; --a y b entradas, c acarreo de entrada
        c_out, s: out std_logic); --c acarreo de salida, s salida
end sumador;

architecture funcional of sumador is
begin
  s <= ((not a) and (not b) and c_in) or ((not a) and b and (not c_in)) or (a and b and c_in) or (a and (not b) and (not c_in));
  c_out <= (a and b) or (a and c_in) or (b and c_in) ; 
end funcional;
