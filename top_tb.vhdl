------------------------------------------------------------------------------
-- Title   : Top testbench
-- Project : Eval board test
-------------------------------------------------------------------------------
-- Description : Digilent X3S1600E eval board test
-------------------------------------------------------------------------------
-- File     : top_tb.vhdl
-- Revision : 1.0.0
-- Created  : April 10, 2011
-- Updated  : April 24, 2011
-------------------------------------------------------------------------------
-- Author       : JPR75
-- Web          :
-- Email        :
-------------------------------------------------------------------------------
-- Licence : GNU GPL
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
entity top_tb is
end entity top_tb;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
architecture archi_top_tb of top_tb is

  -- constants
  constant Period_50MHz : TIME := 20 ns;

  -- signals
  signal s_PRESETn : std_logic; --! reset
  signal s_CLK_50  : std_logic; --! clock 50MHz
  signal s_SW      : std_logic_vector (3 downto 1);
  signal s_LED     : std_logic_vector (7 downto 1);
  signal s_CE      : std_logic;
  signal s_CLKOUT  : std_logic;

  ----------------------------------------------------------------------------
  ----------------------------------------------------------------------------
  begin

  DUT: entity work.top (rtl_top)
  port map (
    p_CLK_50MHz       => s_CLK_50,
    p_SW(0)           => s_PRESETn,
    p_SW(3 downto 1)  => s_SW(3 downto 1),
    p_LED(0)          => s_CLKOUT,
    p_LED(7 downto 1) => s_LED(7 downto 1),
    p_SF_CE0          => s_CE
  );

  --! 50Mhz Clock generator
  process
  begin
    s_CLK_50 <= '0';
    wait for (Period_50MHz / 2);
    s_CLK_50 <= '1';
    wait for (Period_50MHz / 2);
  end process;

  --! Reset generator
  process
  begin
    s_PRESETn <= '0';
    wait for 100 ns;
    s_PRESETn <= '1';
    wait;
  end process;

  -----------------------------------------------------------------------------
  -----------------------------------------------------------------------------
  s_SW(3 downto 1) <= "000";

end architecture archi_top_tb;

