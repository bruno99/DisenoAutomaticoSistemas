library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity lab1 is
    port ( clk      : in  std_logic;
           reset    : in  std_logic;
           input1   : in  std_logic_vector(3 downto 0);
           input2   : in  std_logic_vector(3 downto 0);
           opcode   : in  std_logic_vector(1 downto 0);
           sevenSeg : out std_logic_vector(6 downto 0);
           selector : out std_logic_vector(7 downto 0);
           leds     : out std_logic_vector(7 downto 0);
           led_negative: out std_logic
    );
end lab1;

architecture Behavioral of lab1 is
 component display7seg is
  port ( symbol   : in  std_logic_vector(3 downto 0);      -- Number / Letter to Display
           segments : out std_logic_vector(6 downto 0)       -- 7 Segments
    );
    end component;
    
    component controller7seg is
      port( clk      : in  std_logic;                         -- FPGA Clock
          reset    : in  std_logic;                         -- Reset
          data_in  : in  std_logic_vector(9 downto 0);      -- Result to Display (Packed)
          data_out : out std_logic_vector(3 downto 0);      -- Result to Display (Unpacked)
          selector : out std_logic_vector(7 downto 0)       -- 7 Segments Anode
    );
    end component;
    
    -- Definición de señales
    signal result     : std_logic_vector(7 downto 0);
    signal symbol     : std_logic_vector(3 downto 0);
    signal led: std_logic_vector(7 downto 0);
    signal data_in: std_logic_vector(9 downto 0);
begin
     process(input1,input2,opcode, result, symbol) begin
        case opcode is
            when "00" =>    -- Suma
                result <= std_logic_vector("0000" & UNSIGNED(input1) + UNSIGNED(input2));
            when "01" =>    -- Resta
            if(input2 > input1) then
            result <= std_logic_vector("0000" & UNSIGNED(input2) - UNSIGNED(input1));
            led_negative <= '1';
            else             
                result <= std_logic_vector("0000" & UNSIGNED(input1) - UNSIGNED(input2));
            end if;
            when "10" =>    -- Complemento a 1 del input 2
                result <= std_logic_vector("0000" & not(input2)); 
            when "11" =>    -- Multiplicación
                result <= std_logic_vector(UNSIGNED(input1) * UNSIGNED(input2));   
            when others =>
                result <= "00000000";
       end case;
      end process;           
    -- Conectar señales
    symbol <= std_logic_vector(result(3 downto 0));
    symbol <= std_logic_vector(result(7 downto 4));  
    led(3 downto 0) <=std_logic_vector(input1);
    led(7 downto 4) <=std_logic_vector(input2);
    leds  <= std_logic_vector(led(7 downto 0));
    data_in(3 downto 0) <=std_logic_vector(input1);
    data_in(7 downto 4) <=std_logic_vector(input2);
    data_in(9 downto 8) <=std_logic_vector(opcode);
   
   -- Instanciar 7seg

    DISP : display7Seg port map(
        symbol => symbol,
        segments => sevenseg
    );
  --Instanciar controller
  
  DISP2 : controller7seg port map(
       clk => clk,
       reset => reset,
       data_in => data_in,
       data_out => symbol,
       selector => selector     
    );  
end Behavioral;
