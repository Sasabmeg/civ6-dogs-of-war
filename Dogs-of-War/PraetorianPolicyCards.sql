--------------------------------------------------------------
----	PraetorianPolicyCards	------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/6/2022 3:39:08 PM						--
--------------------------------------------------------------


--------------------------------------------------------------------------------
----	PRAETORIAN GUARDIANS POLICY CARD	------------------------------------
--	Added similar card as in dramatic ages game mode, but it's more defensive --
--	as it heals more in friendly, a bit more in neutral and no extra in enemy --
--	territories.															  --
--------------------------------------------------------------------------------

INSERT INTO Types ("Type", "Kind") VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'KIND_POLICY');

INSERT INTO Policies ("PolicyType", "Description", "PrereqCivic", "PrereqTech", "Name", "GovernmentSlotType", "RequiresGovernmentUnlock", "ExplicitUnlock") 
VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'LOC_POLICY_PRAETORIAN_GUARDIANS_DESCRIPTION', 'CIVIC_CODE_OF_LAWS', NULL, 'LOC_POLICY_PRAETORIAN_GUARDIANS_NAME', 'SLOT_MILITARY', '0', '0');

INSERT INTO Modifiers ("ModifierId", "ModifierType", "RunOnce", "NewOnly", "Permanent", "Repeatable", "OwnerRequirementSetId", "SubjectRequirementSetId", "OwnerStackLimit", "SubjectStackLimit") 
VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_FRIENDLY', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO Modifiers ("ModifierId", "ModifierType", "RunOnce", "NewOnly", "Permanent", "Repeatable", "OwnerRequirementSetId", "SubjectRequirementSetId", "OwnerStackLimit", "SubjectStackLimit") 
VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_NEUTRAL', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_FRIENDLY', 'Amount', 'ARGTYPE_IDENTITY', '20', '', '');
INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_FRIENDLY', 'Type', 'ARGTYPE_IDENTITY', 'FRIENDLY', '', '');

INSERT INTO PolicyModifiers ("PolicyType", "ModifierId") VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'POLICY_PRAETORIAN_GUARDIANS_HEALING_FRIENDLY');

INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_NEUTRAL', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');
INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_GUARDIANS_HEALING_NEUTRAL', 'Type', 'ARGTYPE_IDENTITY', 'NEUTRAL', '', '');

INSERT INTO PolicyModifiers ("PolicyType", "ModifierId") VALUES ('POLICY_PRAETORIAN_GUARDIANS', 'POLICY_PRAETORIAN_GUARDIANS_HEALING_NEUTRAL');


--------------------------------------------------------------------------------
----	PRAETORIAN INVADERS POLICY CARD	----------------------------------------
--	Added similar card as in dramatic ages game mode, but it's more offensive --
--	as it heals more in enemy, a bit more in neutral and no extra in friendly --
--	territories.															  --
--------------------------------------------------------------------------------

INSERT INTO Types ("Type", "Kind") VALUES ('POLICY_PRAETORIAN_INVADERS', 'KIND_POLICY');

INSERT INTO Policies ("PolicyType", "Description", "PrereqCivic", "PrereqTech", "Name", "GovernmentSlotType", "RequiresGovernmentUnlock", "ExplicitUnlock") 
VALUES ('POLICY_PRAETORIAN_INVADERS', 'LOC_POLICY_PRAETORIAN_INVADERS_DESCRIPTION', 'CIVIC_EARLY_EMPIRE', NULL, 'LOC_POLICY_PRAETORIAN_INVADERS_NAME', 'SLOT_MILITARY', '0', '0');

INSERT INTO Modifiers ("ModifierId", "ModifierType", "RunOnce", "NewOnly", "Permanent", "Repeatable", "OwnerRequirementSetId", "SubjectRequirementSetId", "OwnerStackLimit", "SubjectStackLimit") 
VALUES ('POLICY_PRAETORIAN_INVADERS_HEALING_NEUTRAL', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO Modifiers ("ModifierId", "ModifierType", "RunOnce", "NewOnly", "Permanent", "Repeatable", "OwnerRequirementSetId", "SubjectRequirementSetId", "OwnerStackLimit", "SubjectStackLimit") 
VALUES ('POLICY_PRAETORIAN_INVADERS_HEALING_ENEMY', 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', '0', '0', '0', '0', NULL, NULL, '', '');

INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_INVADERS_HEALING_NEUTRAL', 'Amount', 'ARGTYPE_IDENTITY', '10', '', '');
INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_INVADERS_HEALING_NEUTRAL', 'Type', 'ARGTYPE_IDENTITY', 'NEUTRAL', '', '');

INSERT INTO PolicyModifiers ("PolicyType", "ModifierId") VALUES ('POLICY_PRAETORIAN_INVADERS', 'POLICY_PRAETORIAN_INVADERS_HEALING_NEUTRAL');

INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_INVADERS_HEALING_ENEMY', 'Amount', 'ARGTYPE_IDENTITY', '15', '', '');
INSERT INTO ModifierArguments ("ModifierId", "Name", "Type", "Value", "Extra", "SecondExtra") VALUES ('POLICY_PRAETORIAN_INVADERS_HEALING_ENEMY', 'Type', 'ARGTYPE_IDENTITY', 'ENEMY', '', '');

INSERT INTO PolicyModifiers ("PolicyType", "ModifierId") VALUES ('POLICY_PRAETORIAN_INVADERS', 'POLICY_PRAETORIAN_INVADERS_HEALING_ENEMY');


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


