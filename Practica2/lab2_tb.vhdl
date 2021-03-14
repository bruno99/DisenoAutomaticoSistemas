library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lab2_tb is
--  Port ( );
end lab2_tb;

architecture Behavioral of lab2_tb is
component lab2 is 
   port ( clk       : in  std_logic;
           reset     : in  std_logic;
           startStop : in  std_logic;
           sevenSeg  : out std_logic_vector(6 downto 0);
           selector  : out std_logic_vector(7 downto 0)
    );
end component;
 signal clk, reset, startStop : std_logic;
 signal sevenSeg: std_logic_vector(6 downto 0);
 signal selector: std_logic_vector(7 downto 0);
 
begin
  DUT : lab2 port map(
     clk => clk,
     reset => reset,
     startStop => startStop,
     sevenSeg => sevenSeg,
     selector => selector
     
);

process begin
		clk <= '1'; wait for 5ns;
		clk <= '0'; wait for 5ns;
end process;
process begin
startStop <= '1'; wait for 2000000000ns;
startStop <= '1'; wait for 2000000000ns;
reset <= '1';
end process;
end Behavioral;
