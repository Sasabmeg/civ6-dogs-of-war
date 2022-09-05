--------------------------------------------------------------
----	GameData1	------------------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/5/2022 9:39:42 PM						--
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------
----	Notes:	------------------------------------------------------------------------------------------------------------------
--	TODO: To make it not crash in case similar mods add same primary key values, new rows should be tried to be deleted first,	--
--	this does not ensure compatibility with other mods, but no/less crash. Bugs still could be a thing.							--
----------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------
----	ANCIENT ERA COMBAT BALANCE	--------------------------------------------
--	Update Spearman, Hoplite and Heavy Chariot combat strength for balance.	  --
--------------------------------------------------------------------------------

update Units
set Combat = 28
where UnitType = 'UNIT_SPEARMAN';

update Units
set Combat = 30
where UnitType = 'UNIT_HOPLITE';

update Units
set Combat = 30
where UnitType = 'UNIT_HEAVY_CHARIOT';


--------------------------------------------------------------------------------
----	LIGHT CAVARLY CHANGES	------------------------------------------------
--	Can move after attack.													  --
--------------------------------------------------------------------------------

INSERT INTO "TypeTags" ("Type", "Tag") VALUES ('ABILITY_MOVE_AFTER_ATTACK', 'CLASS_LIGHT_CAVALRY');


--------------------------------------------------------------------------------
----	HEAVY CAVARLY CHANGES	------------------------------------------------
--	Pushback units if major victory.										  --
--------------------------------------------------------------------------------

INSERT INTO "TypeTags" ("Type", "Tag") VALUES ('ABILITY_PUSHBACK', 'CLASS_HEAVY_CAVALRY');


--------------------------------------------------------------------------------
----	MELEE CLASS CHANGES		------------------------------------------------
--	Delete Amphibious to free promotion slot.								  --
--	Moved Tortoise one level higher and added +10 HP all territory.			  --
--	Added Juggernaut 1st level promotion that allows healing every turn.	  --
--------------------------------------------------------------------------------

delete from UnitPromotions where UnitPromotionType = 'PROMOTION_AMPHIBIOUS';
delete from UnitPromotions where UnitPromotionType = 'PROMOTION_TORTOISE';

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_TORTOISE', 'LOC_PROMOTION_TORTOISE_NAME', 'LOC_PROMOTION_TORTOISE_DESCRIPTION', '2', '', 'PROMOTION_CLASS_MELEE', '3');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('TORTOISE_HEAL_EVERYWHERE', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('TORTOISE_HEAL_EVERYWHERE', 'Type', 'ARGTYPE_IDENTITY', 'ALL', '', '');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('TORTOISE_HEAL_EVERYWHERE', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');

INSERT INTO UnitPromotionModifiers VALUES ('PROMOTION_TORTOISE', 'TORTOISE_HEAL_EVERYWHERE');

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_JUGGERNAUT', 'KIND_PROMOTION');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_TORTOISE', 'PROMOTION_JUGGERNAUT');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_ZWEIHANDER', 'PROMOTION_TORTOISE');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_URBAN_WARFARE', 'PROMOTION_TORTOISE');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_JUGGERNAUT', 'LOC_PROMOTION_JUGGERNAUT_NAME', 'LOC_PROMOTION_JUGGERNAUT_DESCRIPTION', '1', '', 'PROMOTION_CLASS_MELEE', '3');

INSERT INTO UnitPromotionModifiers VALUES ('PROMOTION_JUGGERNAUT', 'MAMLUK_HEAL_EVERY_MOVE');


--------------------------------------------------------------------------------
----	ANTI-CAVALRY CLASS CHANGES		----------------------------------------
--	Merged Thrust into Echelon to free promotion slot.						  --
--	Swapped Square and Schiltron promotion locations.						  --
--	Added Forced March 1st level promotion that allows healing every turn.	  --
--------------------------------------------------------------------------------

--	add Forced March
delete from UnitPromotions where UnitPromotionType = 'PROMOTION_THRUST';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_FORCED_MARCH', 'KIND_PROMOTION');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_SCHILTRON', 'PROMOTION_FORCED_MARCH');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_FORCED_MARCH', 'LOC_PROMOTION_FORCED_MARCH_NAME', 'LOC_PROMOTION_FORCED_MARCH_DESCRIPTION', '1', '', 'PROMOTION_CLASS_ANTI_CAVALRY', '3');

