--------------------------------------------------------------
----	ReconChanges	--------------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/8/2022 3:26:06 PM						--
--------------------------------------------------------------


--------------------------------------------------------------------------------
----	Delete unique values just in case.									  --
--------------------------------------------------------------------------------
delete from Types where	Type = 'PROMOTION_MOBILITY' or Type = 'PROMOTION_TIRELESS_STRIDE' or Type = 'PROMOTION_SPECIAL_OPERATIONS'  or Type = 'PROMOTION_GUERRILLA_NEW';

INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_MOBILITY', 'KIND_PROMOTION');
INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_TIRELESS_STRIDE', 'KIND_PROMOTION');
INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'KIND_PROMOTION');
INSERT INTO Types (Type, Kind) VALUES ('PROMOTION_GUERRILLA_NEW', 'KIND_PROMOTION');

--	Delete old Recon promotions, as we swapped too many around so old code might interfere
delete from UnitPromotions
where	UnitPromotionType = 'PROMOTION_RANGER' or UnitPromotionType = 'PROMOTION_ALPINE' or UnitPromotionType = 'PROMOTION_SENTRY' or
		UnitPromotionType = 'PROMOTION_GUERRILLA' or UnitPromotionType = 'PROMOTION_SPYGLASS' or UnitPromotionType = 'PROMOTION_AMBUSH' or
		UnitPromotionType = 'PROMOTION_CAMOUFLAGE';

--	Delete new Recon promotions, just in case some other mod added them
delete from UnitPromotions
where	UnitPromotionType = 'PROMOTION_MOBILITY' or UnitPromotionType = 'PROMOTION_TIRELESS_STRIDE' or UnitPromotionType = 'PROMOTION_SPECIAL_OPERATIONS';


--------------------------------------------------------------------------------
----	RECON PROMOTION CHANGES												  --
--	Left side promotions:  General Scouting									  --
--	Right side promotions: Hit and Run combat style.						  --
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
----	LEFT SIDE PROMOTIONS												  --
--	Level 1. Spyglass: Increase Sight Range by 1.							  --
--	Level 2. Ranger: Faster movement on Hills, Woods and Jungle terrain and	  --
--			 ignores enemy zone of control. Can see through Woods and Jungle. --
--	Level 3. Mobility: Increased Movement by 1 and Combat Strength when		  --
--			 defending against ranged attacks by 10.						  --
--	Level 4. Camouflage: Only adjacent enemy units can reveal this unit.	  --
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
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_RANGER', 'IGNOREZOC_IGNORE_ZOC');

--	Mobility
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_MOBILITY', 'LOC_PROMOTION_MOBILITY_NAME', 'LOC_PROMOTION_MOBILITY_DESCRIPTION', '3', '', 'PROMOTION_CLASS_RECON', '1');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('MOBILITY_DEFENSE_BONUS_VS_RANGED_COMBAT', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, 'TORTOISE_REQUIREMENTS', '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('MOBILITY_DEFENSE_BONUS_VS_RANGED_COMBAT', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_MOBILITY', 'COMMANDO_BONUS_MOVEMENT');
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_MOBILITY', 'MOBILITY_DEFENSE_BONUS_VS_RANGED_COMBAT');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('MOBILITY_DEFENSE_BONUS_VS_RANGED_COMBAT', 'Preview', '+{1_Amount} {LOC_PROMOTION_MOBILITY_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');

--	Camouflage
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_CAMOUFLAGE', 'LOC_PROMOTION_CAMOUFLAGE_NAME', 'LOC_PROMOTION_CAMOUFLAGE_DESCRIPTION', '4', '', 'PROMOTION_CLASS_RECON', '1');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_CAMOUFLAGE', 'CAMOUFLAGE_STEALTH');


--------------------------------------------------------------------------------
----	RIGTH SIDE PROMOTIONS												  --
--	Level 1. Tireless Stride: Heals at the end of each turn.				  --
--	Level 2. Guerrilla: Can move after attacking and gain +7 Combat Strength  --
--			 against stronger opponents.									  --
--	Level 3. Ambush: Increased Combat Strength by 3 per unused movement		  --
--			 points.														  --
--	Level 4. Special Operations: +10 Combat Strength when attacking.	 	  --
--------------------------------------------------------------------------------

--	Tireless Stride
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_TIRELESS_STRIDE', 'LOC_PROMOTION_TIRELESS_STRIDE_NAME', 'LOC_PROMOTION_TIRELESS_STRIDE_DESCRIPTION', '1', '', 'PROMOTION_CLASS_RECON', '3');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_TIRELESS_STRIDE', 'MAMLUK_HEAL_EVERY_MOVE');

