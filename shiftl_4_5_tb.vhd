library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;


entity shiftl_4_5_tb is
end entity;


architecture behav of shiftl_4_5_tb is

	component shiftl_4_5 is
	 port(
	 a : in std_logic_vector (3 downto 0 );
	 b : out std_logic_vector( 4 downto 0));
 end component;

signal a_tb : std_logic_vector (3 downto 0);
signal b_tb : std_logic_vector (4 downto 0);

begin
	dut: shiftl_4_5 port map(a_tb, b_tb);
	testbench: process begin


		a_tb<= "0001";

		wait for 1 ns;

		a_tb<= "0011";

		wait for 1 ns;

		a_tb<= "0010";

		wait for 1 ns;

		a_tb<= "0101";

		wait for 1 ns;


wait;

end process;

end architecture;
