#VHDL-code-for-Elevator

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  nextfloor : out std_logic_vector (3 downto 0));
end ElevatorController_Shell;

architecture Behavioral of ElevatorController_Shell is

type floor_state_type is (floor1, floor2, floor3, floor4);

signal floor_state : floor_state_type;

begin


floor_state_machine: process(clk)
begin

	if reset='1' then
			floor_state <= floor1;
	end if;
	if RISING_EDGE(CLK) and stop = '0' then
		
		
			case floor_state is
				
				when floor1 =>
					
					if (up_down='1' and stop='0') then 
						
						floor_state <= floor2;
					
					else
						floor_state <= floor1;
					end if;
				
				when floor2 => 
					
					if (up_down='1' and stop='0') then 
						floor_state <= floor3; 			
					
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor1;
					
					else
						floor_state <= floor2;
					end if;
				

				when floor3 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor2;
					elsif (up_down='1' and stop='0') then 
						floor_state <= floor4;	
					else
						floor_state <= floor3;	
					end if;
				when floor4 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor3;	
					else 
						floor_state <= floor4;
					end if;
				
				
				when others =>
					floor_state <= floor1;
			end case;
		end if;

end process;


floor <= "0001" when (floor_state = floor1) else
			"0010" when (floor_state = floor2) else
			"0011" when (floor_state = floor3) else
			"0100" when (floor_state = floor4) else
			"0001";
nextfloor <= 	"0001" when (floor_state = floor1) and (stop = '1') else
					"0010" when (floor_state = floor2) and (stop = '1') else
					"0011" when (floor_state = floor3) and (stop = '1') else
					"0100" when (floor_state = floor4) and (stop = '1') else
					"0010" when (floor_state = floor1) and (up_down = '1') and (stop = '0') else
					"0011" when (floor_state = floor2) and (up_down = '1') and (stop = '0') else
					"0100" when (floor_state = floor3) and (up_down = '1') and (stop = '0') else
					"0100" when (floor_state = floor4) and (up_down = '1') and (stop = '0') else
					"0001" when (floor_state = floor1) and (up_down = '0') and (stop = '0') else
					"0001" when (floor_state = floor2) and (up_down = '0') and (stop = '0') else
					"0010" when (floor_state = floor3) and (up_down = '0') and (stop = '0') else
					"0011" when (floor_state = floor4) and (up_down = '0') else
					"0001";  

end Behavioral;