--	Guerrilla
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_GUERRILLA_NEW', 'LOC_PROMOTION_GUERRILLA_NAME', 'LOC_PROMOTION_GUERRILLA_DESCRIPTION', '2', '', 'PROMOTION_CLASS_RECON', '3');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('GUERRILLA_STRONG_AGAINST_STRONGER_UNITS', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, 'COMBAT_AGAINST_STRONGER_UNIT_REQUIREMENTS', '', '');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('GUERRILLA_STRONG_AGAINST_STRONGER_UNITS', 'Preview', '+{1_Amount} {LOC_PROMOTION_GUERRILLA_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('GUERRILLA_STRONG_AGAINST_STRONGER_UNITS', 'Amount', 'ARGTYPE_IDENTITY', '7', '', '');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_GUERRILLA_NEW', 'GUERRILLA_STRONG_AGAINST_STRONGER_UNITS');
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_GUERRILLA_NEW', 'MOD_MOVE_AFTER_ATTACKING');

--	Ambush
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_AMBUSH', 'LOC_PROMOTION_AMBUSH_NAME', 'LOC_PROMOTION_AMBUSH_DESCRIPTION', '3', '', 'PROMOTION_CLASS_RECON', '3');

delete from UnitPromotionModifiers where UnitPromotionType = 'PROMOTION_AMBUSH';
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_AMBUSH', 'CAROLEAN_UNUSED_MOVEMENT_COMBAT');

--	Special Operations
INSERT INTO UnitPromotions (UnitPromotionType, Name, Description, Level, Specialization, PromotionClass, Column) 
VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'LOC_PROMOTION_SPECIAL_OPERATIONS_NAME', 'LOC_PROMOTION_SPECIAL_OPERATIONS_DESCRIPTION', '4', '', 'PROMOTION_CLASS_RECON', '3');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('SPECIAL_OPERATIONS_STRONG_WHEN_ATTACKING', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, 'UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS', '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('SPECIAL_OPERATIONS_STRONG_WHEN_ATTACKING', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'SPECIAL_OPERATIONS_STRONG_WHEN_ATTACKING');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('SPECIAL_OPERATIONS_STRONG_WHEN_ATTACKING', 'Preview', '+{1_Amount} {LOC_PROMOTION_SPECIAL_OPERATIONS_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');


--------------------------------------------------------------------------------
--	Left side promotion requirements										  --
--------------------------------------------------------------------------------

delete from UnitPromotionPrereqs where UnitPromotion = 'PROMOTION_RANGER' or UnitPromotion = 'PROMOTION_CAMOUFLAGE' or UnitPromotion = 'PROMOTION_MOBILITY';

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_RANGER', 'PROMOTION_SPYGLASS');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_RANGER', 'PROMOTION_TIRELESS_STRIDE');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_MOBILITY', 'PROMOTION_RANGER');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_MOBILITY', 'PROMOTION_GUERRILLA_NEW');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_CAMOUFLAGE', 'PROMOTION_MOBILITY');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_CAMOUFLAGE', 'PROMOTION_AMBUSH');


--------------------------------------------------------------------------------
--	Rights side promotion requirements										  --
--------------------------------------------------------------------------------

delete from UnitPromotionPrereqs where UnitPromotion = 'PROMOTION_GUERRILLA_NEW' or UnitPromotion = 'PROMOTION_AMBUSH' or UnitPromotion = 'PROMOTION_SPECIAL_OPERATIONS';

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_GUERRILLA_NEW', 'PROMOTION_TIRELESS_STRIDE');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_GUERRILLA_NEW', 'PROMOTION_SPYGLASS');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_AMBUSH', 'PROMOTION_GUERRILLA_NEW');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_AMBUSH', 'PROMOTION_RANGER');

INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'PROMOTION_AMBUSH');
INSERT INTO UnitPromotionPrereqs (UnitPromotion, PrereqUnitPromotion) VALUES ('PROMOTION_SPECIAL_OPERATIONS', 'PROMOTION_MOBILITY');



