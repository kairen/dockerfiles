DROP USER `log`@`localhost`;
DROP DATABASE IF EXISTS `log`;

DROP TRIGGER IF EXISTS nova.quotas_insert;
DROP TRIGGER IF EXISTS nova.quotas_update; 