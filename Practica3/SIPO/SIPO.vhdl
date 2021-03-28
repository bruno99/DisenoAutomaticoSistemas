
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SIPO is
    generic (N_FF : integer := 128);
    Port (CLK, RST: in std_logic;
          D_in: in std_logic;  
          D_out: out std_logic_vector(N_FF-1 downto 0)
      );
end SIPO;

architecture Behavioral of SIPO is
      component flipflop is
          Port (CLK, RST, D: in std_logic; 
                Q: out std_logic);
      end component; 
begin

GEN: for n in 0 to N_FF-1 generate    
 if(n = '0') then
    MY_FFS1 : flipflop port map(
    CLK => CLK,
    RST => RST,
    D => D_in,
    Q => D_out(n) 
    );   
    else
    MY_FFS : flipflop port map(
    CLK => CLK,
    RST => RST,
    D => D_in,
    Q => D_out(n) 
    );  
end if;
 
 
end generate;

end Behavioral;
