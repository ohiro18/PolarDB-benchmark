DROP PROCEDURE IF EXISTS `PROC_TEST_CREATE_FO_REQUIRED_DATA`$$

DELIMITER $$
CREATE PROCEDURE `PROC_TEST_CREATE_FO_REQUIRED_DATA` (in_data_row_count int)
BEGIN
    DECLARE nRetRowCount int default 0;
    DECLARE nLoopCounter int default 0;
    SELECT count(table_name) INTO nRetRowCount FROM information_schema.tables WHERE table_name IN ('nancy_fo_select','nancy_fo_update','nancy_fo_insert');
    IF nRetRowCount != 3 THEN
        -- create tables needed
        CREATE TABLE IF NOT EXISTS `nancy_fo_select` (  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'modify datetime',  `aid` bigint(20) unsigned NOT NULL COMMENT 'A ID',  `abalance` bigint(20) unsigned NOT NULL COMMENT 'A BALANCE',  PRIMARY KEY (`id`),  KEY `idx_a_id` (`aid`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
        CREATE TABLE IF NOT EXISTS `nancy_fo_update` (  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'modify datetime',  `tid` bigint(20) unsigned NOT NULL COMMENT 'T ID',  `tbalance` bigint(20) unsigned NOT NULL COMMENT 'T BALANCE',  PRIMARY KEY (`id`),  KEY `idx_t_id` (`tid`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
        CREATE TABLE IF NOT EXISTS `nancy_fo_insert` (  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'modify datetime',  `tid` bigint(20) unsigned NOT NULL COMMENT 'T ID',  `bid` bigint(20) unsigned NOT NULL COMMENT 'B ID',  `aid` bigint(20) unsigned NOT NULL COMMENT 'A ID',  `delta` bigint(20) unsigned NOT NULL COMMENT 'DELTA',  `mtime` datetime NOT NULL COMMENT 'time stamp',  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
        -- initialize data needed
        TRUNCATE TABLE nancy_fo_select;
        TRUNCATE TABLE nancy_fo_update;
        TRUNCATE TABLE nancy_fo_insert;
        WHILE nLoopCounter < in_data_row_count do
            INSERT INTO nancy_fo_select (aid, abalance) VALUES (nLoopCounter, 4096 * nLoopCounter);
            INSERT INTO nancy_fo_update (tid, tbalance) VALUES (nLoopCounter, 8192 * nLoopCounter);
            SET nLoopCounter = nLoopCounter + 1;
        END WHILE;
        COMMIT;
    ELSE
        TRUNCATE TABLE nancy_fo_insert;
    END IF;
END$$
DELIMITER ;

-- create table struct and init 100000 data
call PROC_TEST_CREATE_FO_REQUIRED_DATA(100000);


-- create function
DELIMITER $$
DROP FUNCTION IF EXISTS `FUNC_DO_STH_AND_RET_CURTS`$$

DELIMITER $$
CREATE FUNCTION `FUNC_DO_STH_AND_RET_CURTS`(t_id int, b_id int, a_id int, delta_ int) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE curTimeTs INT DEFAULT 0;
    DECLARE aBalanceValue INT DEFAULT 0;
    -- test logic
    SELECT abalance INTO aBalanceValue FROM nancy_fo_select WHERE aid = a_id LIMIT 1;
    UPDATE nancy_fo_update SET tbalance = tbalance + delta_ + aBalanceValue WHERE tid = t_id;
    INSERT INTO nancy_fo_insert (tid, bid, aid, delta, mtime) VALUES (t_id, b_id, a_id, delta_, CURRENT_TIMESTAMP);
    SET curTimeTs = UNIX_TIMESTAMP();
    RETURN curTimeTs;
END$$
DELIMITER ;

-- function result verification
SELECT FUNC_DO_STH_AND_RET_CURTS(100, 100, 100, 100);
SELECT * FROM nancy_fo_insert;



