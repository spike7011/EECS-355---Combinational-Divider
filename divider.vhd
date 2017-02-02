library IEEE;
use IEEE.std_logic_1164.all;
use WORK.calc_const.all;
use ieee.numeric_std.all;
--Additional standard or custom libraries go here
entity divider is
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
end entity divider;


architecture structural_combinational of divider is
	component comparator is
	port(
	--Inputs
	DINL : in std_logic_vector (DATA_WIDTH downto 0);
	DINR : in std_logic_vector (DATA_WIDTH - 1 downto 0);
	--Outputs
	DOUT : out std_logic_vector (DATA_WIDTH - 1 downto 0);
	isGreaterEq : out std_logic
	);
	end component comparator;

	component shiftl_4_5 is
		port(
			a: in std_logic_vector(DATA_WIDTH -1 downto 0);
			b: out std_logic_vector(DATA_WIDTH downto 0));
	end component;
	
	type pre_shifted_array is array(0 to DIVIDEND_WIDTH - 1) of std_logic_vector (DATA_WIDTH - 1 downto 0);
	type shifted_array is array(0 to DIVIDEND_WIDTH - 1) of std_logic_vector (DATA_WIDTH downto 0);
	
	signal pre_shifted_a : pre_shifted_array;
	signal shifted_a : shifted_array;
	signal shifted_a_final : shifted_array;
	signal dividend_msb : std_logic_vector(1 downto 0);
begin
	dividend_msb(0) <= dividend(DIVIDEND_WIDTH - 1);
	dividend_msb(1) <= '0';
	pre_shifted_a(0) <= std_logic_vector(resize(unsigned(dividend_msb), DATA_WIDTH));
	shifted_a(0) <= std_logic_vector(resize(unsigned(dividend_msb), DATA_WIDTH + 1));
	comparator_0 : comparator port map (shifted_a(0), divisor, pre_shifted_a(1), quotient(DIVIDEND_WIDTH - 1));

	MAIN_LOOP : for i in 1 to DIVIDEND_WIDTH - 2 generate
	begin
		shifter_N : shiftl_4_5 port map (pre_shifted_a(i), shifted_a(i));
		shifted_a_final(i)(DATA_WIDTH downto 1) <= shifted_a(i)(DATA_WIDTH downto 1);
		shifted_a_final(i)(0) <= dividend(DIVIDEND_WIDTH - 1 - i);
		comparator_N : comparator port map (shifted_a_final(i), divisor, pre_shifted_a(i+1), quotient(DIVIDEND_WIDTH - 1 - i));
	end generate;

	shifter_last : shiftl_4_5 port map (pre_shifted_a(DIVIDEND_WIDTH - 1), shifted_a(DIVIDEND_WIDTH - 1));
	shifted_a_final(DIVIDEND_WIDTH - 1)(DATA_WIDTH downto 1) <= shifted_a(DIVIDEND_WIDTH - 1)(DATA_WIDTH downto 1);
	shifted_a_final(DIVIDEND_WIDTH - 1)(0) <= dividend(0);
	comparator_last : comparator port map (shifted_a_final(DIVIDEND_WIDTH - 1), divisor, remainder, quotient(0));

	overflow <= '0';
end architecture structural_combinational;
