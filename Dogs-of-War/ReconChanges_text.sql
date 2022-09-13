--------------------------------------------------------------
----	ReconChanges_text	----------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/8/2022 5:18:56 P							--
--------------------------------------------------------------


--	Recon left side promotions
delete from LocalizedText where Tag = 'LOC_PROMOTION_SPYGLASS_NAME' or Tag = 'LOC_PROMOTION_SPYGLASS_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_SPYGLASS_NAME', 'Spyglass', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_SPYGLASS_DESCRIPTION', 'Increase Sight Range by 1.', '', '');

delete from LocalizedText where Tag = 'LOC_PROMOTION_RANGER_NAME' or Tag = 'LOC_PROMOTION_RANGER_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_RANGER_NAME', 'Ranger', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_RANGER_DESCRIPTION', 'Faster [ICON_Movement] on Hills, Woods and Jungle terrain and ignores enemy zone of cotnrol. Can see through Woods and Jungle.', '', '');

delete from LocalizedText where Tag = 'LOC_PROMOTION_MOBILITY_NAME' or Tag = 'LOC_PROMOTION_MOBILITY_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_MOBILITY_NAME', 'Mobility', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_MOBILITY_DESCRIPTION', '+1 [ICON_Movement] and +10 Combat Strength when defending against ranged attacks.', '', '');

delete from LocalizedText where Tag = 'LOC_PROMOTION_CAMOUFLAGE_NAME' or Tag = 'LOC_PROMOTION_CAMOUFLAGE_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_CAMOUFLAGE_NAME', 'Camouflage', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_CAMOUFLAGE_DESCRIPTION', 'Only adjacent enemy units can reveal this unit.', '', '');


--	Recon right side promotions
delete from LocalizedText where Tag = 'LOC_PROMOTION_TIRELESS_STRIDE_NAME' or Tag = 'LOC_PROMOTION_TIRELESS_STRIDE_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_TIRELESS_STRIDE_NAME', 'Tireless Stride', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_TIRELESS_STRIDE_DESCRIPTION', 'Heals at the end of each turn.', '', '');

delete from LocalizedText where Tag = 'LOC_PROMOTION_GUERRILLA_NAME' or Tag = 'LOC_PROMOTION_GUERRILLA_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_GUERRILLA_NAME', 'Guerrilla', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_GUERRILLA_DESCRIPTION', 'Can move after attacking and gain +7 [ICON_Strength] Combat Strength against stronger oppoenents.', '', '');

delete from LocalizedText where Tag = 'LOC_PROMOTION_AMBUSH_NAME' or Tag = 'LOC_PROMOTION_AMBUSH_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_AMBUSH_NAME', 'Ambush', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_AMBUSH_DESCRIPTION', '+3 [ICON_Strength] Combat Strength per unused movement points.', '', '');

delete from LocalizedText where Tag = 'LOC_PROMOTION_SPECIAL_OPERATIONS_NAME' or Tag = 'LOC_PROMOTION_SPECIAL_OPERATIONS_DESCRIPTION';
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_SPECIAL_OPERATIONS_NAME', 'Special Operations', '', '');
INSERT INTO LocalizedText (Language, Tag, Text, Gender, Plurality) VALUES ('en_US', 'LOC_PROMOTION_SPECIAL_OPERATIONS_DESCRIPTION', '+10 [ICON_Strength] Combat Strength when attacking.', '', '');


		