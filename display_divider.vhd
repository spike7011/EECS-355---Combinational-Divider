library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;
 use work.calc_const.all;
 use work.decoder.all;


entity display_divider is
port(
a : in std_logic_vector (DIVIDEND_WIDTH-1 downto 0);
b : in std_logic_vector (DIVISOR_WIDTH-1 downto 0);
LED : out std_logic_vector (((DIVIDEND_WIDTH/4)*7)-1 downto 0);
remainder : out std_logic_vector(DIVISOR_WIDTH-1 downto 0);
overflow : out std_logic);
end entity;


architecture struct of display_divider is

  component divider is
  port(
  --Inputs
  -- clk : in std_logic;
  --COMMENT OUT clk signal for Part A.
  start : in std_logic;
  dividend : in std_logic_vector (DIVIDEND_WIDTH - 1 downto 0);
  divisor : in std_logic_vector (DIVISOR_WIDTH - 1 downto 0);
  --Outputs
  quotient : out std_logic_vector (DIVIDEND_WIDTH - 1 downto 0);
  remainder : out std_logic_vector (DIVISOR_WIDTH - 1 downto 0);
  overflow : out std_logic
  );
  end component;

signal d_led,d_led1 : std_logic_vector (DIVIDEND_WIDTH-1 downto 0);

begin

divide: divider port map ('1', a,b, d_led, remainder, overflow);
d_led1 <= d_led;

G0: for i in 0 to (DIVIDEND_WIDTH/4)-1 generate begin
  L1: leddcd port map(d_led1(((i*4)+3) downto i*4), LED(6+i*7 downto i*7), '0', '1');
end generate;



end architecture;
