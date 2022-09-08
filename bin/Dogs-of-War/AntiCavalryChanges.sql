--------------------------------------------------------------
----	AntiCavalryChanges	----------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/6/2022 3:35:28 PM						--
--------------------------------------------------------------


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

update UnitPromotions set Column = '1' where UnitPromotionType = 'PROMOTION_SCHILTRON';
update UnitPromotions set Column = '3' where UnitPromotionType = 'PROMOTION_SQUARE';

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