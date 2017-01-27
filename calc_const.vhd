library IEEE;
use IEEE.std_logic_1164.all;
--Additional standard or custom libraries go here
package calc_const is
constant DIN1_WIDTH : natural := 8;
constant DIN2_WIDTH : natural := 4;
constant OP_WIDTH : natural := 2;
constant DOUT_WIDTH : natural := 12;
constant LEDS : natural := 3;
constant DIVIDEND_WIDTH : natural := 8;
constant DIVISOR_WIDTH : natural := 4;
constant COMPS : natural := DIVIDEND_WIDTH-DIVISOR_WIDTH;
constant DATA_WIDTH : natural := DIVIDEND_WIDTH-DIVISOR_WIDTH;
--Other constants, types, subroutines, components go here
end package calc_const;
package body calc_const is
--Subroutine declarations go here
-- you will not have any need for it now, this package is only for defining -
-- some useful constants
end package body calc_const;
-----------------------------------------------------------------------------
