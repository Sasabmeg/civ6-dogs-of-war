--------------------------------------------------------------
----	MeleeChanges	--------------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/6/2022 3:34:04 PM						--
--------------------------------------------------------------

--------------------------------------------------------------------------------
----	MELEE CLASS CHANGES		------------------------------------------------
--	Delete Amphibious to free promotion slot.								  --
--	Moved Tortoise one level higher and added +10 HP all territory.			  --
--	Added Juggernaut 1st level promotion that allows healing every turn.	  --
--------------------------------------------------------------------------------

delete from UnitPromotions where UnitPromotionType = 'PROMOTION_AMPHIBIOUS';
delete from UnitPromotions where UnitPromotionType = 'PROMOTION_TORTOISE';

--	Juggernaut
INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_JUGGERNAUT', 'KIND_PROMOTION');

INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_JUGGERNAUT', 'LOC_PROMOTION_JUGGERNAUT_NAME', 'LOC_PROMOTION_JUGGERNAUT_DESCRIPTION', '1', '', 'PROMOTION_CLASS_MELEE', '3');

INSERT INTO UnitPromotionModifiers VALUES ('PROMOTION_JUGGERNAUT', 'MAMLUK_HEAL_EVERY_MOVE');

--	Tortoise
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_TORTOISE', 'LOC_PROMOTION_TORTOISE_NAME', 'LOC_PROMOTION_TORTOISE_DESCRIPTION', '2', '', 'PROMOTION_CLASS_MELEE', '3');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('TORTOISE_HEAL_EVERYWHERE', 'MODIFIER_PLAYER_UNIT_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('TORTOISE_HEAL_EVERYWHERE', 'Type', 'ARGTYPE_IDENTITY', 'ALL', '', '');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('TORTOISE_HEAL_EVERYWHERE', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');

INSERT INTO UnitPromotionModifiers VALUES ('PROMOTION_TORTOISE', 'TORTOISE_HEAL_EVERYWHERE');
INSERT INTO UnitPromotionModifiers VALUES ('PROMOTION_TORTOISE', 'TORTOISE_DEFENSE_BONUS_VS_RANGED_COMBAT');

--	Promotion tree requirements
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_TORTOISE', 'PROMOTION_JUGGERNAUT');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_ZWEIHANDER', 'PROMOTION_TORTOISE');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_URBAN_WARFARE', 'PROMOTION_TORTOISE');


