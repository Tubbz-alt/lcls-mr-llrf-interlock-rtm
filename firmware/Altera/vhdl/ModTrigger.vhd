-----------------------------------------------------------------
--                                                             --
-----------------------------------------------------------------
--
--  ModTrigger.vhd -
--
--  Copyright(c) Stanford Linear Accelerator Center 2000
--
--  Author: JEFF OLSEN

--  Last change: JO 11/21/2016 3:10:30 PM
--


Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Entity ModTrigger is
Port (
	Clock 				: in std_logic;
	Reset 				: in std_logic;
	ClrFault				: in std_logic;
	ModFault				: in std_logic;
	ModFaultOut			: out std_logic
	);
end ModTrigger;

Architecture Behaviour of ModTrigger is

signal dbModFaultOut : std_logic;

Begin
DeBounce : entity work.DeBouncer
port map (
    Clock     	=> Clock,
    Reset	   => Reset,
	 ClkEn		=> '1',
	 Input		=> ModFault,
    DbOut 		=> dbModFaultOut
	);

latch: process(Clock, reset)
begin
if (Reset = '1') then	
	ModFaultOut <= '0';
elsif (Clock'event and Clock = '1') then
	if (dbModfaultOut = '1') then	
		ModFaultOut <= '1';
	elsif (ClrFault = '1') then
		ModFaultOut <= dbModFaultOut;
	end if;
end if;
end process;


end Behaviour;




