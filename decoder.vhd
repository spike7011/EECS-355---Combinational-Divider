library ieee;
use ieee.std_logic_1164.all;

package decoder is


component leddcd is
	port(
		 data_in : in std_logic_vector(3 downto 0);
		 segments_out : out std_logic_vector(6 downto 0);
		sign, first : in std_logic
		);
end component;	

end package decoder;

package body decoder is
end package body decoder;