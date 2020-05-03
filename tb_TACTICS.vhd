LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_TACTICS IS
END tb_TACTICS;

ARCHITECTURE BEHAVIOUR OF tb_TACTICS IS

	COMPONENT TACTICS
	  PORT (CLK    : IN STD_LOGIC;
			  RST    : IN STD_LOGIC;
			  A      : IN STD_LOGIC;
			  B      : IN STD_LOGIC;
			  OUTPUT : OUT STD_LOGIC);
	END COMPONENT;

	SIGNAL CLK    		: STD_LOGIC;
	SIGNAL RST    		: STD_LOGIC;
	SIGNAL A      		: STD_LOGIC;
	SIGNAL B      		: STD_LOGIC;
	SIGNAL OUTPUT 		: STD_LOGIC;

	CONSTANT DELAY 	: TIME := 20 NS;
	SIGNAL tb_CLOCK	: STD_LOGIC := '0';
	SIGNAL tb_END 		: STD_LOGIC := '0';
	FOR ALL 				: TACTICS USE ENTITY WORK.TACTICS(STATE_MACHINE);		
		 
BEGIN

	TACTICS_PM:
   TACTICS PORT MAP (CLK    => CLK,
							RST    => RST,
							A      => A,
							B      => B,
							OUTPUT => OUTPUT);

	--Untuk clock
	PROCESS
		BEGIN
		IF(tb_END='0') THEN
			tb_CLOCK <= NOT tb_CLOCK AFTER DELAY;
			CLK <= tb_CLOCK;
		ELSE
			tb_CLOCK <= '0';
			CLK <= tb_CLOCK;
		END IF;
	END PROCESS;

   PROCESS
		BEGIN
			 --Inisialisasi input
			 A <= '0';
			 B <= '0';

			 --Untuk reset
			 RST <= '1';
			 WAIT FOR 30 NS;
			 RST <= '0';
			 WAIT FOR 30 NS;

			 --Menambahkan delay
			 WAIT FOR 10 * DELAY;

			 --Menyelesaikan simulasi dengan mematikan clock
			 tb_END <= '1';
			 WAIT;
   END PROCESS;

END BEHAVIOUR;
