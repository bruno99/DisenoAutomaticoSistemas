
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
entity counter is
    port ( clk       : in  std_logic;                       -- FPGA Clock
           reset     : in  std_logic;                       -- Reset
           enable    : in  std_logic;                       -- Enable Counting
           count     : out std_logic_vector(11 downto 0)    -- Output Count Value
    );
end counter;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavioral of counter is
    -- Signal Definition
    constant MAX_COUNT : integer := 100000000;              -- Maximum Number of Clock Cycles to Count 1 Second (Input CLK is 100MHz)
    constant MAX_C2C0  : integer := 9;						-- Maximum Count for the Hundreds and Units
    constant MAX_C1    : integer := 5;						-- Maximum Count for the Tens
    signal clk_count : integer range 0 to MAX_COUNT;        -- Current Count
    signal c2, c0 : integer range 0 to MAX_C2C0;            -- Counters for the Hundreds and Units
    signal c1     : integer range 0 to MAX_C1;				-- Counter for the Tens
    signal n2, n1, n0 : std_logic_vector(3 downto 0);       -- Three Numbers of the Count
    signal x : integer;
begin
    process(clk) begin
       x <= 0;
        if(rising_edge(clk)) then
            x <= x+1; --contabilizamos los flancos de subida
            if(reset = '1') then
                clk_count <= 0;
                c2 <= 0; c1 <= 0; c0 <= 0;
            else
             while(c2 /= 9 and c1 /= 5 and c0 /=  9)loop --mientras sea distinto que 9:59
              if(x REM MAX_COUNT = 0) then --si llega a 1 segundo
              if(c0<MAX_C2C0)then -- si es menor que 9
              c0 <= c0 +1;
              else
              c0 <= 0; -- vuelve a 0
              if(c1<MAX_C1) then
              c1 <= c1+1; --suma a Tens si es menor que 5
              else
              c1 <= 0;-- vuelve a 0
              c2 <= c2 +1;--suma a Hundreds
              end if;
              end if;
              end if;
             end loop;
           
            
            end if;
        end if;
         
    end process;
    
    --*****************************************
    -- Convertir c2, c1 y c0 de Integer a STD_LOGIC_VECTOR
    --*****************************************
    n0 <= std_logic_vector(to_unsigned(c0, n0'length));
    n1 <= std_logic_vector(to_unsigned(c1, n1'length));
    n2 <= std_logic_vector(to_unsigned(c2, n2'length));
    count <= n2 & n1 & n0;
end Behavioral;
