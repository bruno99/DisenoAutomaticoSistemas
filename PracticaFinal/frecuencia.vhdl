library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity frecuencia is Port( StartStop, clk : in std_logic; 
                           X_rise : out std_logic );
end frecuencia;
architecture Behavioral of frecuencia is
    signal negado :std_logic;
begin
        --process secuancial
        process(clk) 
            variable aux1, aux2 :std_logic;
        begin
            X_rise <= aux2;
            if(rising_edge(clk)) then 
                aux2 := aux1;
                aux1 := StartStop;
            end if;
            negado <= not(aux2);
            X_rise <= negado and aux1;
        end process;
        
end Behavioral;
