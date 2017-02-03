library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.calc_const.all;

entity divider_tb_file is
end entity;


architecture behavioral of divider_tb_file is

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

	signal start_tb : std_logic;
	signal dividend_tb : std_logic_vector(DIVIDEND_WIDTH -1 downto 0);
	signal divisor_tb : std_logic_vector(DIVISOR_WIDTH -1 downto 0);
	signal quotient_tb : std_logic_vector(DIVIDEND_WIDTH -1 downto 0);
	signal remainder_tb : std_logic_vector(DIVISOR_WIDTH -1 downto 0);
	signal overflow_tb : std_logic;
begin

dut : divider port map(start_tb, dividend_tb, divisor_tb, quotient_tb, remainder_tb, overflow_tb);

 process is
    variable my_line : line;
     file infile: text open read_mode is "divider16.txt";
     file outfile: text open write_mode is "divider16.out";

   variable num1, num2 : integer;
   variable op : string (1 to 1);
   variable op_flag :  integer;
	begin
		start_tb <= '0';
		while not (endfile(infile)) loop
      start_tb <= '0';


			readline(infile, my_line);
			read(my_line,num1);
			dividend_tb <= std_logic_vector(to_unsigned(num1,DIVIDEND_WIDTH));
			readline(infile, my_line);
			read(my_line,num2);
			divisor_tb <= std_logic_vector(to_unsigned(num2,DIVISOR_WIDTH));
			readline(infile,my_line);
			read(my_line, op);
			wait for 1 ns;
			start_tb <= '1';

			wait for 1 ns;

			write(my_line, to_integer(unsigned(dividend_tb)));
			write(my_line, string'(" "));
			write(my_line, string'(" / "));
			write(my_line, to_integer(unsigned(divisor_tb)));
			write(my_line, string'(" = "));
			write(my_line, to_integer(unsigned(quotient_tb)));
			write(my_line,string'(" -- "));
			write(my_line,to_integer(unsigned(remainder_tb)));
			writeline(outfile,my_line);


		end loop;

		wait;

		end process;




end architecture;
