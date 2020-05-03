LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY TACTICS IS
	PORT (
		CLK		:	IN STD_LOGIC;
		RST		:	IN STD_LOGIC;
		A			:	IN STD_LOGIC;
		B			:	IN STD_LOGIC;
		EN			:	INOUT STD_LOGIC;
		OUTPUT	:	OUT STD_LOGIC
	);
END TACTICS;

ARCHITECTURE BEHAVIOUR OF TACTICS IS

TYPE STATE IS (PLAN, TRAIN, ATTACK, AMBUSHED, STRUGGLE, RETREAT, WIN, STOP);
SIGNAL PRESENT				: STATE;
SIGNAL NEXT_STATE			: STATE;
SIGNAL TEMP					: STD_LOGIC;
SIGNAL AF					: INTEGER := 3;
SIGNAL BF					: INTEGER := 6;

PROCEDURE RANDOMIZE_TRAIN ( 
		SIGNAL INPUT_AF	: INOUT INTEGER;
		SIGNAL INPUT_BF	: INOUT INTEGER) IS
BEGIN
		INPUT_AF <= INPUT_AF + (INPUT_AF / 2 + INPUT_AF MOD 3);
		INPUT_BF <= INPUT_BF + (INPUT_BF / 2 + INPUT_BF MOD 6);
		
END PROCEDURE;

PROCEDURE RANDOMIZE_ATTACK (
			SIGNAL INPUT_AF : INOUT INTEGER;
			SIGNAL INPUT_BF : INOUT INTEGER) IS
BEGIN
		
		--Mengevaluasikan damage ketika PRESENT=AMBUSH
		IF(PRESENT=AMBUSHED AND EN='0') THEN
			INPUT_AF <= INPUT_AF - (INPUT_BF + INPUT_BF MOD 4);
			INPUT_BF <= INPUT_BF - (INPUT_AF + INPUT_AF MOD 3);
		ELSIF(PRESENT=AMBUSHED AND EN='1') THEN
			INPUT_AF <= INPUT_AF - (INPUT_AF + INPUT_BF MOD 5);	
			INPUT_BF <= INPUT_BF - (INPUT_AF + INPUT_AF MOD 5);
		END IF;
		
		--Mengevaluasikan damage ketika PRESENT=ATTACK
		IF(PRESENT=ATTACK AND EN='0') THEN
			INPUT_BF <= INPUT_BF - (INPUT_AF + INPUT_AF MOD 4);
			INPUT_AF <= INPUT_AF - (INPUT_AF + INPUT_BF MOD 2);
		ELSIF(PRESENT=ATTACK AND EN='1') THEN
			INPUT_BF <= INPUT_BF - (INPUT_AF + INPUT_AF MOD 6);
			INPUT_AF <= INPUT_AF - (INPUT_BF + INPUT_BF MOD 2);
		END IF;
		
		--Mengevaluasikan damage ketika PRESENT=RETREAT
		IF(PRESENT=RETREAT AND EN='0') THEN
			INPUT_AF <= INPUT_AF - (INPUT_BF + INPUT_BF MOD 6);
			INPUT_BF <= INPUT_BF - (INPUT_AF + INPUT_AF MOD 1);
		ELSIF(PRESENT=RETREAT AND EN='1') THEN
			INPUT_AF <= INPUT_AF - (INPUT_BF + INPUT_BF MOD 6);
			INPUT_BF <= INPUT_BF - (INPUT_AF + INPUT_AF MOD 3);	
		END IF;
		
		--Mengevaluasikan damage ketika PRESENT=STRUGGLE
		IF(PRESENT=STRUGGLE AND EN='0') THEN
			INPUT_BF <= INPUT_BF - (INPUT_AF + INPUT_AF MOD 4);
			INPUT_AF <= INPUT_AF - (INPUT_BF + INPUT_BF MOD 4);
		ELSIF(PRESENT=STRUGGLE AND EN='1') THEN
			INPUT_BF <= INPUT_BF - (INPUT_AF + INPUT_AF MOD 5);
			INPUT_AF <= INPUT_AF - (INPUT_BF + INPUT_BF MOD 4);			
		END IF;
		
		--Fail-safe bila AF dan BF bernilai negatif
		IF((INPUT_AF<0) OR (INPUT_BF<0)) THEN
			INPUT_AF <= 1;
			INPUT_BF <= 1;
		END IF;
		
END PROCEDURE;

BEGIN

