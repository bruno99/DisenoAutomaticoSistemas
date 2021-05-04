library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab_4 is
   port( clk, rst: in std_logic;  
         pixel_data: in std_logic_vector(7 downto 0);
         hsync, vsync: out std_logic;
         rgb_data: out  std_logic_vector(7 downto 0);
         read_addr: out std_logic_vector(18 downto 0)
         );
end lab_4;
architecture Behavioral of lab_4 is
--define controller
component controlador is 
    port(
clk, rst: in std_logic; 
pixelData: in std_logic_vector(7 downto 0); 
hsync, vsync: out std_logic;
rgb_data: out std_logic_vector(7 downto 0); 
read_addr: out std_logic_vector(18 downto 0)
);
end component;

--define memory wrapper
component memory_wrapper is
port(
    clk : IN STD_LOGIC;
    addr : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;
--definimos señales
signal addr_aux: std_logic_vector(18 downto 0);
signal data_wrap:std_logic_vector(7 downto 0); 
begin
--instanciar memory_wrapper
MEMORY: memory_wrapper port map(
clk => clk,
addr => addr_aux,
data => data_wrap
);
--instanciar  controlador
CONTROLLER: controlador port map(
clk => clk,
rst => rst,
pixelData => data_wrap,
hsync => hsync,
vsync => vsync,
rgb_data => rgb_data,
read_addr => addr_aux
);
--conectamos señales
read_addr <= std_logic_vector(addr_aux(18 downto 0));
rgb_data <= std_logic_vector(data_wrap(7 downto 0)); 
end Behavioral;
