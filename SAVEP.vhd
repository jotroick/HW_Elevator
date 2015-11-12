----------------------------------------------------------------------------------
-- Company: UNAL
-- Engineer: JPT
-- 
-- Create Date:    09:11:50 11/24/2007 
-- Design Name: 
-- Module Name:    guardar - behab 
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

entity guardar is
    Port ( clk: in STD_LOGIC;
			  START: in STD_LOGIC;
			  int : in  STD_LOGIC_VECTOR (12 downto 0);
           sensor : in  STD_LOGIC_VECTOR (4 downto 0);
           salida : out  STD_LOGIC_VECTOR (12 downto 0));
end guardar;

architecture behab of guardar is

begin

process(clk,START,int,sensor)
variable pulsador: STD_LOGIC_VECTOR (12 downto 0);
variable bandera: boolean;
variable pulsad2: STD_LOGIC_VECTOR (12 downto 0);
begin

if(START='1')then
		
		if(clk'event and clk='1')then
		
			if(bandera)then
				
				case int is
				
					when "0111111111111" =>	if(bandera)then -- UP1
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111111101111" => if(bandera)then -- CABINA1
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1011111111111" => if(bandera)then -- UP2
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111011111111" => if(bandera)then -- DOWN2
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111111110111" => if(bandera)then -- CABINA2
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1101111111111" => if(bandera)then -- UP3
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111101111111" => if(bandera)then -- DOWN3
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111111111011" => if(bandera)then -- CABINA3
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1110111111111" => if(bandera)then -- UP4
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111110111111" => if(bandera)then -- DOWN4
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111111111101" => if(bandera)then --CABINA4
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111111011111" => if(bandera)then -- DOWN5
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111111111110" => if(bandera)then -- CABINA5
														pulsador:=int; 
														bandera:=false;
													else
														pulsador:=pulsador;
														bandera:=false;
													end if;
													
					when "1111111111111" => pulsador:=int; -- NADA
													bandera:=true;
					when others =>	pulsador:=pulsador;
										bandera:=true;
				end case;
			
			else
			
				pulsador:=pulsador;
			
			end if;
			
			case pulsador is
				
				when "0111111111111" =>	if(sensor="11110" and not(bandera))then -- UP1
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
				
				when "1111111101111" => if(sensor="11110" and not(bandera))then -- CABINA1
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1011111111111" => if(sensor="11101" and not(bandera))then -- UP2
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111011111111" => if(sensor="11101" and not(bandera))then -- DOWN2
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111111110111" => if(sensor="11101" and not(bandera))then -- CABINA2
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1101111111111" => if(sensor="11011" and not(bandera))then -- UP3
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111101111111" => if(sensor="11011" and not(bandera))then -- DOWN3
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111111111011" => if(sensor="11011" and not(bandera))then -- CABINA3
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1110111111111" => if(sensor="10111" and not(bandera))then -- UP4
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111110111111" => if(sensor="10111" and not(bandera))then -- DOWN4
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111111111101" => if(sensor="10111" and not(bandera))then -- CABINA4
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111111011111" => if(sensor="01111" and not(bandera))then -- DOWN5
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111111111110" => if(sensor="01111" and not(bandera))then -- CABINA5
													salida<="1111111111111";
													pulsador:="1111111111111";
													bandera:=true;
												else
													salida<=pulsador;
													bandera:=false;
												end if;
												
				when "1111111111111" => salida<="1111111111111";-- NADA
												pulsador:="1111111111111";
												bandera:=true;
												
				when others => salida<="1111111111111";-- OTROS CASOS
									pulsador:="1111111111111";
									bandera:=true;
				
			end case;
		
		end if;
				
	elsif(START='0')then
		
		salida<="1111111111111";
		pulsador:="1111111111111";
		pulsad2:="1111111111111";
		bandera:=true;
		
	end if;

end process;

end behab;