INSERT INTO UnitPromotionModifiers VALUES ('PROMOTION_FORCED_MARCH', 'MAMLUK_HEAL_EVERY_MOVE');

--	swap Schiltron and Square
delete from UnitPromotionPrereqs where UnitPromotion = 'PROMOTION_SQUARE';
delete from UnitPromotionPrereqs where PrereqUnitPromotion = 'PROMOTION_SQUARE';

delete from UnitPromotionPrereqs where UnitPromotion = 'PROMOTION_SCHILTRON';
delete from UnitPromotionPrereqs where PrereqUnitPromotion = 'PROMOTION_SCHILTRON';

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_SCHILTRON', 'PROMOTION_ECHELON');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_REDEPLOY', 'PROMOTION_SCHILTRON');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_CHOKE_POINTS', 'PROMOTION_SCHILTRON');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_SQUARE', 'PROMOTION_FORCED_MARCH');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_REDEPLOY', 'PROMOTION_SQUARE');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_CHOKE_POINTS', 'PROMOTION_SQUARE');

--	add extra healing to Square (more on friendly territory, less on enemy territory)
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('SQUARE_HEAL_FRIENDLY', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('SQUARE_HEAL_NEUTRAL', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('SQUARE_HEAL_ENEMY', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('SQUARE_HEAL_FRIENDLY', 'Type', 'ARGTYPE_IDENTITY', 'FRIENDLY', '', '');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('SQUARE_HEAL_FRIENDLY', 'Amount', 'ARGTYPE_IDENTITY', '15', '', '');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('SQUARE_HEAL_NEUTRAL', 'Type', 'ARGTYPE_IDENTITY', 'NEUTRAL', '', '');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('SQUARE_HEAL_NEUTRAL', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('SQUARE_HEAL_ENEMY', 'Type', 'ARGTYPE_IDENTITY', 'ENEMY', '', '');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('SQUARE_HEAL_ENEMY', 'Amount', 'ARGTYPE_IDENTITY', '5', '', '');

--	merge trust into echelon
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_ECHELON', 'THRUST_BONUS_VS_MELEE');


--------------------------------------------------------------------------------
----	DOGS OF WAR PROMOTION FOR ALL CLASSES	--------------------------------
--	4th level promotion for all classes that adds additional combat strength  --
--	for the unit. This is done to make veteran units more valuable and be 	  --
--	able to fight AI on higher difficulty in case of science gap. Similar to  --
--	Vampires or Heroes in DLC game mods where some units become valuable,	  --
--	but smoother integration into game mechanics and more balanced.			  --
--	(Still fun, but not cheesy gameplay where your vampire 2 shots cities	  --
--	with walls or Hero converts catapult army of AI to conquer them with it.) --
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
----	DOGS OF WAR - MELEE CLASS		----------------------------------------
--------------------------------------------------------------------------------
update UnitPromotions set Column = '1' where UnitPromotionType = 'PROMOTION_ELITE_GUARD';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_DOGS_OF_WAR_MELEE', 'KIND_PROMOTION');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_DOGS_OF_WAR_MELEE', 'LOC_PROMOTION_DOGS_OF_WAR_MELEE_NAME', 'LOC_PROMOTION_DOGS_OF_WAR_MELEE_DESCRIPTION', '4', '', 'PROMOTION_CLASS_MELEE', '3');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_MELEE', 'PROMOTION_ZWEIHANDER');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_MELEE', 'PROMOTION_URBAN_WARFARE');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('DOGS_OF_WAR_INCREASED_COMBAT_STRENGTH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('DOGS_OF_WAR_INCREASED_COMBAT_STRENGTH', 'Amount', 'ARGTYPE_IDENTITY', '5', '', '');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_DOGS_OF_WAR_MELEE', 'DOGS_OF_WAR_INCREASED_COMBAT_STRENGTH');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('DOGS_OF_WAR_INCREASED_COMBAT_STRENGTH', 'Preview', '+{1_Amount} {LOC_PROMOTION_DOGS_OF_WAR_MELEE_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');

--------------------------------------------------------------------------------
----	DOGS OF WAR - ANTI-CAVALRY CLASS		--------------------------------
--------------------------------------------------------------------------------
update UnitPromotions set Column = '1' where UnitPromotionType = 'PROMOTION_HOLD_THE_LINE';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_DOGS_OF_WAR_ANTI_CAVALRY', 'KIND_PROMOTION');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_DOGS_OF_WAR_ANTI_CAVALRY', 'LOC_PROMOTION_DOGS_OF_WAR_ANTI_CAVALRY_NAME', 'LOC_PROMOTION_DOGS_OF_WAR_ANTI_CAVALRY_DESCRIPTION', '4', '', 'PROMOTION_CLASS_ANTI_CAVALRY', '3');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_ANTI_CAVALRY', 'PROMOTION_REDEPLOY');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_ANTI_CAVALRY', 'PROMOTION_CHOKE_POINTS');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_DOGS_OF_WAR_ANTI_CAVALRY', 'DOGS_OF_WAR_INCREASED_COMBAT_STRENGTH');

