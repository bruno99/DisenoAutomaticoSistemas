library IEEE; 
use IEEE.STD_LOGIC_1164.all; 

entity tb_SIPO is 
    generic (PRINT : boolean := true); 
end tb_SIPO; 

architecture Behavioral of tb_SIPO is 
    component SIPO is 
        port ( 
            CLK, RST, D_in : in  std_logic; 
            D_out         : out std_logic_vector(127 downto 0)); 
    end component; 
    signal CLK, RST, D_in : std_logic; 
    signal D_out           : std_logic_vector(127 downto 0); 
begin 

    DUT : SIPO port map(
    CLK => CLK, 
    RST => RST, 
    D_in => D_in,
    D_out  => D_out ); 

    process begin 
        CLK <= '0'; wait for 5ns; 
        CLK <= '1'; wait for 5ns; 
      
    end process; 
    
    process begin
      RST <= '0'; wait; 
    end process;

    process (D_in) begin 
        if (PRINT) then 
            report ("D_in: " & std_logic'image(D_in)); 
        end if; 
    end process; 

    process begin 
    
        D_in <= '0'; wait for 10ns; 
        D_in <= '1'; wait for 10ns; 
        D_in <= '1'; wait for 10ns; 
        D_in <= '0'; wait for 10ns; 
        D_in <= '1'; wait for 10ns; 
       
        
    end process; 
end Behavioral;
