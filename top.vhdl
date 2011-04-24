------------------------------------------------------------------------------
-- Title   : Top
-- Project : Eval board test
-------------------------------------------------------------------------------
-- Description : Digilent X3S1600E eval board test
-------------------------------------------------------------------------------
-- File     : top.vhdl
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

Library UNISIM;
use UNISIM.vcomponents.all;

library work;
use work.clkdiv_fct.all;
use work.const.all;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
entity top is
  port (
    p_CLK_50MHz : in    std_logic;  -- 50MHz CLK in (C9)
    p_SW        : in    std_logic_vector (3 downto 0);  -- SW3 - SW0 (N17 ; H18 ; L14 ; L13)
    p_LED       : out   std_logic_vector (7 downto 0);  -- LED7 - LED0 (A8 ; G9 ; A7 ; D13 ; E6 ; D6 ; C3 ; D4)
    -- ctrl
    p_SF_CE0    : out   std_logic   -- StrataFlash enable
  );
end entity top;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
architecture rtl_top of top is

--  constant c_CLK_50MHz : real := 50000000.0; -- 50MHz on board CLK

  signal s_RESETn    : std_logic; -- SW0
  signal s_CLK_50MHz : std_logic; -- 50MHz on board CLK

  ----------------------------------------------------------------------------
  ----------------------------------------------------------------------------
  attribute PERIOD : string;
  attribute PERIOD of s_CLK_50MHz : signal is "20 ns";

  attribute BUFFER_TYPE : string;
  attribute BUFFER_TYPE of s_CLK_50MHz : signal is "BUFG";

  ----------------------------------------------------------------------------
  ----------------------------------------------------------------------------

  ----------------------------------------------------------------------------
  ----------------------------------------------------------------------------
  begin

  -- IBUFG: Global Clock Buffer (sourced by an external pin)
  -- Xilinx HDL Language Template, version 10.1.1
  IBUFG_inst : IBUFG
  generic map (
    IOSTANDARD => "DEFAULT")
  port map (
    O => s_CLK_50MHz, -- Clock buffer output
    I => p_CLK_50MHz  -- Clock buffer input (connect directly to top-level port)
  );
  -- End of IBUFG_inst instantiation

  -- CLK division
  -- Divide 50MHz CLK to 1Hz
  -- file : clkdiv.vhdl
  clkdiv_0 : entity work.clkdiv (rtl_clkdiv)
    generic map (
      g_WIDTH      => nb_bits(c_CLK_50MHz),
      g_HALF_FREQ  => half_freq(c_CLK_50MHz, nb_bits(c_CLK_50MHz)) )
    port map (
      CLK     => s_CLK_50MHz,
      RESETn  => s_RESETn,
      CLK_OUT => p_LED(0)
    );

  ----------------------------------------------------------------------------
  ----------------------------------------------------------------------------
  s_RESETn <= p_SW(0);

  p_LED (7 downto 1) <= "0000000";
  p_SF_CE0           <= '1';  -- Diseable StrataFlash

end architecture rtl_top;

