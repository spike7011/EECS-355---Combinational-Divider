library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.calc_const.all;
--Additional standard or custom libraries go here

entity divider_tb is
end entity;


architecture behav of divider_tb is

	component divider is
	port(
	--Inputs
	clk : in std_logic;
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

for all : divider use entity WORK.divider(behavioral_sequential);
signal clk_tb : std_logic;
signal start_tb : std_logic;
signal dividend_tb : std_logic_vector(DIVIDEND_WIDTH -1 downto 0);
signal divisor_tb : std_logic_vector(DIVISOR_WIDTH -1 downto 0);
signal quotient_tb : std_logic_vector(DIVIDEND_WIDTH -1 downto 0);
signal remainder_tb : std_logic_vector(DIVISOR_WIDTH -1 downto 0);
signal overflow_tb : std_logic;
begin

 dut : divider port map(clk_tb, start_tb, dividend_tb, divisor_tb, quotient_tb, remainder_tb, overflow_tb);


  testbench : process begin
	start_tb <= '0';
	wait for 2 ns;
	start_tb <= '1';
	wait for 2 ns;
	dividend_tb <= X"03";
	divisor_tb <= X"1";
	clk_tb <= '0';
	wait for 2 ns;
	clk_tb <= '1';
	 wait for 2 ns;

	 dividend_tb <= X"04";
	 divisor_tb <= X"1";
	clk_tb <= '0';
	wait for 2 ns;
	clk_tb <= '1';
		wait for 2 ns;

		dividend_tb <= X"0f";
		divisor_tb <= X"1";
	clk_tb <= '0';
	wait for 2 ns;
	clk_tb <= '1';
		 wait for 2 ns;

		 dividend_tb <= X"0f";
 		divisor_tb <= X"2";
	clk_tb <= '0';
	wait for 2 ns;
	clk_tb <= '1';
 		 wait for 2 ns;

		 dividend_tb <= X"01";
		divisor_tb <= X"1";
	clk_tb <= '0';
	wait for 2 ns;
	clk_tb <= '1';

	 wait;

 end process;

 end architecture;
