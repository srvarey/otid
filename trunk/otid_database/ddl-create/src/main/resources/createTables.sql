SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `otid` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
SHOW WARNINGS;
USE `otid`;

-- -----------------------------------------------------
-- Table `otid`.`otid_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otid`.`otid_user` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `otid`.`otid_user` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `login` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `creation` DATE NOT NULL ,
  `last_login` DATETIME NULL ,
  PRIMARY KEY (`user_id`) );

SHOW WARNINGS;
CREATE UNIQUE INDEX `login` ON `otid`.`otid_user` (`login` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `otid`.`otid_provider_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otid`.`otid_provider_type` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `otid`.`otid_provider_type` (
  `provider_type_id` VARCHAR(45) NOT NULL ,
  `info_url` VARCHAR(128) NOT NULL ,
  PRIMARY KEY (`provider_type_id`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `otid`.`otid_provider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otid`.`otid_provider` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `otid`.`otid_provider` (
  `otid_provider_type_provider_type_id` VARCHAR(45) NOT NULL ,
  `provider_id` VARCHAR(45) NOT NULL ,
  `info_url` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`provider_id`) ,
  CONSTRAINT `fk_otid_provider_otid_provider_type`
    FOREIGN KEY (`otid_provider_type_provider_type_id` )
    REFERENCES `otid`.`otid_provider_type` (`provider_type_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_otid_provider_otid_provider_type` ON `otid`.`otid_provider` (`otid_provider_type_provider_type_id` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `otid`.`otid_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `otid`.`otid_account` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `otid`.`otid_account` (
  `account_id` VARCHAR(45) NOT NULL ,
  `otid_provider_provider_id` VARCHAR(45) NULL ,
  `otid_user_user_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`account_id`) ,
  CONSTRAINT `fk_otid_account_otid_provider`
    FOREIGN KEY (`otid_provider_provider_id` )
    REFERENCES `otid`.`otid_provider` (`provider_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_otid_account_otid_user`
    FOREIGN KEY (`otid_user_user_id` )
    REFERENCES `otid`.`otid_user` (`user_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;
CREATE INDEX `fk_otid_account_otid_provider` ON `otid`.`otid_account` (`otid_provider_provider_id` ASC) ;

SHOW WARNINGS;
CREATE INDEX `fk_otid_account_otid_user` ON `otid`.`otid_account` (`otid_user_user_id` ASC) ;

SHOW WARNINGS;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
