----------------------------------------------------------------------------------
-- Company: UNAL
-- Engineer: JPT
-- 
-- Create Date:    12:45:52 11/16/2007 
-- Design Name: 
-- Module Name:    MUXY - FUNK 
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

entity MUXY is
    Port ( AUTO : in  STD_LOGIC_VECTOR (1 downto 0);
           MANUAL : in  STD_LOGIC_VECTOR (1 downto 0);
           ACCION : out  STD_LOGIC_VECTOR (1 downto 0);
           SELECTOR : in  STD_LOGIC);
end MUXY;

architecture FUNK of MUXY is

begin

process(AUTO,MANUAL,SELECTOR)begin
	
	case SELECTOR is 
	
		when '1' => ACCION<=AUTO;
		when others => ACCION<=MANUAL;
	
	end case;
	
end process;

end FUNK;



