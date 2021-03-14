-- **********************************************
-- counter.vhd : Counter for the Stopwatch
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
    constant MAX_C2C0  : integer := ;						-- Maximum Count for the Hundreds and Units
    constant MAX_C1    : integer := ;						-- Maximum Count for the Tens
    signal clk_count : integer range 0 to MAX_COUNT;        -- Current Count
    signal c2, c0 : integer range 0 to MAX_C2C0;            -- Counters for the Hundreds and Units
    signal c1     : integer range 0 to MAX_C1;				-- Counter for the Tens
    signal n2, n1, n0 : std_logic_vector(3 downto 0);       -- Three Numbers of the Count
begin
    process(clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                clk_count <= 0;
                c2 <= 0; c1 <= 0; c0 <= 0;
            else
                --***********
                -- Completar
                --***********
            end if;
        end if;
    end process;
    
    --*****************************************
    -- Convertir c2, c1 y c0 de Integer a STD_LOGIC_VECTOR
    --*****************************************
    count <= n2 & n1 & n0;
end Behavioral;
