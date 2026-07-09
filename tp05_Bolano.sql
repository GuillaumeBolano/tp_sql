-- a. Listez les articles dans l’ordre alphabétique des désignations
SELECT * FROM COMPTA2.ARTICLE a ORDER BY a.DESIGNATION ASC;

-- b. Listez les articles dans l’ordre des prix du plus élevé au moins élevé
SELECT * FROM COMPTA2.ARTICLE a ORDER BY a.PRIX DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix
-- ascendant
SELECT * FROM COMPTA2.ARTICLE a WHERE a.DESIGNATION LIKE 'Boulon%' ORDER BY a.PRIX ASC;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM COMPTA2.ARTICLE a WHERE a.DESIGNATION LIKE '%sachet%';

-- e. Listez tous les articles dont la désignation contient le mot « sachet »
-- indépendamment de la casse !
SELECT * FROM COMPTA2.ARTICLE a WHERE LOWER(a.DESIGNATION) LIKE '%sachet%';

-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats
-- doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le
-- plus élevé au moins élevé.
SELECT * FROM COMPTA2.ARTICLE a INNER JOIN COMPTA2.FOURNISSEUR f ON a.ID_FOU = f.ID ORDER BY f.NOM ASC, a.PRIX DESC;
SELECT * FROM COMPTA2.ARTICLE a, COMPTA2.FOURNISSEUR f WHERE a.ID_FOU = f.ID ORDER BY f.NOM ASC, a.PRIX DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT * FROM COMPTA2.ARTICLE a INNER JOIN COMPTA2.FOURNISSEUR f ON a.ID_FOU = f.ID WHERE f.NOM = 'Dubois & Fils';

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT f.NOM, AVG(a.PRIX) AS Moyenne FROM COMPTA2.ARTICLE a INNER JOIN COMPTA2.FOURNISSEUR f ON a.ID_FOU = f.ID WHERE f.NOM = 'Dubois & Fils' GROUP BY f.NOM;

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT f.NOM, AVG(a.PRIX) AS Moyenne FROM COMPTA2.ARTICLE a INNER JOIN COMPTA2.FOURNISSEUR f ON a.ID_FOU = f.ID GROUP BY f.NOM;

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le
-- 05/04/2019 à 12h00.
SELECT * FROM COMPTA2.BON b WHERE b.DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT b.* FROM COMPTA2.BON b
	INNER JOIN COMPTA2.COMPO c ON b.ID = c.ID_BON
	INNER JOIN COMPTA2.ARTICLE a ON c.ID_ART = a.ID
	WHERE a.DESIGNATION LIKE '%boulon%'
	GROUP BY b.numero;

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom
-- du fournisseur associé
SELECT b.*, f.NOM FROM COMPTA2.BON b
	INNER JOIN COMPTA2.COMPO c ON b.ID = c.ID_BON
	INNER JOIN COMPTA2.ARTICLE a ON c.ID_ART = a.ID
	INNER JOIN COMPTA2.FOURNISSEUR f ON a.ID_FOU = f.ID 
	WHERE a.DESIGNATION LIKE '%boulon%'
	GROUP BY b.numero;

-- m. Calculez le prix total de chaque bon de commande
SELECT b.NUMERO, b.DATE_CMDE  as 'Numero de bon', SUM(c.QTE * a.PRIX) as 'Prix total' FROM COMPTA2.BON b
	INNER JOIN COMPTA2.COMPO c ON c.ID_BON = b.ID
	INNER JOIN COMPTA2.ARTICLE a ON c.ID_ART = a.ID
	GROUP BY b.id;

-- n. Comptez le nombre d’articles de chaque bon de commande
SELECT b.NUMERO as 'Numero de bon', SUM(c.QTE) as 'Nombre d''articles' FROM COMPTA2.BON b
	INNER JOIN COMPTA2.COMPO c ON c.ID_BON = b.ID
	GROUP BY b.id;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et
-- affichez le nombre d’articles de chacun de ces bons de commande
SELECT b.NUMERO as 'Numero de bon', SUM(c.QTE) as 'Nombre d''articles' FROM COMPTA2.BON b
	INNER JOIN COMPTA2.COMPO c ON c.ID_BON = b.ID
	GROUP BY b.id
	HAVING SUM(c.QTE) > 25;

-- p. Calculez le coût total des commandes effectuées sur le mois d’avril
SELECT SUM(c.QTE * a.PRIX) as 'Coût total des commandes sur le mois d''avril' FROM COMPTA2.BON b
	INNER JOIN COMPTA2.COMPO c ON c.ID_BON = b.ID 
	INNER JOIN COMPTA2.ARTICLE a ON c.ID_ART = a.ID
	WHERE b.DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30';

-- Requêtes plus difficiles

-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs
-- différents (indice : réaliser une auto-jointure i.e. de la table avec elle-même)
SELECT a.* FROM COMPTA2.ARTICLE a
	INNER JOIN COMPTA2.ARTICLE a2
	WHERE a.DESIGNATION = a2.DESIGNATION AND a.ID_FOU <> a2.ID_FOU
	ORDER BY a.ID;

-- b. Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions
-- MONTH et YEAR)
SELECT CONCAT(YEAR(b.DATE_CMDE), ' - ', MONTH(b.DATE_CMDE)) as Mois, SUM(c.QTE * a.PRIX) as 'Prix total' FROM COMPTA2.BON b
	LEFT JOIN COMPTA2.COMPO c ON c.ID_BON = b.ID
	LEFT JOIN COMPTA2.ARTICLE a ON c.ID_ART = a.ID
	GROUP BY MONTH(b.DATE_CMDE);

-- c. Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)
SELECT * FROM COMPTA2.BON b
	WHERE !EXISTS (
		SELECT * FROM COMPTA2.COMPO c WHERE c.ID_BON = b.ID);

-- d. Calculez le prix moyen des bons de commande par fournisseur
SELECT Fournisseurs, AVG(total) as 'Prix moyen des bons de commande' FROM (
	SELECT b.ID as Id, b.ID_FOU as FournisseursID, f.NOM as Fournisseurs, SUM(c.QTE * a.PRIX) as total FROM COMPTA2.BON b
		INNER JOIN COMPTA2.COMPO c ON b.ID = c.ID_BON
		INNER JOIN COMPTA2.ARTICLE a ON c.ID_ART = a.ID
		INNER JOIN COMPTA2.FOURNISSEUR f on b.ID_FOU = f.ID 
		GROUP BY b.ID) as totaux
	GROUP BY FournisseursID;

