
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity controlador is
port(
b1, b2: in std_logic;
clk, rst: in std_logic; 
pixelData: in std_logic_vector(7 downto 0); 
hsync, vsync: out std_logic;
rgb_data: out std_logic_vector(7 downto 0); 
read_addr: out std_logic_vector(18 downto 0)
);
end controlador;

architecture Behavioral of controlador is
  signal addr_aux: std_logic_vector(18 downto 0) := (others => '0');
  signal  complemento:  std_logic_vector(8 downto 0);
  signal  negative:  std_logic_vector(8 downto 0);
begin
  process(clk, b1, b2)
    variable count_h: integer := 1;
    variable count_v: integer := 1;
    variable count: integer := 1;
   
    begin 
      if(rising_edge(clk)) then
        if(rst = '1') then
           hsync <= '1';
           vsync <= '1';
           rgb_data <= (others => '0');
           count_h := 1;
           count_v := 1;
           count := 1;
           addr_aux <= (others => '0');
        else
          if(count_v < 524 and count_h < 799) then 
            if(count_h >= 639 or count_v >= 479) then
                rgb_data <= (others => '0');
                if(count_v >= 490 and count_v < 491) then
                  vsync <= '0';
                  report("count_v is: "& integer'image(count_v));
                else
                  vsync <= '1';
                end if;
                if(count_h >= 656 and count_h < 751) then
                  hsync <= '0';
                else
                  hsync <= '1';
                end if;
             else
                if(b1 >= '1') then
                --Umbralizado
                if(pixelData(7) >= '1') then
                 rgb_data <= "11111111";
                 else
                 rgb_data <= "00000000";
                 end if;
                 --Fin del umbralizado
                 else 
                 --filtro
                   if(b2 >= '1') then
                   
                     if(count = 1) then 
                     --complemento a 2 para negativo pixel 
                     complemento(7 downto 0) <= pixeldata XOR "11111111";
                     complemento(8) <= '0';
                     negative <= complemento OR "000000001";
                     rgb_data(0) <= negative(1);
                     rgb_data(1) <= negative(2);
                     rgb_data(2) <= negative(3);
                     rgb_data(3) <= negative(4);
                     rgb_data(4) <= negative(5);
                     rgb_data(5) <= negative(6);
                     rgb_data(6) <= negative(7);
                     rgb_data(7) <= '0';
                     count := 2;
                     else if (count >= 2) then
                     rgb_data <= "00000000";
                     count := 3;
                     else
                     --desplazamiento a la derecha para dividir entre 2
                     rgb_data(0) <= pixeldata(1);
                     rgb_data(1) <= pixeldata(2);
                     rgb_data(2) <= pixeldata(3);
                     rgb_data(3) <= pixeldata(4);
                     rgb_data(4) <= pixeldata(5);
                     rgb_data(5) <= pixeldata(6);
                     rgb_data(6) <= pixeldata(7);
                     rgb_data(7) <= '0';
                     count := 1;
                     end if;
                     end if;
                    
                   end if;
                 --fin de filtro
                 end if;
                vsync <= '1';
                hsync <= '1';
             end if;
             count_h := count_h +1;
             addr_aux <= std_logic_vector(unsigned(addr_aux) + 1);
           else
             if(count_h = 799) then
                count_v := count_v + 1;
                count_h := 1;
             end if;
             if(count_v = 524) then
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
