--------------------------------------------------------------
----	CavalryChanges	--------------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/6/2022 3:31:48 PM						--
--------------------------------------------------------------


--------------------------------------------------------------------------------
----	LIGHT CAVARLY CHANGES	------------------------------------------------
--	Can move after attack.													  --
--------------------------------------------------------------------------------

INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive, ShowFloatTextWhenEarned, Permanent) 
VALUES ('ABILITY_MOVE_AFTER_ATTACK', 'LOC_ABILITY_MOVE_AFTER_ATTACK_NAME', 'LOC_ABILITY_MOVE_AFTER_ATTACK_DESCRIPTION', '0', '1', '1');

INSERT OR IGNORE INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) 
VALUES ('ABILITY_MOVE_AFTER_ATTACK', 'MOD_MOVE_AFTER_ATTACKING');

INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('ABILITY_MOVE_AFTER_ATTACK', 'KIND_ABILITY');

INSERT OR IGNORE INTO TypeTags (Type, Tag) VALUES ('ABILITY_MOVE_AFTER_ATTACK', 'CLASS_LIGHT_CAVALRY');
INSERT OR IGNORE INTO TypeTags (Type, Tag) VALUES ('ABILITY_MOVE_AFTER_ATTACK', 'CLASS_RANGED_CAVALRY');


--------------------------------------------------------------------------------
----	LIGHT CAVALRY PROMOTIN CHANGES	----------------------------------------
--	Coursers: Increased from +5 to +7 Combat Strength vs siege and ranged.	  --
--	Depredation: Added +5 Combat Strength against wounded units.			  --
--------------------------------------------------------------------------------

--	Coursers
update ModifierArguments set Value = '7' where ModifierId = 'COURSERS_BONUS_VS_RANGED_SIEGE' and Name = 'Amount';

--	Depredation
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('DEPREDATION_BONUS_VS_DAMAGED', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, 'VULTURE_REQUIREMENTS', '', '');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('DEPREDATION_BONUS_VS_DAMAGED', 'Amount', 'ARGTYPE_IDENTITY', '5', '', '');

INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_DEPREDATION', 'DEPREDATION_BONUS_VS_DAMAGED');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('DEPREDATION_BONUS_VS_DAMAGED', 'Preview', '+{1_Amount} {LOC_PROMOTION_DEPREDATION_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');


--------------------------------------------------------------------------------
----	HEAVY CAVARLY CHANGES	------------------------------------------------
--	Pushback units if major victory.										  --
--------------------------------------------------------------------------------

INSERT OR IGNORE INTO "TypeTags" ("Type", "Tag") VALUES ('ABILITY_PUSHBACK', 'CLASS_HEAVY_CAVALRY');


--------------------------------------------------------------------------------
----	HEAVY CAVALRY PROMOTIN CHANGES	----------------------------------------
--	Rout: Changed effect to do +7 damage against full health units.			  --
--------------------------------------------------------------------------------

INSERT INTO Requirements (RequirementId, RequirementType, Likeliness, Impact, Inverse, Reverse, Persistent, ProgressWeight, Triggered) 
VALUES ('OPPONENT_IS_NOT_DAMAGED_UNIT_REQUIREMENT', 'REQUIREMENT_UNIT_DAMAGE_MINIMUM', '0', '0', '1', '0', '0', '1', '0');

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES ('ROUT_OPPONENT_IS_FULL_HEALTH_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit) 
VALUES ('ROUT_BONUS_AGAINST_FULL_HEALTH', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', '0', '0', '0', '0', NULL, 'ROUT_OPPONENT_IS_FULL_HEALTH_REQUIREMENTS', '', '');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('ROUT_OPPONENT_IS_FULL_HEALTH_REQUIREMENTS', 'PLAYER_IS_ATTACKER_REQUIREMENTS');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES ('ROUT_OPPONENT_IS_FULL_HEALTH_REQUIREMENTS', 'OPPONENT_IS_NOT_DAMAGED_UNIT_REQUIREMENT');

INSERT INTO ModifierArguments (ModifierId, Name, Type, Value, Extra, SecondExtra) VALUES ('ROUT_BONUS_AGAINST_FULL_HEALTH', 'Amount', 'ARGTYPE_IDENTITY', '7', '', '');

delete from UnitPromotionModifiers where UnitPromotionType = 'PROMOTION_ROUT';
INSERT INTO UnitPromotionModifiers (UnitPromotionType, ModifierId) VALUES ('PROMOTION_ROUT', 'ROUT_BONUS_AGAINST_FULL_HEALTH');

INSERT INTO ModifierStrings (ModifierId, Context, Text) 
VALUES ('ROUT_BONUS_AGAINST_FULL_HEALTH', 'Preview', '+{1_Amount} {LOC_PROMOTION_ROUT_NAME} {LOC_PROMOTION_DESCRIPTOR_PREVIEW_TEXT}');

