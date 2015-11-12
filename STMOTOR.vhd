----------------------------------------------------------------------------------
-- Company: UNAL
-- Engineer: JPT
-- 
-- Create Date:    12:41:45 11/16/2007 
-- Design Name: 
-- Module Name:    STMOTOR - FUNK 
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

entity STMOTOR iS
    Port ( UP : in  STD_LOGIC;
           DOWN : in  STD_LOGIC;
			  CLOCK: in STD_LOGIC;
           STEPPER : out  STD_LOGIC_VECTOR (3 downto 0));
end STMOTOR;

architecture FUNK of STMOTOR is
begin
	process (CLOCK, UP, DOWN) 
		variable STM: STD_LOGIC_VECTOR (3 downto 0);
	begin
		if((UP='1' or UP='0')and(DOWN='1' or DOWN='0'))then
			if(CLOCK'event and CLOCK='1')then
				if(UP='1' and DOWN='0')then
					case STM is
						when "1100" => STM:="0110";
						when "0110" => STM:="0011";
						when "0011" => STM:="1001";
						when others => STM:="1100";
					end case;
				elsif(UP='0' and DOWN='1')then
					case STM is
						when "1001" => STM:="0011";
						when "0011" => STM:="0110";
						when "0110" => STM:="1100";
						when others => STM:="1001";
					end case;
				elsif(UP=DOWN)then
					case STM is
						when "1001" => STM:="1001";
						when "0011" => STM:="0011";
						when "0110" => STM:="0110";
						when others => STM:="1100";
					end case;
				end if;
			end if;
			STEPPER<=STM;
		elsif(UP='U' or DOWN='U')then
			STEPPER<="0000";
		end if;
		
	end process;

end FUNK;