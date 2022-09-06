--------------------------------------------------------------
----	AncientEraUnitBalance	------------------------------
--	Author: Sasabmeg										--
--	DateCreated: 9/6/2022 3:27:12 PM						--
--------------------------------------------------------------


--------------------------------------------------------------------------------
----	ANCIENT ERA COMBAT BALANCE	--------------------------------------------
--	Update Spearman, Hoplite and Heavy Chariot combat strength for balance.	  --
--------------------------------------------------------------------------------

update Units
set Combat = 28
where UnitType = 'UNIT_SPEARMAN';

update Units
set Combat = 30
where UnitType = 'UNIT_GREEK_HOPLITE';

update Units
set Combat = 30
where UnitType = 'UNIT_HEAVY_CHARIOT';

