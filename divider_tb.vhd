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


		testbench : process
variable test : integer := 1;
		 begin
			 start_tb <= '1';
			 divisor_tb <= x"f";
			 dividend_tb <= x"ff";
			for i in 0 to (DIVIDEND_WIDTH)*8-1 loop
				start_tb <= '0';
				if clk_tb = '1' then
					clk_tb <= '0';
				else clk_tb <= '1';
			end if;
			wait for 1 ns;
		end loop;
		-- ends on a low clock signal
		start_tb <= '1';
		divisor_tb <= x"2";
		dividend_tb <= x"02";

		for i in 0 to (DIVIDEND_WIDTH)*8-1 loop
			start_tb <= '0';
			if clk_tb = '1' then
				clk_tb <= '0';
			else clk_tb <= '1';
		end if;
		wait for 1 ns;
	end loop;

	start_tb <= '1';
	divisor_tb <= x"a";
	dividend_tb <= x"ff";

	for i in 0 to (DIVIDEND_WIDTH)*8-1 loop
		start_tb <= '0';
		if clk_tb = '1' then
			clk_tb <= '0';
		else clk_tb <= '1';
	end if;
	wait for 1 ns;
end loop;

start_tb <= '1';
divisor_tb <= x"0";
dividend_tb <= x"01";

for i in 0 to (DIVIDEND_WIDTH)*8-1 loop
	start_tb <= '0';
	if clk_tb = '1' then
		clk_tb <= '0';
	else clk_tb <= '1';
end if;
wait for 1 ns;
end loop;

start_tb <= '1';
divisor_tb <= x"1";
dividend_tb <= x"00";

for i in 0 to (DIVIDEND_WIDTH)*8-1 loop
	start_tb <= '0';
	if clk_tb = '1' then
		clk_tb <= '0';
	else clk_tb <= '1';
end if;
wait for 1 ns;
end loop;

start_tb <= '1';
divisor_tb <= x"1";
dividend_tb <= x"00";

for i in 0 to (DIVIDEND_WIDTH)*8-1 loop
	start_tb <= '0';
	if clk_tb = '1' then
		clk_tb <= '0';
	else clk_tb <= '1';
end if;
wait for 1 ns;
end loop;



	wait for 1 ns;




		wait;

		end process;

	end architecture;
