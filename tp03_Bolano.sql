-- TP03 - Database creation

CREATE DATABASE `compta` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `compta`;

-- compta.FOURNISSEUR definition

CREATE TABLE `FOURNISSEUR` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `NOM` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- compta.ARTICLE definition

CREATE TABLE `ARTICLE` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `REF` varchar(13) NOT NULL,
  `DESIGNATION` varchar(255) NOT NULL,
  `PRIX` decimal(7, 2) NOT NULL,
  `ID_FOU` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ARTICLE_FOURNISSEUR_FK` (`ID_FOU`),
  CONSTRAINT `ARTICLE_FOURNISSEUR_FK` FOREIGN KEY (`ID_FOU`) REFERENCES `FOURNISSEUR` (`ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 11 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- compta.BON definition

CREATE TABLE `BON` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `NUMERO` int(10) NOT NULL,
  `DATE_CMDE` timestamp NOT NULL,
  `DELAI` int(10) NOT NULL,
  `ID_FOU` int(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `BON_FOURNISSEUR_FK` (`ID_FOU`),
  CONSTRAINT `BON_FOURNISSEUR_FK` FOREIGN KEY (`ID_FOU`) REFERENCES `FOURNISSEUR` (`ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- compta.COMPO definition

CREATE TABLE `COMPO` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `QTE` int(10) NOT NULL,
  `ID_ART` int(10) NOT NULL,
  `ID_BON` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `COMPO_ARTICLE_FK` (`ID_ART`),
  KEY `COMPO_BON_FK` (`ID_BON`),
  CONSTRAINT `COMPO_ARTICLE_FK` FOREIGN KEY (`ID_ART`) REFERENCES `ARTICLE` (`ID`),
  CONSTRAINT `COMPO_BON_FK` FOREIGN KEY (`ID_BON`) REFERENCES `BON` (`ID`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;


-- Insert FOURNISSEUR data

INSERT
    INTO
    compta.FOURNISSEUR (NOM)
VALUES('Française d''Imports');

INSERT
    INTO
    compta.FOURNISSEUR (NOM)
VALUES('FDM SA');

INSERT
    INTO
    compta.FOURNISSEUR (NOM)
VALUES('Dubois & Fils');

-- Insert ARTICLE data

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('A01', 'Perceuse P1', 74.99, 1);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('A02', 'Meuleuse 125mm', 37.85, 1);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('A03', 'Perceuse à colonne', 185.25, 1);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('D04', 'Coffret mêches à bois', 12.25, 3);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('F03', 'Coffret mêches plates', 6.25, 2);

INSERT
    INTO
    compta.ARTICLE (`REF`,
    DESIGNATION,
    PRIX,
    ID_FOU)
VALUES('F04', 'Fraises d’encastrement', 8.14, 2);

-- Insert BON data

INSERT
    INTO
    compta.BON (NUMERO,
    DATE_CMDE,
    DELAI,
    ID_FOU)
VALUES(1, '2026-07-08 15:06:10.000', 3, 1);

-- Insert COMPO data

INSERT
    INTO
    compta.COMPO (QTE,
    ID_ART,
    ID_BON)
VALUES(3, 1, 1);

INSERT
    INTO
    compta.COMPO (QTE,
    ID_ART,
    ID_BON)
VALUES(4, 5, 1);

INSERT
    INTO
    compta.COMPO (QTE,
    ID_ART,
    ID_BON)
VALUES(1, 7, 1);

