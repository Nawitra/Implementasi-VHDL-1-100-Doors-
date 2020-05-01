LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TACTICS IS
	PORT (
		CLK		:	IN STD_LOGIC;
		RST		:	IN STD_LOGIC;
		INPUT_1	:	IN STD_LOGIC;
		INPUT_2	:	IN STD_LOGIC;
		OUTPUT	:	OUT STD_LOGIC
	);
END TACTICS;

ARCHITECTURE BEHAVIOUR OF TACTICS IS

TYPE STATE IS (PLAN, TRAIN, ATTACK, AMBUSHED, STRUGGLE, RETREAT, WIN, STOP);
SIGNAL PRESENT		: STATE;
SIGNAL NEXT_STATE	: STATE;
SIGNAL TEMP			: STD_LOGIC;

BEGIN

--Cek kondisi
PROCESS(CLK, PRESENT, INPUT_1, INPUT_2) IS
	BEGIN
		CASE PRESENT IS
			--Kondisi saat ini 'Plan'
			WHEN PLAN =>
				IF(INPUT_1='0' AND INPUT_2='0') THEN
					NEXT_STATE <= TRAIN;
				ELSIF(INPUT_1='0' AND INPUT_2='1') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(INPUT_1='1' AND INPUT_2='0') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(INPUT_1='1' AND INPUT_2='1') THEN
					NEXT_STATE <= ATTACK;
				ELSE
					NEXT_STATE <= PLAN;
				END IF;
			--Kondisi saat ini 'Train'
			WHEN TRAIN =>
				IF(INPUT_1='0' AND INPUT_2='0') THEN
					NEXT_STATE <= TRAIN;
				ELSIF(INPUT_1='0' AND INPUT_2='1') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(INPUT_1='1' AND INPUT_2='0') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(INPUT_1='1' AND INPUT_2='1') THEN
					NEXT_STATE <= ATTACK;
				ELSE
					NEXT_STATE <= TRAIN;
				END IF;
			--Kondisi saat ini 'Attack'
			WHEN ATTACK =>
				IF(INPUT_1='0' AND INPUT_2='0') THEN
					NEXT_STATE <= AMBUSHED;
				ELSIF(INPUT_1='0' AND INPUT_2='1') THEN
					NEXT_STATE <= WIN;
				ELSIF(INPUT_1='1' AND INPUT_2='0') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(INPUT_1='1' AND INPUT_2='1') THEN
					NEXT_STATE <= WIN;
				ELSE
					NEXT_STATE <= ATTACK;
				END IF;
			--Kondisi saat ini 'Ambushed'
			WHEN AMBUSHED =>
				IF(INPUT_1='0' AND INPUT_2='0') THEN
					NEXT_STATE <= RETREAT;
				ELSIF(INPUT_1='0' AND INPUT_2='1') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(INPUT_1='1' AND INPUT_2='0') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(INPUT_1='1' AND INPUT_2='1') THEN
					NEXT_STATE <= WIN;
				ELSE
					NEXT_STATE <= AMBUSHED;
				END IF;
			--Kondisi saat ini 'Struggle'
			WHEN STRUGGLE =>
				IF(INPUT_1='0' AND INPUT_2='0') THEN
					NEXT_STATE <= RETREAT;
				ELSIF(INPUT_1='0' AND INPUT_2='1') THEN
					NEXT_STATE <= WIN;
				ELSIF(INPUT_1='1' AND INPUT_2='0') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(INPUT_1='1' AND INPUT_2='1') THEN
					NEXT_STATE <= WIN;
				ELSE
					NEXT_STATE <= STRUGGLE;
				END IF;
			--Kondisi saat ini 'Retreat'
			WHEN RETREAT =>
				NEXT_STATE <= PLAN;
			--Kondisi telah 'Win'
			WHEN WIN =>
				NEXT_STATE <= STOP;
			--Apabila kondisi diluar dari yang telah ditentukan
			WHEN OTHERS => NULL;
		END CASE;
END PROCESS;

PROCESS(CLK, RST) IS
	BEGIN
		IF(RST='1') THEN
			TEMP 	 <= '0';
			OUTPUT <= '0';
		END IF;
	
		IF(RISING_EDGE(CLK)) THEN
			CASE PRESENT IS
				--Cek apabila nilai present = 'Plan'
				WHEN PLAN =>
					IF(NEXT_STATE=TRAIN) THEN
						TEMP <= '0';
					ELSIF(NEXT_STATE=ATTACK) THEN
						TEMP <= '1';
					ELSE
						TEMP <= 'X';
					END IF;
				--Cek apabila nilai present = 'Train'
				WHEN TRAIN => 
					IF(NEXT_STATE=TRAIN) THEN
						TEMP <= '0';
					ELSIF(NEXT_STATE=ATTACK) THEN
						TEMP <= '1';
					ELSE
						TEMP <= 'X';
					END IF;
				--Cek apabila nilai present = 'Attack'
				WHEN ATTACK =>
					IF(NEXT_STATE=AMBUSHED OR NEXT_STATE=WIN OR NEXT_STATE=STRUGGLE) THEN
						TEMP <= '1';
					ELSE
						TEMP <= 'X';
					END IF;
				--Cek apabila nilai present = 'Ambushed'
				WHEN AMBUSHED =>
					IF(NEXT_STATE=RETREAT OR NEXT_STATE=ATTACK OR NEXT_STATE=STRUGGLE OR NEXT_STATE=WIN) THEN
						TEMP <= '1';
					ELSE
						TEMP <= 'X';
					END IF;
				--Cek apabila nilai present = 'Struggle'
				WHEN STRUGGLE =>
					IF(NEXT_STATE=RETREAT OR NEXT_STATE=WIN) THEN
						TEMP <= '1';
					ELSIF(NEXT_STATE=STRUGGLE) THEN
						TEMP <= '0';
					END IF;
				--Cek apabila nilai present = 'Retreat'
				WHEN RETREAT =>
					IF(NEXT_STATE=PLAN) THEN
						TEMP <= '1';
					ELSE
						TEMP <= 'X';
					END IF;
				--Cek apabila telah 'Win'
				WHEN WIN =>
					IF(NEXT_STATE=STOP) THEN
						TEMP <= 'X';
					ELSE
						TEMP <= 'X';
					END IF;
				WHEN OTHERS => NULL;
			END CASE;
			PRESENT <= NEXT_STATE;
		END IF;
END PROCESS;
END BEHAVIOUR;