LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY testbenchv2  IS 
END ; 
 
ARCHITECTURE testbenchv2_arch OF testbenchv2 IS
  SIGNAL OUTPUT   :  STD_LOGIC  ; 
  SIGNAL A   :  STD_LOGIC  ; 
  SIGNAL RST   :  STD_LOGIC  ; 
  SIGNAL B   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL EN   :  STD_LOGIC  ; 
  COMPONENT TACTICS  
    PORT ( 
      OUTPUT  : out STD_LOGIC ; 
      A  : in STD_LOGIC ; 
      RST  : in STD_LOGIC ; 
      B  : in STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      EN  : inout STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : TACTICS  
    PORT MAP ( 
      OUTPUT   => OUTPUT  ,
      A   => A  ,
      RST   => RST  ,
      B   => B  ,
      CLK   => CLK  ,
      EN   => EN   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 100 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 50 ns ;
-- 50 ns, single loop till start period.
	for Z in 1 to 9
	loop
	    clk  <= '1'  ;
	   wait for 50 ns ;
	    clk  <= '0'  ;
	   wait for 50 ns ;
-- 950 ns, repeat pattern in loop.
	end  loop;
	 clk  <= '1'  ;
	wait for 50 ns ;
-- dumped values till 1 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 100 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
	 rst  <= '1'  ;
	wait for 100 ns ;
	 rst  <= '0'  ;
	wait for 900 ns ;
-- dumped values till 1 us
	wait;
 End Process;
END;
