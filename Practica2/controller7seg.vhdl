-- **********************************************
-- controller7Seg.vhd : 7 Segment Display Controller
--
-- Prof. Dr. Luis A. Aranda
--
-- Universidad Nebrija
--
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
entity controller7Seg is
    port( clk      : in  std_logic;                         -- FPGA Clock
          enable   : in  std_logic;                         -- Enable
          data_in  : in  std_logic_vector(11 downto 0);     -- Result to Display (Packed)
          data_out : out std_logic_vector(3 downto 0);      -- Result to Display (Unpacked)
          selector : out std_logic_vector(7 downto 0)       -- 7 Segments Anode
    );
end controller7Seg;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavioral of controller7Seg is
    signal LED_counter : std_logic_vector(1 downto 0);
    signal refresh_counter : std_logic_vector(19 downto 0);     -- To Create a 10.5ms Refresh Period
begin
    -- Counter Process
    process(clk) begin
        if(rising_edge(clk)) then
            if(enable = '0') then
                refresh_counter <= (others => '0');
            else
                refresh_counter <= refresh_counter + 1;
            end if;
        end if;
    end process;
    
    LED_counter <= refresh_counter(19 downto 18);
    
    -- Anode Selection
    process(LED_counter, data_in) begin
        case LED_counter is
            when "00" => 
                data_out <= data_in(3 downto 0);
                selector <= x"FE";
            when "01" =>
                data_out <= data_in(7 downto 4);
                selector <= x"FD"; 
            when "10" => 
                data_out <= data_in(11 downto 8);
                selector <= x"FB";
            when others =>
                data_out <= data_in(11 downto 8);
                selector <= x"FB";
        end case;
    end process;
end Behavioral;
