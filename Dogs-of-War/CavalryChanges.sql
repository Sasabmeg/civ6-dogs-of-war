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
----	HEAVY CAVARLY CHANGES	------------------------------------------------
--	Pushback units if major victory.										  --
--------------------------------------------------------------------------------

INSERT OR IGNORE INTO "TypeTags" ("Type", "Tag") VALUES ('ABILITY_PUSHBACK', 'CLASS_HEAVY_CAVALRY');

