library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab_final is
   port( clk, rst, ena, b1, b2: in std_logic;  
         hsync, vsync: out std_logic;
         rgb_data: out  std_logic_vector(7 downto 0);
         read_addr: out std_logic_vector(18 downto 0)
         );
end lab_final;
architecture Behavioral of lab_final is
--define controller
component controlador is 
    port(
b1, b2: in std_logic;
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
    clk, ena: IN STD_LOGIC;
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
ena => ena,
addr => addr_aux,
data => data_wrap
);
--instanciar  controlador
CONTROLLLER: controlador port map(
b1 => b1,
b2 => b2,
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
end Behavioral;
