-------------------------------------------------------------------------------
-- Title   : CLK division functions
-- Project : -
-------------------------------------------------------------------------------
-- Description : Some functions usefull for clock division
-------------------------------------------------------------------------------
-- File     : clkdiv_fct.vhdl
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
use ieee.math_real.all;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
package clkdiv_fct is
  function half_freq (
    freq : real;
    width : integer
  )
  return unsigned;

  function nb_bits (
    inFreq : real
  )
  return integer;
end clkdiv_fct;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
package body clkdiv_fct is

  -- Divide the frequency by two
  function half_freq (freq : real; width : integer) return unsigned is
  variable v_half_freq : integer;
  begin
    v_half_freq := integer (freq / 2.0);
    return to_unsigned (v_half_freq, (width + 1));
  end function;

  -- Calculate the number of bits needed to bring frequency to 1Hz
  function nb_bits (inFreq : real) return integer is
  variable v_nbOfBits : integer;
  begin
    v_nbOfBits := integer (log(inFreq) / log(2.0)) - 1;
    assert false
      report "Number of bits : " & integer'IMAGE(v_nbOfBits)
      severity note;
    return v_nbOfBits;
  end function;

end package body clkdiv_fct;

