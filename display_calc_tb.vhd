library ieee;

use ieee.std_logic_1164.all;
use work.decoder.all;
use work.calc_const.all;
use ieee.numeric_std.all;

entity display_calc_tb is
end entity;

architecture behav of display_calc_tb is

component display_calc is
port(
a  : in std_logic_vector(DIN1_WIDTH - 1 downto 0);
b  : in std_logic_vector(DIN2_WIDTH - 1 downto 0);
op  : in  std_logic_vector (OP_WIDTH - 1 downto 0);
LED : out std_logic_vector((LEDS*7)-1 downto 0);
SIGN_OUT : out std_logic_vector (6 downto 0));
end component;

signal a_tb : std_logic_vector(DIN1_WIDTH-1 downto 0);
signal b_tb : std_logic_vector(DIN2_WIDTH-1 downto 0);
signal op_tb : std_logic_vector(OP_WIDTH-1 downto  0);
signal LED_tb : std_logic_vector((LEDS*7)-1 downto 0);
signal SIGN_OUT_tb : std_logic_vector(6 downto 0);


begin

dut : display_calc port map(a_tb, b_tb, op_tb, LED_tb, SIGN_OUT_tb);
testbench: process begin

a_tb <= "00000010";
b_tb <= "0001";
op_tb <= "00";

wait for 5 ns;

a_tb <= "00000011";
b_tb <= "0001";
op_tb <= "00";

wait for 5 ns;

a_tb <= "00000000";
b_tb <= "0001";
op_tb <= "01";

wait for 5 ns;

end process;

end behav;