LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PINTU IS
	
	PORT (	
				CLK			: IN STD_LOGIC;
				RST			: IN STD_LOGIC;
				OUTPUT		: INOUT STD_LOGIC_VECTOR(1 TO 100) := (OTHERS => '0')
	);
END PINTU;

ARCHITECTURE BEHAVIOUR OF PINTU IS
	TYPE STATE IS (TERBUKA, TERTUTUP);
	SIGNAL PRESENT			: STATE;
	SIGNAL NEXT_STATE		: STATE;
	SIGNAL PINTU 			: INTEGER RANGE 1 TO 100;
	SIGNAL KELIPATAN		: INTEGER RANGE 1 TO 6;
	
BEGIN
	PROCESS(CLK, RST) IS
		BEGIN
			IF (RST='1') THEN
				PINTU			<= 1;
				KELIPATAN	<= 1;
				OUTPUT		<= (OTHERS => '0');
			END IF;
			
					
			IF (RISING_EDGE(CLK)) THEN	
			
			--Cek apakah kelipatannya adalah 3
			IF (KELIPATAN = 3) THEN
				IF (PINTU < 99) THEN --Maksimal kelipatan 3 adalah 99
					OUTPUT(PINTU) <= NOT(OUTPUT(PINTU));
					PINTU <= PINTU + KELIPATAN;
					
				ELSIF (KELIPATAN < 6) THEN
					PINTU <= KELIPATAN + 1;
					KELIPATAN <= KELIPATAN + 1;
						
				ELSE
					PINTU <= 1;
					KELIPATAN <= 1;
				END IF;
					
				ELSIF (PINTU < 100) THEN
					OUTPUT(PINTU) <= NOT(OUTPUT(PINTU));
					PINTU <= PINTU + KELIPATAN;
				
					
					--Cek state dari pintu saat ini
					IF ((PINTU MOD KELIPATAN) = 0) THEN
						IF (PRESENT = TERBUKA) THEN
							NEXT_STATE <= TERTUTUP;
						ELSIF (PRESENT = TERTUTUP) THEN
							NEXT_STATE <= TERBUKA;
						END IF;
					END IF;				
					
				
					
				ELSIF (KELIPATAN < 6) THEN
					PINTU <= KELIPATAN + 1;
					KELIPATAN <= KELIPATAN + 1;
				ELSE
					PINTU <= 1;
					KELIPATAN <= 1;
				END IF;
			
				
				--Supaya di luar clock edge tetap terdapat nilai
			ELSE
				OUTPUT <= OUTPUT;
				PINTU <= PINTU;
				KELIPATAN <= KELIPATAN;
			END IF;
		PRESENT <= NEXT_STATE;
	END PROCESS;

END BEHAVIOUR;
