
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop is
   Port (CLK, RST, D: in std_logic;
         Q: out std_logic );
end flipflop;

architecture Behavioral of flipflop is

begin
process(CLK) begin
   if(rising_edge(CLK)) then
      if(RST = '1') then
         Q <= '0';
      else
         Q <= D;
      end if;
   end if;
end process;
end Behavioral;
