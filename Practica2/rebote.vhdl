library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rebote is Port ( clk, StartStop : in std_logic;
                        Xout : out std_logic );
end rebote;

architecture Behavioral of rebote is
    constant MAX_COUNT : integer := 100000000;  
    constant stable_time :integer := 10;
    constant cnt_max: integer := MAX_COUNT * stable_time / 1000;
    signal Xprev: std_logic := '0';
    signal counter: integer range 0 to cnt_max :=0;
begin
    process(CLK) begin
        if (rising_edge(CLK)) then
            if ((StartStop xor Xprev) = '0') then
                if (counter < CNT_MAX) then
                    counter <= counter + 1;
                else
                    Xout <= Xprev;
                end if;
            else
                counter <= 0;
                Xprev <= StartStop;
            end if;
        end if;
    end process;


end Behavioral;
