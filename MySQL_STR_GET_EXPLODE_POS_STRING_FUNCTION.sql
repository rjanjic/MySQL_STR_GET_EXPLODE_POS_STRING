-- 
-- Projectname:   MySQL FUNCTION STR_GET_EXPLODE_POS_STRING
-- Version:       1.0
-- Author:        Radovan Janjic <rade@it-radionica.com>
-- Last modified: 27 09 2013
-- Copyright (C): 2013 IT-radionica.com, All Rights Reserved
--
-- ------------------------------------------------------------------------------------
-- 
-- string STR_GET_EXPLODE_POS_STRING(x VARCHAR(21845), delim VARCHAR(255), pos INT);
-- str		- String to be exploded
-- delim	- Delimiter
-- pos		- Position in string (1, 2 ... -1, -2)
-- 

DROP FUNCTION IF EXISTS STR_GET_EXPLODE_POS_STRING;

DELIMITER //
CREATE FUNCTION STR_GET_EXPLODE_POS_STRING(str VARCHAR(21845), delim VARCHAR(255), pos INT) 
RETURNS VARCHAR(255)
BEGIN
	DECLARE p, co INT;
	IF pos < 0 THEN 
		SET co = ROUND( LENGTH( str ) - LENGTH( REPLACE( str,  delim,  '' ) ) / LENGTH( delim ) );
		SET p = IF(pos = -1, co - pos, co + pos + 2);
	ELSE
		SET p = pos;
	END IF;
	
	IF p < 0 THEN
		SET p = 0;
	END IF;
	
	RETURN REPLACE( REPLACE( SUBSTRING_INDEX(str, delim, p), SUBSTRING_INDEX(str, delim, p - 1), '' ), delim, '' );
END //
DELIMITER ;
