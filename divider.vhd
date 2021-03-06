library IEEE;
use IEEE.std_logic_1164.all;
use WORK.calc_const.all;
use ieee.numeric_std.all;
--Additional standard or custom libraries go here
entity divider is
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
	signal temp_quotient : std_logic_vector(DIVIDEND_WIDTH - 1 downto 0);
	signal temp_remainder : std_logic_vector(DIVISOR_WIDTH - 1 downto 0);
	begin
		dividend_msb(0) <= dividend(DIVIDEND_WIDTH - 1);
		dividend_msb(1) <= '0';
		pre_shifted_a(0) <= std_logic_vector(resize(unsigned(dividend_msb), DATA_WIDTH));
		shifted_a(0) <= std_logic_vector(resize(unsigned(dividend_msb), DATA_WIDTH + 1));
		comparator_0 : comparator port map (shifted_a(0), divisor, pre_shifted_a(1), temp_quotient(DIVIDEND_WIDTH - 1));

		MAIN_LOOP : for i in 1 to DIVIDEND_WIDTH - 2 generate
			begin
				shifter_N : shiftl_4_5 port map (pre_shifted_a(i), shifted_a(i));
				shifted_a_final(i)(DATA_WIDTH downto 1) <= shifted_a(i)(DATA_WIDTH downto 1);
				shifted_a_final(i)(0) <= dividend(DIVIDEND_WIDTH - 1 - i);
				comparator_N : comparator port map (shifted_a_final(i), divisor, pre_shifted_a(i+1), temp_quotient(DIVIDEND_WIDTH - 1 - i));
			end generate;

			shifter_last : shiftl_4_5 port map (pre_shifted_a(DIVIDEND_WIDTH - 1), shifted_a(DIVIDEND_WIDTH - 1));
			shifted_a_final(DIVIDEND_WIDTH - 1)(DATA_WIDTH downto 1) <= shifted_a(DIVIDEND_WIDTH - 1)(DATA_WIDTH downto 1);
			shifted_a_final(DIVIDEND_WIDTH - 1)(0) <= dividend(0);
			comparator_last : comparator port map (shifted_a_final(DIVIDEND_WIDTH - 1), divisor, temp_remainder, temp_quotient(0));

			START_PROCESS : process (start)
			begin
				if rising_edge(start) then
					if to_integer(unsigned(divisor)) /= 0 then
						overflow <= '0';
						remainder <= temp_remainder;
						quotient <= temp_quotient;
					else
						overflow <= '1';
						remainder <= std_logic_vector(to_unsigned(0, DIVISOR_WIDTH));
						quotient <= std_logic_vector(to_unsigned(0, DIVIDEND_WIDTH));
					end if;
				end if;
			end process;
		end architecture structural_combinational;

architecture behavioral_sequential of divider is
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
		b: out std_logic_vector(DATA_WIDTH downto 0)
		);
	end component;


	component dff_gen is
		GENERIC (DATA_WIDTH : integer);
		port(
		clk : in std_logic;
		d : in std_logic_vector(DATA_WIDTH-1 downto 0);
		q: out std_logic_vector(DATA_WIDTH-1 downto 0));
	end component;

	signal pre_shifted_a : std_logic_vector (DATA_WIDTH - 1 downto 0);
	signal shifted_a : std_logic_vector (DATA_WIDTH downto 0);
	signal shifted_a_final : std_logic_vector (DATA_WIDTH downto 0);
	signal dividend_msb : std_logic_vector(1 downto 0);
	signal i_help : integer;
	signal temp_quotient_bit : std_logic;

	begin
		comparator_module : comparator port map (shifted_a_final, divisor, pre_shifted_a, temp_quotient_bit);
		shifter_module : shiftl_4_5 port map (pre_shifted_a, shifted_a);
		--dff_module : dff_gen
		--generic map (DATA_WIDTH + 1)
		--port map (clk, shifted_a_final_d, shifted_a_final_q);

		dividend_msb(0) <= dividend(DIVIDEND_WIDTH - 1);
		dividend_msb(1) <= '0';
		EXECUTE_STAGE: process(start, clk, dividend, divisor)
		variable i, help: integer := 0;
		variable temp_quotient : std_logic_vector(DIVIDEND_WIDTH - 1 downto 0);

		begin
			if rising_edge(clk) then

				if i = 0 then
					shifted_a_final <= std_logic_vector(resize(unsigned(dividend_msb), DATA_WIDTH + 1));
					help := 1;
				elsif i < DIVIDEND_WIDTH then
					shifted_a_final(DATA_WIDTH downto 1) <= shifted_a(DATA_WIDTH downto 1);
					shifted_a_final(0) <= dividend(DIVIDEND_WIDTH - 1 - i);
					-- i := i + 1;
				end if;
			elsif falling_edge(clk) then
				if i < DIVIDEND_WIDTH and help = 0 then
					temp_quotient(DIVIDEND_WIDTH-i-1) := temp_quotient_bit;
					i := i +1;
				elsif help = 1 then
					temp_quotient(DIVIDEND_WIDTH-1) := temp_quotient_bit;
				i := i + 1;

			end if;



			if i = DIVIDEND_WIDTH and start = '0' then
				if to_integer(unsigned(divisor)) /= 0 then
					overflow <= '0';
					remainder <= pre_shifted_a;
					--  temp fix
					quotient <= std_logic_vector(resize(unsigned(unsigned(temp_quotient)*1), DIVIDEND_WIDTH));
					temp_quotient := x"00";
					i := 0;

				else
					overflow <= '1';
					remainder <= std_logic_vector(to_unsigned(0, DIVISOR_WIDTH));
					quotient <= std_logic_vector(to_unsigned(0, DIVIDEND_WIDTH));
					temp_quotient := x"00";
					i := 0;
				end if;
			end if;
		end if;

		i_help <= i;
		help := 0;
	end process EXECUTE_STAGE;
end architecture behavioral_sequential;
