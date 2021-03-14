

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
entity lab2 is
    port ( clk       : in  std_logic;
           reset     : in  std_logic;
           startStop : in  std_logic;
           sevenSeg  : out std_logic_vector(6 downto 0);
           selector  : out std_logic_vector(7 downto 0)
    );
end lab2;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavioral of lab2 is
    -- Define Seven Segments Component
    component display7Seg is
        port( symbol   : in  std_logic_vector(3 downto 0);      -- Number / Letter to Display
              segments : out std_logic_vector(6 downto 0)       -- 7 Segments
        );
    end component;
    
    -- Define Seven Segments Controller Component
    component controller7Seg is
        port( clk      : in  std_logic;                         -- FPGA Clock
              enable   : in  std_logic;                         -- Enable
              data_in  : in  std_logic_vector(11 downto 0);     -- Result to Display (Packed)
              data_out : out std_logic_vector(3 downto 0);      -- Result to Display (Unpacked)
              selector : out std_logic_vector(7 downto 0)       -- 7 Segments Anode
        );
    end component;
    
    -- Define Counter Component
    component counter is
        port ( clk       : in  std_logic;                       -- FPGA Clock
               reset     : in  std_logic;                       -- Reset
               enable    : in  std_logic;                       -- Enable Counting
               count     : out std_logic_vector(11 downto 0)    -- Output Count Value
        );
    end component;
    
    --******************
    -- Declarar señales
    --******************
   type states is (s0, s1, s2);
   signal state, next_state : states;  
   signal enableCounter, enableDisplay : std_logic;
   signal symbol: std_logic_vector(3 downto 0);
   signal count: std_logic_vector(11 downto 0);
   signal data_in: std_logic_vector(11 downto 0);
   signal data_out: std_logic_vector(3 downto 0);
   
begin
process (clk,reset) begin
    if(reset='1') then
      state <= s0;
    elsif rising_edge(clk) then
      state <= next_state; 
    end if;
  end process;
  
process(state, startStop)
  begin 
    next_state <= state;
    case(state) is
      when s0 =>
         enableCounter <= '0';
         enableDisplay <= '0';
         if(startStop = '1') then
         next_state <= s1; --empieza a contar
         end if;
      when s1 =>
         enableCounter <= '1';
         enableDisplay <= '1';
         if(startStop = '1') then
         next_state <= s2; --se para
         end if;
      when s2 => 
         enableCounter <= '0';
         enableDisplay <= '1';
         if(reset = '1') then
         next_state <= s0; --reinicio
         end if;
         when others => null;
    end case;
  end process;
  --conectar señales
 data_out <= std_logic_vector(symbol(3 downto 0));     
 data_in <= std_logic_vector(count(11 downto 0)); 
 
    -- Instantiate Counter
    TIME_COUNTER : counter port map(
        clk      => clk,
        reset    => reset,
        enable   => enableCounter,
        count    => count
    );
    
    -- Instantiate Seven Segment Controller
    SEVEN_CONTROL : controller7Seg port map(
        clk      => clk,
        enable   => enableDisplay,
        data_in  => count,
        data_out => symbol,
        selector => selector
    );
    
    -- Instantiate Seven Segment
    SEVEN_SEG : display7Seg port map(
        symbol   => symbol,
        segments => sevenSeg
    );
end Behavioral;