--------------------------------------------------------------------------------
----	DOGS OF WAR - LIGHT-CAVALRY CLASS		--------------------------------
--------------------------------------------------------------------------------
update UnitPromotions set Column = '1' where UnitPromotionType = 'PROMOTION_ESCORT_MOBILITY';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_DOGS_OF_WAR_LIGHT_CAVALRY', 'KIND_PROMOTION');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_DOGS_OF_WAR_LIGHT_CAVALRY', 'LOC_PROMOTION_DOGS_OF_WAR_LIGHT_CAVALRY_NAME', 'LOC_PROMOTION_DOGS_OF_WAR_LIGHT_CAVALRY_DESCRIPTION', '4', '', 'PROMOTION_CLASS_LIGHT_CAVALRY', '3');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_LIGHT_CAVALRY', 'PROMOTION_PURSUIT');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_LIGHT_CAVALRY', 'PROMOTION_SPIKING_THE_GUNS');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_DOGS_OF_WAR_LIGHT_CAVALRY', 'DOGS_OF_WAR_INCREASED_COMBAT_STRENGTH');

--------------------------------------------------------------------------------
----	DOGS OF WAR - HEAVY-CAVALRY CLASS		--------------------------------
--------------------------------------------------------------------------------
update UnitPromotions set Column = '1' where UnitPromotionType = 'PROMOTION_BREAKTHROUGH';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_DOGS_OF_WAR_HEAVY_CAVALRY', 'KIND_PROMOTION');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_DOGS_OF_WAR_HEAVY_CAVALRY', 'LOC_PROMOTION_DOGS_OF_WAR_HEAVY_CAVALRY_NAME', 'LOC_PROMOTION_DOGS_OF_WAR_HEAVY_CAVALRY_DESCRIPTION', '4', '', 'PROMOTION_CLASS_HEAVY_CAVALRY', '3');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_HEAVY_CAVALRY', 'PROMOTION_REACTIVE_ARMOR');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_HEAVY_CAVALRY', 'PROMOTION_ARMOR_PIERCING');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_DOGS_OF_WAR_HEAVY_CAVALRY', 'DOGS_OF_WAR_INCREASED_COMBAT_STRENGTH');

