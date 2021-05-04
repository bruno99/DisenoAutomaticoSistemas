
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity controlador is
port(
clk, rst: in std_logic; 
pixelData: in std_logic_vector(7 downto 0); 
hsync, vsync: out std_logic;
rgb_data: out std_logic_vector(7 downto 0); 
read_addr: out std_logic_vector(18 downto 0)
);
end controlador;

architecture Behavioral of controlador is
   signal addr_aux: std_logic_vector(18 downto 0) := (others => '0');
begin
  process(clk)
    variable count_h: integer := 1;
    variable count_v: integer := 1;
    begin 
      if(rising_edge(clk)) then
        if(rst = '1') then
           hsync <= '1';
           vsync <= '1';
           rgb_data <= (others => '0');
           count_h := 1;
           count_v := 1;
           addr_aux <= (others => '0');
        else
          if(count_v < 525 and count_h < 800) then 
            if(count_h >= 640 or count_v >= 480) then
                rgb_data <= (others => '0');
                if(count_v >= 490 and count_v < 492) then
                  vsync <= '0';
                  report("count_v is: "& integer'image(count_v));
                else
                  vsync <= '1';
                end if;
                if(count_h >= 656 and count_h < 752) then
                  hsync <= '0';
                else
                  hsync <= '1';
                end if;
             else
                rgb_data <= pixelData;
                vsync <= '1';
                hsync <= '1';
             end if;
             count_h := count_h +1;
             addr_aux <= std_logic_vector(unsigned(addr_aux) + 1);
           else
             if(count_h = 800) then
                count_v := count_v + 1;
                count_h := 1;
             end if;
             if(count_v = 525) then
                count_h := 1;
                count_v := 1;
             end if;
               addr_aux <= (others => '0');
             end if;
           end if;
         end if;
       end process;
       read_addr <= addr_aux;

end Behavioral;
