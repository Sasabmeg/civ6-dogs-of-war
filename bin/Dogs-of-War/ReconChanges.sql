--------------------------------------------------------------
----	ReconChanges	--------------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/8/2022 3:26:06 PM						--
--------------------------------------------------------------

--------------------------------------------------------------------------------
----	Delete unique values just in case.									  --
--------------------------------------------------------------------------------
delete from Types where	Type = 'PROMOTION_DESTINATION_HORIZON' or Type = 'PROMOTION_TIRELESS_STRIDE' or Type = 'PROMOTION_SPECIAL_OPERATIONS';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_DESTINATION_HORIZON', 'KIND_PROMOTION');
INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_TIRELESS_STRIDE', 'KIND_PROMOTION');
INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'KIND_PROMOTION');

--	Delete old Recon promotions, as we swapped too many around so old code might interfere
delete from UnitPromotions
where	UnitPromotionType = 'PROMOTION_RANGER' or UnitPromotionType = 'PROMOTION_ALPINE' or UnitPromotionType = 'PROMOTION_SENTRY' or
		UnitPromotionType = 'PROMOTION_GUERRILLA' or UnitPromotionType = 'PROMOTION_SPYGLASS' or UnitPromotionType = 'PROMOTION_AMBUSH' or
		UnitPromotionType = 'PROMOTION_CAMOUFLAGE';

--	Delete new Recon promotions, just in case some other mod added them
delete from UnitPromotions
where	UnitPromotionType = 'PROMOTION_DESTINATION_HORIZON' or UnitPromotionType = 'PROMOTION_TIRELESS_STRIDE' or UnitPromotionType = 'PROMOTION_SPECIAL_OPERATIONS';


--------------------------------------------------------------------------------
----	RECON PROMOTION CHANGES												  --
--	Left side promotions:  General Scouting									  --
--	Right side promotions: Hit and Run combat style.						  --
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
----	LEFT SIDE PROMOTIONS												  --
--	Level 1. Spyglass: Increase Sight Range by 1.							  --
--	Level 2. Ranger: Faster movement on Hills, Woods and Jungle terrain. Can  --
--			 see through Woods and Jungle.									  --
--	Level 3. Camouflage: Only adjacent enemy units can reveal this unit.	  --
--	Level 4. Destination Horizon: Increased Movement by 1.					  --
--------------------------------------------------------------------------------

--	Spyglass
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_SPYGLASS', 'LOC_PROMOTION_SPYGLASS_NAME', 'LOC_PROMOTION_SPYGLASS_DESCRIPTION', '1', '', 'PROMOTION_CLASS_RECON', '1');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_SPYGLASS', 'SPYGLASS_BONUS_SIGHT');

--	Ranger
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_RANGER', 'LOC_PROMOTION_RANGER_NAME', 'LOC_PROMOTION_RANGER_DESCRIPTION', '2', '', 'PROMOTION_CLASS_RECON', '1');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_RANGER', 'RANGER_IGNORE_FOREST_MOVEMENT_PENALTY');
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_RANGER', 'ALPINE_IGNORE_HILLS_MOVEMENT_PENALTY');
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_RANGER', 'SENTRY_SEE_THROUGH_FEATURES');

--	Camouflage
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_CAMOUFLAGE', 'LOC_PROMOTION_CAMOUFLAGE_NAME', 'LOC_PROMOTION_CAMOUFLAGE_DESCRIPTION', '3', '', 'PROMOTION_CLASS_RECON', '1');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_CAMOUFLAGE', 'CAMOUFLAGE_STEALTH');

--	Destination Horizon
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_DESTINATION_HORIZON', 'LOC_PROMOTION_DESTINATION_HORIZON_NAME', 'LOC_PROMOTION_DESTINATION_HORIZON_DESCRIPTION', '4', '', 'PROMOTION_CLASS_RECON', '1');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_DESTINATION_HORIZON', 'COMMANDO_BONUS_MOVEMENT');


--------------------------------------------------------------------------------
----	RIGTH SIDE PROMOTIONS												  --
--	Level 1. Tireless Stride: Heals at the end of each turn.				  --
--	Level 2. Guerrilla: Can move after attacking and gain +7 Combat Strength	  --
--			 against stronger opponents.									  --
--	Level 3. Ambush: Increased Combat Strength by 3 per unused movement		  --
--			 points.														  --
--	Level 4. Special Operations: Increased Combat Strength by 20.			  --
--------------------------------------------------------------------------------

--	Tireless Stride
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_TIRELESS_STRIDE', 'LOC_PROMOTION_TIRELESS_STRIDE_NAME', 'LOC_PROMOTION_TIRELESS_STRIDE_DESCRIPTION', '1', '', 'PROMOTION_CLASS_RECON', '3');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_TIRELESS_STRIDE', 'MAMLUK_HEAL_EVERY_MOVE');

--	Guerrilla
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_GUERRILLA', 'LOC_PROMOTION_GUERRILLA_NAME', 'LOC_PROMOTION_GUERRILLA_DESCRIPTION', '2', '', 'PROMOTION_CLASS_RECON', '3');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('GUERRILLA_STRONG_AGAINST_STRONGER_UNITS', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, 'COMBAT_AGAINST_STRONGER_UNIT_REQUIREMENTS', '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('GUERRILLA_STRONG_AGAINST_STRONGER_UNITS', 'Amount', 'ARGTYPE_IDENTITY', '7', '', '');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('GUERRILLA_STRONG_AGAINST_STRONGER_UNITS', 'Preview', '+{1_Amount} {LOC_PROMOTION_GUERRILLA_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_GUERRILLA', 'FADE_BONUS_MOVE_AFTER_ATTACKING');
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_GUERRILLA', 'GUERRILLA_STRONG_AGAINST_STRONGER_UNITS');

--	Ambush
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_AMBUSH', 'LOC_PROMOTION_AMBUSH_NAME', 'LOC_PROMOTION_AMBUSH_DESCRIPTION', '3', '', 'PROMOTION_CLASS_RECON', '3');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_AMBUSH', 'CAROLEAN_UNUSED_MOVEMENT_COMBAT');

--	Special Operations
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'LOC_PROMOTION_SPECIAL_OPERATIONS_NAME', 'LOC_PROMOTION_SPECIAL_OPERATIONS_DESCRIPTION', '4', '', 'PROMOTION_CLASS_RECON', '3');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'AMBUSH_INCREASED_COMBAT_STRENGTH');


--------------------------------------------------------------------------------
--	Left side promotion requirements										  --
--------------------------------------------------------------------------------

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_RANGER', 'PROMOTION_SPYGLASS');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_CAMOUFLAGE', 'PROMOTION_SPYGLASS');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_DESTINATION_HORIZON', 'PROMOTION_CAMOUFLAGE');


--------------------------------------------------------------------------------
--	Rights side promotion requirements										  --
--------------------------------------------------------------------------------

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_GUERRILLA', 'PROMOTION_TIRELESS_STRIDE');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_AMBUSH', 'PROMOTION_GUERRILLA');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'PROMOTION_AMBUSH');