--Cek kondisi
PROCESS(CLK, PRESENT, A, B) IS
	BEGIN
		CASE PRESENT IS
			--Kondisi saat ini 'Plan'
			WHEN PLAN =>
				IF(A='0' AND B='0') THEN
					NEXT_STATE <= TRAIN;
				ELSIF(A='0' AND B='1') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(A='1' AND B='0') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(A='1' AND B='1') THEN
					NEXT_STATE <= ATTACK;
				ELSE
					NEXT_STATE <= PLAN;
				END IF;
			--Kondisi saat ini 'Train'
			WHEN TRAIN =>
				IF(A='0' AND B='0') THEN
					NEXT_STATE <= TRAIN;
				ELSIF(A='0' AND B='1') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(A='1' AND B='0') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(A='1' AND B='1') THEN
					NEXT_STATE <= ATTACK;
				ELSE
					NEXT_STATE <= TRAIN;
				END IF;
			--Kondisi saat ini 'Attack'
			WHEN ATTACK =>
				IF(A='0' AND B='0') THEN
					NEXT_STATE <= AMBUSHED;
				ELSIF(A='0' AND B='1' AND EN='0') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(A='0' AND B='1' AND EN='1') THEN
					NEXT_STATE <= WIN;	
				ELSIF(A='1' AND B='0') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(A='1' AND B='1') THEN
					NEXT_STATE <= WIN;
				ELSE
					NEXT_STATE <= ATTACK;
				END IF;
			--Kondisi saat ini 'Ambushed'
			WHEN AMBUSHED =>
				IF(A='0' AND B='0' AND EN='0') THEN
					NEXT_STATE <= RETREAT;
				ELSIF(A='0' AND B='0' AND EN='1') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(A='0' AND B='1') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(A='1' AND B='0') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(A='1' AND B='1' AND EN='0') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(A='1' AND B='1' AND EN='0') THEN
					NEXT_STATE <= WIN;
				ELSE
					NEXT_STATE <= AMBUSHED;
				END IF;
			--Kondisi saat ini 'Struggle'
			WHEN STRUGGLE =>
				IF(A='0' AND B='0' AND EN='0') THEN
					NEXT_STATE <= RETREAT;
				ELSIF(A='0' AND B='0' AND EN='1') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(A='0' AND B='1') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(A='1' AND B='0') THEN
					NEXT_STATE <= STRUGGLE;
				ELSIF(A='1' AND B='1' AND EN='0') THEN
					NEXT_STATE <= ATTACK;
				ELSIF(A='1' AND B='1' AND EN='1') THEN
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
		
		IF(AF>BF) THEN
			EN <= '1';
		ELSE
			EN <= '0';
		END IF;
	
		IF(FALLING_EDGE(CLK)) THEN
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
						RANDOMIZE_TRAIN(AF, BF);
						RANDOMIZE_TRAIN(AF, BF);
						TEMP <= '0';
					ELSIF(NEXT_STATE=ATTACK) THEN
						RANDOMIZE_TRAIN(AF, BF);
						TEMP <= '1';
					ELSE
						TEMP <= 'X';
					END IF;
				--Cek apabila nilai present = 'Attack'
				WHEN ATTACK =>
					IF(NEXT_STATE=AMBUSHED OR NEXT_STATE=WIN OR NEXT_STATE=STRUGGLE) THEN
						RANDOMIZE_ATTACK(AF, BF);
						RANDOMIZE_ATTACK(AF, BF);
						TEMP <= '1';
					ELSE
						TEMP <= 'X';
					END IF;
				--Cek apabila nilai present = 'Ambushed'
				WHEN AMBUSHED =>
					IF(NEXT_STATE=RETREAT OR NEXT_STATE=ATTACK OR NEXT_STATE=STRUGGLE OR NEXT_STATE=WIN) THEN
						RANDOMIZE_ATTACK(AF, BF);
						TEMP <= '1';
					ELSE
						TEMP <= 'X';
					END IF;
				--Cek apabila nilai present = 'Struggle'
				WHEN STRUGGLE =>
					IF(NEXT_STATE=RETREAT OR NEXT_STATE=WIN OR NEXT_STATE=ATTACK) THEN
						RANDOMIZE_ATTACK(AF, BF);
						TEMP <= '1';
					ELSIF(NEXT_STATE=STRUGGLE) THEN
						RANDOMIZE_ATTACK(AF, BF);
						TEMP <= '0';
					END IF;
				--Cek apabila nilai present = 'Retreat'
				WHEN RETREAT =>
					IF(NEXT_STATE=PLAN) THEN
						RANDOMIZE_ATTACK(AF, BF);
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
			TEMP <= TEMP;
			OUTPUT <= TEMP;
		END IF;
	TEMP <= TEMP;
	OUTPUT <= TEMP;
END PROCESS;
END BEHAVIOUR;