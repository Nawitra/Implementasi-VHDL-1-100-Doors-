LIBRARY IEEE;                                               
USE IEEE.STD_LOGIC_1164.ALL;                                

ENTITY TACTICS_vhd_tst IS
END TACTICS_vhd_tst;

ARCHITECTURE TACTICS_arch OF TACTICS_vhd_tst IS  
                                              
	COMPONENT TACTICS
		PORT (
			A 			: IN STD_LOGIC;
			B 			: IN STD_LOGIC;
			CLK 		: IN STD_LOGIC;
			EN 		: INOUT STD_LOGIC;
			OUTPUT 	: OUT STD_LOGIC;
			RST 		: IN STD_LOGIC
		);
	END COMPONENT;
	
	SIGNAL A 		: STD_LOGIC;
	SIGNAL B 		: STD_LOGIC;
	SIGNAL CLK 		: STD_LOGIC;
	SIGNAL EN 		: STD_LOGIC;
	SIGNAL OUTPUT 	: STD_LOGIC;
	SIGNAL RST 		: STD_LOGIC;
	CONSTANT DELAY	: TIME := 20 NS;
	SIGNAL TB_CLK	: STD_LOGIC := '0';
	FOR ALL			: TACTICS USE ENTITY WORK.TACTICS;
	
	BEGIN
		TB_CLK <= NOT CLK AFTER DELAY;
		CLK <= TB_CLK;
		
		TACTICS_PM : TACTICS
		PORT MAP (
			A => A,
			B => B,
			CLK => CLK,
			EN => EN,
			OUTPUT => OUTPUT,
			RST => RST
		);
		
	PROCESS                                               
	BEGIN                                                        
		A <= '0';
		B <= '0';
		
		RST <= '1';
		WAIT FOR DELAY;
		
		RST <= '0';
		WAIT FOR DELAY;
		
		WAIT FOR 10 * DELAY;
		WAIT;
	END PROCESS;
END TACTICS_arch;
