library IEEE;

use IEEE.std_logic_1164.all;

entity leddcd is
	port(
		 data_in : in std_logic_vector(3 downto 0);
		 segments_out : out std_logic_vector(6 downto 0);
		 sign, first : in std_logic
		);
end entity leddcd;

architecture data_flow of leddcd is

signal segments_temp : std_logic_vector (6 downto 0);
begin

segments_temp <= "1000000" when data_in = "0000" else
		   	   "1111001" when data_in = "0001" else
		   	   "0100100" when data_in = "0010" else
		   	   "0110000" when data_in = "0011" else
		   	   "0011001" when data_in = "0100" else
		   	   "0010010" when data_in = "0101" else
		   	   "0000010" when data_in = "0110" else
		   	   "1111000" when data_in = "0111" else
		   	   "0000000" when data_in = "1000" else
		   	   "0010000" when data_in = "1001" else
		   	   "0001000" when data_in = "1010" else
		   	   "0000011" when data_in = "1011" else
		   	   "1000110" when data_in = "1100" else
		   	   "0100001" when data_in = "1101" else
		   	   "0000110" when data_in = "1110" else
			   "0001110";

segments_out <= segments_temp when first = '1'  else
	"0111111" when (sign = '1' and first = '0')
	 else "1111111" when (sign = '0' and first = '0');

end architecture data_flow;
