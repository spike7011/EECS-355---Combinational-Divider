library ieee;

use ieee.std_logic_1164.all;
use work.decoder.all;
use work.calc_const.all;
use ieee.numeric_std.all;

entity display_divider_tb is
end entity;


architecture behav of display_divider_tb is

component display_divider is
port(
a : in std_logic_vector (DIVIDEND_WIDTH-1 downto 0);
b : in std_logic_vector (DIVISOR_WIDTH-1 downto 0);
LED : out std_logic_vector (((DIVIDEND_WIDTH/4)*7)-1 downto 0);
remainder : out std_logic_vector(DIVISOR_WIDTH-1 downto 0);
overflow : out std_logic);
end component;

signal a_tb : std_logic_vector (DIVIDEND_WIDTH -1 downto 0);
signal b_tb, remainder_tb : std_logic_vector (DIVISOR_WIDTH -1 downto 0);
signal LED_tb : std_logic_vector (((DIVIDEND_WIDTH/4)*7)-1 downto 0);
signal overflow_tb : std_logic;

begin

	dut: display_divider port map(a_tb, b_tb, LED_tb,remainder_tb, overflow_tb);
	testbench : process begin

		a_tb <= x"04";
		b_tb <= x"2";

		wait for 1 ns;

		a_tb <= x"10";
		b_tb <= x"1";

		wait for 1 ns;

		wait;

	end process;

end architecture;
