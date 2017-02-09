
library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;


entity dff_gen is
	GENERIC (DATA_WIDTH : integer);
 port(
 clk : in std_logic;
 d : in std_logic_vector(DATA_WIDTH-1 downto 0);
 q: out std_logic_vector(DATA_WIDTH-1 downto 0));
end entity;


architecture behav of dff_gen is
	begin
  proc : process (clk)
  begin
	if falling_edge(clk) then
	  q <= d;
	end if;
  end process;
end behav;
