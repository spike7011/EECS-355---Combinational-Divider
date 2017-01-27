
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.calc_const.all;
--Additional standard or custom libraries go here
entity comparator is
port(
--Inputs
DINL : in std_logic_vector (DATA_WIDTH downto 0);
DINR : in std_logic_vector (DATA_WIDTH - 1 downto 0);
--Outputs
DOUT : out std_logic_vector (DATA_WIDTH - 1 downto 0);
isGreaterEq : out std_logic
);
end entity comparator;
architecture behavioral of comparator is

begin

divide: process(DINL,DINR)
	variable DINL_v, DINR_v, DOUT_v : integer;

	begin

	DINL_v := to_integer(unsigned(DINL));
	DINR_v := to_integer(unsigned(DINR));
	if(DINL_v >= DINR_v) then
		DOUT_v := DINL_v-DINR_v;
		isGreaterEq <= '1';
	elsif (DINR_v > DINL_v) then
		DOUT_v := DINL_v;
		isGreaterEq <= '0';
end if;

DOUT <= std_logic_vector(to_unsigned(DOUT_v, DATA_WIDTH));

end process;
end architecture behavioral;
