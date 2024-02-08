DROP DATABASE IF EXISTS seminar6;
CREATE DATABASE IF NOT EXISTS seminar6;
USE seminar6;

DELIMITER //
CREATE PROCEDURE td(sec INT)
	BEGIN
		DECLARE res_t TEXT DEFAULT NULL;
		DECLARE d INT DEFAULT 0;
        DECLARE d1 INT DEFAULT 0;
		SET d = EXTRACT(HOUR FROM SEC_TO_TIME(sec));
			IF d < 24 THEN 
				SET res_t=CONCAT('0 days',' ',d,' hours ');
			ELSE 
				SET d1 = d / 24;
                SET d = d - 24 * d1;
                SET res_t = CONCAT(d1,' days',' ',d,' hours ');
			END IF;
		SET res_t = CONCAT(res_t,' ',EXTRACT(MINUTE FROM SEC_TO_TIME(sec)),' minutes ',EXTRACT(SECOND FROM SEC_TO_TIME(sec)),' seconds');
		SELECT res_t AS 'DATE';
	END //
DELIMITER ;

CALL td(1234567);

DELIMITER //
CREATE FUNCTION even(f_num INT, e_num INT)
RETURNS TEXT
DETERMINISTIC
    BEGIN
		DECLARE result TEXT DEFAULT NULL; 
        IF f_num > e_num THEN 
			RETURN 'Не могу выевсти ничего (нижняя граница больше верхней)';
        ELSEIF f_num % 2 !=0 AND f_num < e_num THEN 
			SET f_num = f_num + 1;
			SET result = CONCAT(f_num,' ');
			WHILE e_num > f_num DO
				SET f_num = f_num + 2;
				SET result = CONCAT(result,' ',f_num,' ');
			END WHILE;
			RETURN result;
        ELSE 
			SET result = CONCAT(f_num,' ');
			WHILE e_num > f_num DO
			SET f_num = f_num + 2;
            SET result = CONCAT(result,' ',f_num,' ');
			END WHILE;
            RETURN result;
        END IF;

	END //
DELIMITER ;

SELECT even(3,10) AS 'EVEN'
