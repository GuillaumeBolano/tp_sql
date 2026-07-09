-- 2) Pour pouvoir réaliser ce TP vous aurez besoin de désactiver le mode « safe update » qui par
-- défaut bloque les modifications de masse.
SET SQL_SAFE_UPDATES = 0;

-- 3) Requêtes à réaliser :
	
	-- a. Mettez en minuscules la désignation de l’article dont l’identifiant est 2.
UPDATE COMPTA2.ARTICLE a  SET a.DESIGNATION = LOWER(a.DESIGNATION) WHERE a.ID = 2;

	-- b. Mettez en majuscules les désignations de tous les articles dont le prix est strictement.
-- supérieur à 10€
UPDATE COMPTA2.ARTICLE a  SET a.DESIGNATION = UPPER(a.DESIGNATION) WHERE a.PRIX > 10;

	-- c. Baissez de 10% le prix de tous les articles qui n’ont pas fait l’objet d’une commande.
UPDATE COMPTA2.ARTICLE a SET a.PRIX = a.PRIX * 0.9 WHERE id NOT IN (SELECT c.ID_ART FROM COMPTA2.COMPO c);

	-- d. Une erreur s’est glissée dans les commandes concernant Française d’imports. Les
-- chiffres en base ne sont pas bons. Il faut doubler les quantités de tous les articles
-- commandés à cette société.
UPDATE COMPTA2.COMPO c
	INNER JOIN COMPTA2.BON b ON c.ID_BON = b.ID
	INNER JOIN COMPTA2.FOURNISSEUR f ON f.ID = b.ID_FOU
SET c.QTE = c.QTE * 2
WHERE f.NOM = 'Française d''imports';

	-- e. Mettez au point une requête update qui permette de supprimer les éléments entre
-- parenthèses dans les désignations. Il vous faudra utiliser des fonctions comme
-- substring et position.
UPDATE COMPTA2.ARTICLE a
	SET a.DESIGNATION = TRIM(
		SUBSTRING(
			a.DESIGNATION,
			1,
			POSITION('(' IN a.DESIGNATION) - 1
		)
	)
	WHERE a.DESIGNATION LIKE '%(%';