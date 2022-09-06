--------------------------------------------------------------
----	GlobalParameters	----------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/6/2022 4:00:22 PM						--
--------------------------------------------------------------


--------------------------------------------------------------------------------
----	MORE BARBARIAN AND KILL XP	--------------------------------------------
--	Barbarians will give XP regularly up to two promotion leves now.		  --
--	Soft XP cap increased from 1 to 3.									 	  --
--	Kill bonus for all units increased to 7 to promote stealing kills from    --
--	AI or other players as tactic.											  --
--	Increased maximum experience gained in one combat action from 10 to 15.	  --
--------------------------------------------------------------------------------

update GlobalParameters set Value = '3' where Name = 'EXPERIENCE_BARB_SOFT_CAP';
update GlobalParameters set Value = '3' where Name = 'EXPERIENCE_MAX_BARB_LEVEL';
update GlobalParameters set Value = '7' where Name = 'EXPERIENCE_KILL_BONUS';
update GlobalParameters set Value = '15' where Name = 'EXPERIENCE_MAXIMUM_ONE_COMBAT';


--------------------------------------------------------------------------------
----	MINOR WARMONGER ADJUSTMENTS		----------------------------------------
--	Less Warmonger on city raze.											  --
--	Dobule Warmonger decay while at war.								 	  --
--------------------------------------------------------------------------------

update GlobalParameters set Value = '100' where Name = 'WAR_WEARINESS_DECAY_TURN_AT_WAR';
update GlobalParameters set Value = '150' where Name = 'WARMONGER_RAZE_PENALTY_PERCENT';


--------------------------------------------------------------------------------
----	LESS CITIES ON SAME AREA	--------------------------------------------
--	Increased minimum distance between cities to counter AI city spam. It	  --
--	might be harder to find good city spots and clearing of AI city might be  --
--	necessary.																  --
--------------------------------------------------------------------------------

update GlobalParameters set Value = '4' where Name = 'CITY_MIN_RANGE';


--------------------------------------------------------------------------------
----	LESS AI TRADE OR PEACE OFFER 	----------------------------------------
--	Since this is very annoying when waging war against multiple enemies, AI  --
--	will pop offers less frequently.										  --
--------------------------------------------------------------------------------

update GlobalParameters set Value = '10' where Name = 'AI_TURNS_BETWEEN_FRIENDSHIP_OFFERS';
update GlobalParameters set Value = '10' where Name = 'AI_TURNS_BETWEEN_PEACE_OFFERS';
update GlobalParameters set Value = '10' where Name = 'AI_TURNS_BETWEEN_TRADES';
