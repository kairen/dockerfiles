USE `nova`;

DROP TRIGGER IF EXISTS nova.quotas_insert;
DROP TRIGGER IF EXISTS nova.quotas_update;

DELIMITER @@
CREATE TRIGGER quotas_insert 
AFTER INSERT ON quota_usages
FOR EACH ROW 
BEGIN
	INSERT INTO `log`.`quotas` Values (NEW.updated_at, NEW.project_id, NEW.resource, NEW.in_use );
END
@@
CREATE TRIGGER quotas_update 
AFTER UPDATE ON quota_usages
FOR EACH ROW 
BEGIN
	INSERT INTO `log`.`quotas` Values (NEW.updated_at, NEW.project_id, NEW.resource, NEW.in_use );
END;
@@
DELIMITER ;