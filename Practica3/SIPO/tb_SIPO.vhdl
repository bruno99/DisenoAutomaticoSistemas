library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_SIPO is
--  Port ( );
end tb_SIPO;

architecture Behavioral of tb_SIPO is
component SIPO is
generic (N_FF : integer := 128);
 Port (CLK, RST: in std_logic;
          D_in: in std_logic;  
          D_out: out std_logic_vector(N_FF-1 downto 0)
      );
end component SIPO;

signal CLK : std_logic;
signal RST : std_logic;
signal D_in : std_logic;
signal D_out : std_logic_vector(127 downto 0);
signal value: std_logic;
signal N_aux: integer := 128;
begin

DUT: SIPO generic map (N_FF => 128) port map 
(CLK => CLK,
 RST => RST,
 D_out => D_out,
 D_in=> D_in
);
 process begin
 RST <= '0';
 CLK <= '0'; wait for 10ns;
 CLK <= '1'; wait for 10ns;

 end process;
process begin
 D_in <= '1';
for n in 0 to N_aux loop
		if n = 0 then
		 value <= D_in;
		 report "The value of 'D_in' is " & std_logic'image(value);
		else
		  if D_in /= value then
		    value <= D_in;
		    report "The value of 'D_in' is " & std_logic'image(value); 
		  end if;
		end if;
	end loop;
end process;
CLK <= CLK;
RST <= RST;
D_in <= std_logic(D_in);
D_out <= std_logic_vector(D_out(127 downto 0));
--N_FF <= integer(N_aux);
end Behavioral;
