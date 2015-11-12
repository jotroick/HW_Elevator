----------------------------------------------------------------------------------
-- Company: UNAL
-- Engineer: JPT
-- 
-- Create Date:    12:42:44 11/16/2007 
-- Design Name: 
-- Module Name:    DISPLAY - FUNK 
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

entity DISPLAY is
    Port ( CLOCK : in  STD_LOGIC;
           UP : in  STD_LOGIC;
           DOWN : in  STD_LOGIC;
           NIVEL : in  STD_LOGIC_VECTOR (4 downto 0);
			  START: in STD_LOGIC;
           UPLED : out  STD_LOGIC;
           DOWNLED : out  STD_LOGIC;
           HAB : out  STD_LOGIC_VECTOR (7 downto 0);
           SIETES : out  STD_LOGIC_VECTOR (6 downto 0));
end DISPLAY;

architecture FUNK of DISPLAY is

begin

process(UP,DOWN)begin -- LED EXTERNOS
	
	if(UP/=DOWN)then
		UPLED<=(UP); -- LÓGICA NEGATIVA PORQUE EL HABILITADOR ES POSITIVO
		DOWNLED<=(DOWN); -- LÓGICA NEGATIVA PORQUE EL HABILITADOR ES POSITIVO
	else
		UPLED<='0';
		DOWNLED<='0';
	end if;
end process;

process(NIVEL,CLOCK,START)
variable LASTLEVEL: STD_LOGIC_VECTOR (4 downto 0);
begin -- SIETE SEGMENTOS
	
	if(START='1')then
		
		if(CLOCK'event and CLOCK='1')then
		
			case NIVEL is
				when "00001" => LASTLEVEL:=NIVEL;
				when "00010" => LASTLEVEL:=NIVEL;
				when "00100" => LASTLEVEL:=NIVEL;
				when "01000" => LASTLEVEL:=NIVEL;
				when "10000" => LASTLEVEL:=NIVEL;
				when others => LASTLEVEL:=LASTLEVEL;
			end case;
		
		end if;
	
		case LASTLEVEL is
			when "00001" => SIETES<="1111001";--0000110  1
			when "00010" => SIETES<="0100100";--1011011  2
			when "00100" => SIETES<="0110000";--1001111  3
			when "01000" => SIETES<="0011001";--1100110  4
			when "10000" => SIETES<="0010010";--1101101  5
			when "00000" => SIETES<="0100011";--1011100  []			
			when others => SIETES<="1111111"; --0000000 NADA
		end case;
				
	elsif(START='0')then
		
		SIETES<="1000001";--0111110 U
		LASTLEVEL:="00000";
		
	end if;
	
end process;

process (CLOCK) -- HABILITADOR DE 7 "DISPLAYS"
variable i: integer range 0 to 7;
begin
	if(CLOCK'event and CLOCK='1')then
		if(i<7)then
			i:=i+1;
		else
			i:=0;
		end if;
	end if;
	case i is
		when 0 =>HAB<="00000001";
		when 1 =>HAB<="00000010";
		when 2 =>HAB<="00000100";
		when 3 =>HAB<="00001000";
		when 4 =>HAB<="00010000";
		when 5 =>HAB<="00100000";
		when 6 =>HAB<="01000000";		
		when others =>HAB<="10000000";
	end case;
end process;

end FUNK;

