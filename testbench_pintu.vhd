LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY testbench_pintu  IS 
END ; 
 
ARCHITECTURE testbench_pintu_arch OF testbench_pintu IS
  SIGNAL OUTPUT   :  std_logic_vector (1 to 100) := (others =>  '0')  ; 
  SIGNAL RST   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  COMPONENT doors  
    PORT ( 
      OUTPUT  : inout std_logic_vector (1 to 100) ; 
      RST  : in STD_LOGIC ; 
      CLK  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : doors  
    PORT MAP ( 
      OUTPUT   => OUTPUT  ,
      RST   => RST  ,
      CLK   => CLK   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ps, End Time = 1 ns, Period = 100 ps
  Process
	Begin
	 CLK  <= '0'  ;
	wait for 50 ps ;
-- 50 ps, single loop till start period.
	for Z in 1 to 9
	loop
	    CLK  <= '1'  ;
	   wait for 50 ps ;
	    CLK  <= '0'  ;
	   wait for 50 ps ;
-- 950 ps, repeat pattern in loop.
	end  loop;
	 CLK  <= '1'  ;
	wait for 50 ps ;
-- dumped values till 1 ns
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 50 ps, End Time = 10 ns, Period = 0 ps
  Process
	Begin
	 RST  <= '1'  ;
	wait for 50 ps ;
	 RST  <= '0'  ;
	wait for 9950 ps ;
-- dumped values till 10 ns
	wait;
 End Process;
END;
