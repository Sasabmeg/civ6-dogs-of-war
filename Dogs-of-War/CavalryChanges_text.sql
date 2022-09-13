--------------------------------------------------------------
----	CavalryChanges_text	----------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/6/2022 7:13:42 PM						--
--------------------------------------------------------------


--	move after attacking
delete from LocalizedText where Tag = 'LOC_ABILITY_MOVE_AFTER_ATTACK_NAME' or Tag = 'LOC_ABILITY_MOVE_AFTER_ATTACK_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_ABILITY_MOVE_AFTER_ATTACK_NAME', 'Move After Attack', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_ABILITY_MOVE_AFTER_ATTACK_DESCRIPTION', 'Can move after attack.', '', '');

--	rout and depredation promotions
delete from LocalizedText where Tag = 'LOC_PROMOTION_DEPREDATION_DESCRIPTION' or Tag = 'LOC_PROMOTION_ROUT_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_DEPREDATION_DESCRIPTION', 'Pillaging costs only 1 [ICON_Movement] Movement point and +5 [ICON_Strength] Combat Strength against damaged units.', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_ROUT_DESCRIPTION', '+7 [ICON_Strength] Combat Strength against undamaged units.', '', '');
