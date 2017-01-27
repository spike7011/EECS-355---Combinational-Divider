library ieee;

use ieee.std_logic_1164.all;
use work.decoder.all;
use work.calc_const.all;
use ieee.numeric_std.all;

entity display_calc is
port (
a  : in std_logic_vector(DIN1_WIDTH - 1 downto 0);
b  : in std_logic_vector(DIN2_WIDTH - 1 downto 0);
op  : in  std_logic_vector (OP_WIDTH - 1 downto 0);
LED : out std_logic_vector((LEDS*7)-1 downto 0);
SIGN_OUT : out std_logic_vector (6 downto 0));
end entity;

architecture struct of display_calc is

component calculator is
port(
--Inputs
DIN1 : in std_logic_vector (DIN1_WIDTH - 1 downto 0);
DIN2 : in std_logic_vector (DIN2_WIDTH - 1 downto 0);
operation : in std_logic_vector (OP_WIDTH - 1 downto 0);
--Outputs
DOUT : out std_logic_vector (DOUT_WIDTH - 1 downto 0);
sign : out std_logic
);
end component;


signal c_led : std_logic_vector (11 downto 0);
signal sign_led: std_logic;
signal index : integer;


begin

calc: calculator port map(a, b, op, c_led, sign_led);

L0: leddcd port map("0000", SIGN_OUT, sign_led, '0');

G0: for i in 0 to LEDS-1 generate

L1: leddcd port map(c_led(((i*4)+3) downto i*4), LED(6+i*7 downto i*7), '0', '1');

end generate;

end architecture;
