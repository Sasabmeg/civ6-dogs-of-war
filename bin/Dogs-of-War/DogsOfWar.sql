--------------------------------------------------------------
----	DogsOfWar	------------------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/5/2022 9:39:42 PM						--
--------------------------------------------------------------


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

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_DOGS_OF_WAR_SIEGE', 'KIND_PROMOTION');

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


