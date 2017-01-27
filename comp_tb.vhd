library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.calc_const.all;
--Additional standard or custom libraries go here

entity comp_tb is
end entity;


architecture behav of comp_tb is



component comparator is
port(
--Inputs
DINL : in std_logic_vector (DATA_WIDTH downto 0);
DINR : in std_logic_vector (DATA_WIDTH - 1 downto 0);
--Outputs
DOUT : out std_logic_vector (DATA_WIDTH - 1 downto 0);
isGreaterEq : out std_logic
);
end component;

signal DINL_tb :  std_logic_vector (DATA_WIDTH  downto 0);
signal DINR_tb :  std_logic_vector (DATA_WIDTH - 1 downto 0);
signal DOUT_tb :  std_logic_vector (DATA_WIDTH - 1 downto 0);
signal isGreaterEq_tb : std_logic;


begin

 dut : comparator port map(DINL_tb, DINR_tb, DOUT_tb, isGreaterEq_tb);
 testbench : process begin

	 DINL_tb <= "01000";
	 DINR_tb <= "0010";

	 wait for 1 ns;

	 wait;

 end process;

 end architecture;