--------------------------------------------------------------------------------
----	DOGS OF WAR - RANGED CLASS		----------------------------------------
--------------------------------------------------------------------------------
update UnitPromotions set Column = '1' where UnitPromotionType = 'PROMOTION_EXPERT_MARKSMAN';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_DOGS_OF_WAR_RANGED', 'KIND_PROMOTION');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_DOGS_OF_WAR_RANGED', 'LOC_PROMOTION_DOGS_OF_WAR_RANGED_NAME', 'LOC_PROMOTION_DOGS_OF_WAR_RANGED_DESCRIPTION', '4', '', 'PROMOTION_CLASS_RANGED', '3');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_RANGED', 'PROMOTION_SUPPRESSION');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_RANGED', 'PROMOTION_EMPLACEMENT');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('DOGS_OF_WAR_RANGED_INCREASED_COMBAT_STRENGTH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, 'ARROW_STORM_REQUIREMENTS', '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('DOGS_OF_WAR_RANGED_INCREASED_COMBAT_STRENGTH', 'Amount', 'ARGTYPE_IDENTITY', '5', '', '');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_DOGS_OF_WAR_RANGED', 'DOGS_OF_WAR_RANGED_INCREASED_COMBAT_STRENGTH');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('DOGS_OF_WAR_RANGED_INCREASED_COMBAT_STRENGTH', 'Preview', '+{1_Amount} {LOC_PROMOTION_DOGS_OF_WAR_RANGED_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');

--------------------------------------------------------------------------------
----	DOGS OF WAR - SIEGE CLASS		----------------------------------------
--------------------------------------------------------------------------------
update UnitPromotions set Column = '1' where UnitPromotionType = 'PROMOTION_FORWARD_OBSERVERS';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_DOGS_OF_WAR_RANGED', 'KIND_PROMOTION');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_DOGS_OF_WAR_SIEGE', 'LOC_PROMOTION_DOGS_OF_WAR_SIEGE_NAME', 'LOC_PROMOTION_DOGS_OF_WAR_SIEGE_DESCRIPTION', '4', '', 'PROMOTION_CLASS_SIEGE', '3');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_SIEGE', 'PROMOTION_EXPERT_CREW');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DOGS_OF_WAR_SIEGE', 'PROMOTION_ADVANCED_RANGEFINDING');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('DOGS_OF_WAR_SIEGE_INCREASED_COMBAT_STRENGTH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, 'SHELLS_REQUIREMENTS', '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('DOGS_OF_WAR_SIEGE_INCREASED_COMBAT_STRENGTH', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_DOGS_OF_WAR_SIEGE', 'DOGS_OF_WAR_SIEGE_INCREASED_COMBAT_STRENGTH');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('DOGS_OF_WAR_SIEGE_INCREASED_COMBAT_STRENGTH', 'Preview', '+{1_Amount} {LOC_PROMOTION_DOGS_OF_WAR_SIEGE_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');


--------------------------------------------------------------------------------
----	PRAETORIAN GUARDIANS POLICY CARD	------------------------------------
--	Added similar card as in dramatic ages game mode, but it's more defensive --
--	as it heals less in enemy and more in friendly territory.				  --
--------------------------------------------------------------------------------

INSERT INTO Types ("Type", "Kind") VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'KIND_POLICY');

INSERT INTO Policies ("PolicyType", "Description", "PrereqCivic", "PrereqTech", "Name", "GovernmentSlotType", "RequiresGovernmentUnlock", "ExplicitUnlock") 
VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'LOC_POLICY_PRAETORIAN_GUARDIANS_DESCRIPTION', 'CIVIC_CODE_OF_LAWS', NULL, 'LOC_POLICY_PRAETORIAN_GUARDIANS_NAME', 'SLOT_MILITARY', '0', '0');

INSERT INTO Modifiers ("ModifierId", "ModifierType", "RunOnce", "NewOnly", "Permanent", "Repeatable", "OwnerRequirementSetId", "SubjectRequirementSetId", "OwnerStackLimit", "SubjectStackLimit") 
VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_FRIENDLY', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO Modifiers ("ModifierId", "ModifierType", "RunOnce", "NewOnly", "Permanent", "Repeatable", "OwnerRequirementSetId", "SubjectRequirementSetId", "OwnerStackLimit", "SubjectStackLimit") 
VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_NEUTRAL', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO Modifiers ("ModifierId", "ModifierType", "RunOnce", "NewOnly", "Permanent", "Repeatable", "OwnerRequirementSetId", "SubjectRequirementSetId", "OwnerStackLimit", "SubjectStackLimit") 
VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_ENEMY', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_FRIENDLY', 'Amount', 'ARGTYPE_IDENTITY', '15', '', '');
INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_FRIENDLY', 'Type', 'ARGTYPE_IDENTITY', 'FRIENDLY', '', '');

INSERT INTO PolicyModifiers ("PolicyType", "ModifierId") VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'POLICY_PRAETORIAN_GUARDIANS_HEALING_FRIENDLY');

INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_NEUTRAL', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');
INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_NEUTRAL', 'Type', 'ARGTYPE_IDENTITY', 'NEUTRAL', '', '');

INSERT INTO PolicyModifiers ("PolicyType", "ModifierId") VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'POLICY_PRAETORIAN_GUARDIANS_HEALING_NEUTRAL');

INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_ENEMY', 'Amount', 'ARGTYPE_IDENTITY', '5', '', '');
INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_ENEMY', 'Type', 'ARGTYPE_IDENTITY', 'ENEMY', '', '');

INSERT INTO PolicyModifiers ("PolicyType", "ModifierId") VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'POLICY_PRAETORIAN_GUARDIANS_HEALING_ENEMY');


--------------------------------------------------------------------------------
----	REMOVED UNIT PRODUCTION POLICY CARDS	--------------------------------
--	Mainly to stop AI unit spam on higher difficulties, player can use the 	  --
--	Praetorian Guardians policy card to compensate for unit loss and outplay  --
--	the AI.																	  --
--	TODO: Add production modifiers to encampment buildings.					  --
--	TODO: Add combat bonus for units trained at different level of encampment --
--	district buildings.														  --
--------------------------------------------------------------------------------

