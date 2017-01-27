library IEEE;
use IEEE.std_logic_1164.all;
use work.decoder.all;
use work.calc_const.all;
use ieee.numeric_std.all;
--Additional standard or custom libraries go here
entity calculator is
port(
--Inputs
DIN1 : in std_logic_vector (DIN1_WIDTH - 1 downto 0);
DIN2 : in std_logic_vector (DIN2_WIDTH - 1 downto 0);
operation : in std_logic_vector (OP_WIDTH - 1 downto 0);
--Outputs
DOUT : out std_logic_vector (DOUT_WIDTH - 1 downto 0);
sign : out std_logic
);
end entity calculator;

architecture behavioral of calculator is

signal DIN1_int, DIN2_int, DOUT_int : integer;
signal DIN1_signed : signed(DIN1_WIDTH - 1 downto 0);
signal DIN2_signed : signed(DIN2_WIDTH -1 downto 0);
signal abs_temp : integer;
signal DOUT_signed : signed(DOUT_WIDTH - 1 downto 0);



begin

DIN1_signed <= signed(DIN1);
DIN1_int <= to_integer(DIN1_signed);

DIN2_signed <= signed(DIN2);
DIN2_int <= to_integer(DIN2_signed);

DOUT_int <= (DIN1_int + DIN2_int) when operation = "00" 
	else (DIN1_int - DIN2_int) when operation = "01"
	else (DIN1_int * DIN2_int) when operation = "10"
	else 0;
	

sign <= '0' when (DOUT_int >= 0) else '1'; 


DOUT_signed <= to_signed(DOUT_int, DOUT_WIDTH) when DOUT_int >= 0 else abs(to_signed(DOUT_int, DOUT_WIDTH));
DOUT <= std_logic_vector(DOUT_signed); 



end architecture behavioral;
