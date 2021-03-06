-- 将语句的结束符号从分号; 临时改为两个$$(可以是自定义)
delimiter $$

DROP PROCEDURE IF EXISTS procedure_test;

CREATE DEFINER = `root` @`localhost` PROCEDURE `procedure_test` (  ) COMMENT '游标模板' BEGIN

DECLARE l_max_id, l_min_id INT DEFAULT 0;
DECLARE l_step INT DEFAULT 500000;

SELECT max( id ), min( id ) INTO l_max_id, l_min_id FROM userinfo;

WHILE l_min_id <= l_max_id DO

    SELECT l_maxid, l_min_id;
	
    INSERT INTO temp_userinfo ( college, age, `name` ) 
    SELECT
        college,
        age,
        `name` 
    FROM
        userinfo
    WHERE
        id >= l_min_id 
        AND id < ( l_min_id + l_step ) 
    ON DUPLICATE KEY UPDATE college = VALUES( college ), age = age + VALUES ( age ), `name` = VALUES ( `name` );
	
    SET l_min_id = l_min_id + l_step;
	
END WHILE;

END $$ 

-- 将语句的结束符号恢复为分号
delimiter ;
