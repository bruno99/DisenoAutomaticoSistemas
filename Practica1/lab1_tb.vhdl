library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab_tb is
end lab_tb;

architecture Behavioral of lab_tb is
    component lab1 is
        port (clk      : in  std_logic;
			  reset    : in  std_logic;
              input1, input2   : in  std_logic_vector(3 downto 0);
               opcode   : in  std_logic_vector(1 downto 0);
               sevenSeg : out std_logic_vector( 6 downto 0 );
               selector : out std_logic_vector( 7 downto 0 );
               leds : out std_logic_vector( 7 downto 0 );
               led_negative : out std_logic
        );
    end component;
    signal clk, reset : std_logic;
    signal input1, input2: std_logic_vector(3 downto 0);
    signal opcode: std_logic_vector(1 downto 0);
    signal sevenSeg: std_logic_vector( 6 downto 0 );
    signal selector, leds: std_logic_vector( 7 downto 0 );
    signal led_negative : std_logic;
begin
    DUT : lab1 port map(
    clk      => clk,
	reset    => reset,
    input1 => input1,
    input2 => input2,
    opcode => opcode,
    sevenSeg => sevenSeg,
    selector => selector,
    leds => leds,
    led_negative => led_negative
    );
    process begin
		clk <= '1'; wait for 10ns;
		clk <= '0'; wait for 10ns;
	end process;
    process begin
        input1 <= "0001"; input2 <= "1000"; opcode <= "00"; wait for 10ns;--Suma 1 + 8. Debería salir 9
        input1 <= "1100"; input2 <= "1000"; opcode <= "00"; wait for 10ns;--Suma 9 + 8. Debería salir 17, es decir 11 en hexadecimal
        input1 <= "1111"; input2 <= "1000"; opcode <= "01"; wait for 10ns;--Resta 15 - 8. Debería salir 7
        input1 <= "1000"; input2 <= "1111"; opcode <= "01"; wait for 10ns;--Resta 8 - 15. Debería salir 7 y el led negativo encendido
        input2 <= "1110"; opcode <= "10"; wait for 10ns;--Complmento a1 de 1111. Debería salir 0001
        input1 <= "1010"; input2 <= "0111"; opcode <= "11"; wait for 10ns;--Multiplicación de 10 x 7. Debería salir 70, es decir 46
        input1 <= "1111"; input2 <= "1111"; opcode <= "11"; wait;--Multiplicación de 15 x 15. Debería salir 255, es decir FF
    end process;

end Behavioral;
