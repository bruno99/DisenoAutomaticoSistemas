
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
           leds     : out std_logic_vector(7 downto 0)
    );
end lab1;

architecture Behavioral of lab1 is
 component display7seg is
  port ( symbol   : in  std_logic_vector(3 downto 0);      -- Number / Letter to Display
           segments : out std_logic_vector(6 downto 0)       -- 7 Segments
    );
    end component;
    component display7segNeg is
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
    signal result     : std_logic_vector(7 downto 0);--creo que 7 pero aux result me hace dudar si es 9
    signal symbol     : std_logic_vector(3 downto 0);
     signal led: std_logic_vector(7 downto 0);
begin
     process(input1,input2,opcode, result, symbol, aux_result) begin
        case opcode is
            when "00" =>    -- Suma
                result <= std_logic_vector('0' & UNSIGNED(input1) + UNSIGNED(input2));
            when "01" =>    -- Resta
                result <= std_logic_vector('0' & UNSIGNED(input1) - UNSIGNED(input2));
            when "10" =>    -- Complemento a 1 del input 2
                result <= not(input2); 
            when "11" =>    -- Multiplicación
                result <= std_logic_vector('0' & UNSIGNED(input1) * UNSIGNED(input2));   
                
    -- ***********************
    -- Conectar señales
    -- ***********************
    sevenSeg <= std_logic_vector(result(8 downto 0));
    -- ***********************
    -- Instanciar componentes
    -- ***********************
end Behavioral;
