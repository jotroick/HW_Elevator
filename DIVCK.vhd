----------------------------------------------------------------------------------
-- Company: UNAL
-- Engineer: JPT
-- 
-- Create Date:    12:45:06 11/16/2007 
-- Design Name: 
-- Module Name:    DIVCK - FUNK 
-- Project Name:   Elevator
-- Target Devices: S3-200
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DIVCK is
		Port ( 	CLOCKIN: in STD_LOGIC;
					START: in STD_LOGIC;
					CLOCKOUT : out  STD_LOGIC);
end DIVCK;

architecture FUNK of DIVCK is

begin

process(CLOCKIN,START)
variable TEMP:  integer range 0 to 16383;
begin

	if(START='1')then
		if(CLOCKIN'event and CLOCKIN='1')then
			case TEMP is
				when 16383 => CLOCKOUT<='0'; -- 16383 -- 1
							  TEMP:=0;
				when 8191 => CLOCKOUT<='1'; -- 8191 -- 0
							 TEMP:=TEMP+1;
				when others => TEMP:=TEMP+1;
			end case;
		end if;
	else
		CLOCKOUT<='0';
	end if;

end process;

end FUNK;

