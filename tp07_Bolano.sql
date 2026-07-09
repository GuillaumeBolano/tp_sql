-- 2) Pour pouvoir réaliser ce TP vous aurez besoin de désactiver le mode « safe update » qui par
-- défaut bloque les modifications de masse.
SET SQL_SAFE_UPDATES = 0;

-- 3) Requêtes à réaliser :

	-- a. Supprimer dans la table compo toutes les lignes concernant les bons de commande
-- d’avril 2019
DELETE c FROM COMPTA2.COMPO c
INNER JOIN COMPTA2.BON b ON c.ID_BON = b.ID
WHERE b.DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30';

	-- b. Supprimer dans la table bon tous les bons de commande d’avril 2019.
DELETE FROM COMPTA2.BON b
WHERE b.DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30';