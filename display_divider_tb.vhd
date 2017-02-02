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
start : in std_logic;
a : in std_logic_vector (DIVIDEND_WIDTH-1 downto 0);
b : in std_logic_vector (DIVISOR_WIDTH-1 downto 0);
LED : out std_logic_vector (((DIVIDEND_WIDTH/4)*7)-1 downto 0);
remainder_LED : out std_logic_vector (6 downto 0);
overflow : out std_logic);
end component;

signal start_tb : std_logic;
signal a_tb : std_logic_vector (DIVIDEND_WIDTH -1 downto 0);
signal b_tb : std_logic_vector (DIVISOR_WIDTH -1 downto 0);
signal LED_tb : std_logic_vector (((DIVIDEND_WIDTH/4)*7)-1 downto 0);
signal  remainder_tb : std_logic_vector (6 downto 0);
signal overflow_tb : std_logic;

begin

	dut: display_divider port map(start_tb, a_tb, b_tb, LED_tb,  remainder_tb,overflow_tb);
	testbench : process begin

		start_tb <= '0';


		a_tb <= x"04";
		b_tb <= x"2";

		start_tb <= '1';

		wait for 1 ns;

		start_tb <= '0';

		a_tb <= x"10";
		b_tb <= x"1";

			start_tb <= '1';

		wait for 1 ns;

		wait;

	end process;

end architecture;