delete from Policies
where PolicyType in ('POLICY_AGOGE', 'POLICY_FEUDAL_CONTRACT', 'POLICY_GRANDE_ARMEE', 'POLICY_MILITARY_FIRST', 
					 'POLICY_MANEUVER', 'POLICY_CHIVALRY', 'POLICY_LIGHTNING_WARFARE',
					 'POLICY_MARITIME_INDUSTRIES', 'POLICY_PRESS_GANGS', 'POLICY_INTERNATIONAL_WATERS');


--------------------------------------------------------------------------------
----	MORE BARBARIAN AND KILL XP	--------------------------------------------
--	Barbarians will give XP regularly up to two promotion leves now.		  --
--	Soft XP cap increased from 1 to 3.									 	  --
--	Kill bonus for all units increased to 7 to promote stealing kills from    --
--	AI or other players as tactic.											  --
--	Increased maximum experience gained in one combat action from 10 to 15.	  --
--------------------------------------------------------------------------------

/*
delete from GlobalParameters where Name = 'EXPERIENCE_BARB_SOFT_CAP';
insert into GlobalParameters (Name, Value) values ('EXPERIENCE_BARB_SOFT_CAP', '2');

delete from GlobalParameters where Name = 'EXPERIENCE_MAX_BARB_LEVEL';
insert into GlobalParameters (Name, Value) values ('EXPERIENCE_MAX_BARB_LEVEL', '3');

delete from GlobalParameters where Name = 'EXPERIENCE_KILL_BONUS';
insert into GlobalParameters (Name, Value) values ('EXPERIENCE_KILL_BONUS', '5');
*/

update GlobalParameters where Name = 'EXPERIENCE_BARB_SOFT_CAP' set Value = '3';
update GlobalParameters where Name = 'EXPERIENCE_MAX_BARB_LEVEL' set Value = '3';
update GlobalParameters where Name = 'EXPERIENCE_KILL_BONUS' set Value = '7';
update GlobalParameters where Name = 'EXPERIENCE_MAXIMUM_ONE_COMBAT' set Value = '15';

--------------------------------------------------------------------------------
----	MINOR WARMONGER ADJUSTMENTS		----------------------------------------
--	Less Warmonger on city raze.											  --
--	Dobule Warmonger decay while at war.								 	  --
--------------------------------------------------------------------------------

/*
delete from GlobalParameters where Name = 'WAR_WEARINESS_DECAY_TURN_AT_WAR';
insert into GlobalParameters (Name, Value) values ('WAR_WEARINESS_DECAY_TURN_AT_WAR', '100');

delete from GlobalParameters where Name = 'WARMONGER_RAZE_PENALTY_PERCENT';
insert into GlobalParameters (Name, Value) values ('WARMONGER_RAZE_PENALTY_PERCENT', '100');
*/
update GlobalParameters where Name = 'WAR_WEARINESS_DECAY_TURN_AT_WAR' set Value = '100';
update GlobalParameters where Name = 'WARMONGER_RAZE_PENALTY_PERCENT' set Value = '150';


--------------------------------------------------------------------------------
----	LESS CITIES ON SAME AREA	--------------------------------------------
--	Increased minimum distance between cities to counter AI city spam. It	  --
--	might be harder to find good city spots and clearing of AI city might be  --
--	necessary.																  --
--------------------------------------------------------------------------------

/*
delete from GlobalParameters where Name = 'CITY_MIN_RANGE';
insert into GlobalParameters (Name, Value) values ('CITY_MIN_RANGE', '5');
*/
update GlobalParameters where Name = 'CITY_MIN_RANGE' set Value = '5';

--------------------------------------------------------------------------------
----	LESS AI TRADE OR PEACE OFFER 	----------------------------------------
--	Since this is very annoying when waging war against multiple enemies, AI  --
--	will pop offers less frequently.										  --
--------------------------------------------------------------------------------

update GlobalParameters where Name = 'AI_TURNS_BETWEEN_FRIENDSHIP_OFFERS' set Value = '10';
update GlobalParameters where Name = 'AI_TURNS_BETWEEN_PEACE_OFFERS' set Value = '10';
update GlobalParameters where Name = 'AI_TURNS_BETWEEN_TRADES' set Value = '10';


