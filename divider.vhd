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


type signal_array is array(0 to DIVIDEND_WIDTH-2) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal temp : signal_array;
type signal_array1 is array(0 to DIVIDEND_WIDTH-2) of std_logic_vector(DATA_WIDTH downto 0);
signal quotient_temp1 : signal_array1;
signal dividend_t : std_logic_vector (DATA_WIDTH downto 0);
signal quotient_temp : std_logic_vector (DIVIDEND_WIDTH-1 downto 0);
constant max : integer := 255;
-- signal quotient_temp1 : std_logic_vector (DIVIDEND_WIDTH-1 downto DIVIDEND_WIDTH/2-1);
signal remainder_temp : std_logic_vector (DIVISOR_WIDTH-1 downto 0);

begin
temp(0) <= "0000";
G0: for i in 0 to DIVIDEND_WIDTH-1	generate begin

	I5: if i /= DIVIDEND_WIDTH-1 generate begin

			J0: for j in 1 to DIVISOR_WIDTH generate begin
				quotient_temp1(i)(j) <= temp(i)(j-1);
			end generate;

			quotient_temp1(i)(0) <= dividend(DIVIDEND_WIDTH-1-i);
		C3: comparator port map(quotient_temp1(i),
			divisor(DIVISOR_WIDTH-1 downto 0), temp(i) ,quotient_temp(DIVIDEND_WIDTH-1-i));
	end generate;

	I3: if i = DIVIDEND_WIDTH-1 generate begin

		J1: for j in 1 to DIVISOR_WIDTH generate begin
			quotient_temp1(i-1)(j) <= temp(i-1)(j-1);
		end generate;

		C2: comparator port map(quotient_temp1(i-1),
		divisor(DIVISOR_WIDTH-1 downto 0),
		remainder_temp, quotient_temp(DIVIDEND_WIDTH-1-i));
	end generate;


end generate;


overflow <= '1' when to_integer(unsigned(dividend))/max > max else '0';
quotient <= quotient_temp when to_integer(unsigned(divisor)) /= 0
else (std_logic_vector(resize(unsigned(divisor),DIVIDEND_WIDTH)));

remainder <= remainder_temp when to_integer(unsigned(divisor)) /= 0
	else (std_logic_vector(resize(unsigned(divisor),DIVISOR_WIDTH)));
end architecture structural_combinational;
