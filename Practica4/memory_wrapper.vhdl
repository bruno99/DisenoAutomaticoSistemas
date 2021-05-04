library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity memory_wrapper is
  PORT (
    clk, ena: IN STD_LOGIC;
    addr : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end memory_wrapper;

architecture Behavioral of memory_wrapper is
--definir componentes
component blk_mem is
 PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
  end component;
begin

--instanciarlo
MEMORY_GEN: blk_mem port map(
clka => clk,
ena => ena,
addra => addr,
douta => data
);
end Behavioral;
