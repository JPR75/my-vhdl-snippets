-------------------------------------------------------------------------------
-- Title   : Clock division
-- Project : -
-------------------------------------------------------------------------------
-- Description : Simple clock division
-------------------------------------------------------------------------------
-- File     : clkdiv.vhdl
-- Revision : 1.0.0
-- Created  : April 10, 2011
-- Updated  : April 24, 2011
-------------------------------------------------------------------------------
-- Author       : JPR75
-- Web          : -
-- Email        : -
-------------------------------------------------------------------------------
-- Licence : GNU GPL
--           -
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
entity clkdiv is
  generic (
    g_WIDTH      : integer  := 4;
    g_HALF_FREQ  : unsigned := X"2FAF080"
  );
  port (
    CLK     : in  std_logic;
    RESETn  : in  std_logic;
    CLK_OUT : out std_logic
  );
end entity clkdiv;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
architecture rtl_clkdiv of clkdiv is
  -- constant

  -- signal
  signal s_OUT    : std_logic; -- clock out signal
  signal s_CNT    : unsigned (g_WIDTH downto 0); -- counter
  signal s_CNTMAX : unsigned (g_WIDTH downto 0); -- output high + low level total count

  -----------------------------------------------------------------------------
  -----------------------------------------------------------------------------
  begin

  -- Clock divider
  process (CLK)
  begin
    if (CLK'event and CLK = '1') then
      if (RESETn = '0') then
        s_CNTMAX <= g_HALF_FREQ;
        s_CNT    <= (OTHERS => '0');
        s_OUT    <= '0';
      else
        if (s_CNT < s_CNTMAX) then
          s_CNT <= s_CNT + 1;
         else
          s_CNT <= (OTHERS => '0');
          s_OUT <= not s_OUT;
        end if;
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -----------------------------------------------------------------------------
  CLK_OUT <= s_OUT;

end architecture rtl_clkdiv;

