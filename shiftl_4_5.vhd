library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.calc_const.all;


entity shiftl_4_5 is
 port(
 a : in std_logic_vector (DATA_WIDTH-1 downto 0 );
 b : out std_logic_vector(DATA_WIDTH downto 0));
end entity;


architecture struct of shiftl_4_5 is

signal b_temp : integer;
begin


b_temp <= to_integer(unsigned(a))*2;

b <= std_logic_vector(to_unsigned(b_temp,DATA_WIDTH+1));


end architecture;
