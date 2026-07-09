-- Listez toutes les données concernant les articles
SELECT * FROM COMPTA2.ARTICLE a;

-- Listez uniquement les références et désignations des articles de plus de 2 euros
SELECT a.REF, a.DESIGNATION FROM COMPTA2.ARTICLE a WHERE a.PRIX > 2;

-- En utilisant les opérateurs de comparaison, listez tous les articles dont le prix est
-- compris entre 2 et 6.25 euros
SELECT * FROM COMPTA2.ARTICLE a WHERE a.PRIX >= 2 AND a.PRIX <= 6.25;

-- En utilisant l’opérateur BETWEEN, listez tous les articles dont le prix est compris
-- compris entre 2 et 6.25 euros
SELECT * FROM COMPTA2.ARTICLE a WHERE a.PRIX BETWEEN 2 AND 6.25;

-- Listez tous les articles, dans l’ordre des prix descendants, et dont le prix n’est pas
-- compris entre 2 et 6.25 euros et dont le fournisseur est Française d’Imports.
SELECT * FROM COMPTA2.ARTICLE a WHERE a.PRIX NOT BETWEEN 2 AND 6.25 AND a.ID_FOU = 1 ORDER BY a.PRIX DESC;

-- En utilisant un opérateur logique, listez tous les articles dont les fournisseurs sont la
-- Française d’imports ou Dubois et Fils
SELECT * FROM COMPTA2.ARTICLE a WHERE a.ID_FOU = 1 OR a.ID_FOU = 3;

-- En utilisant l’opérateur IN, réalisez la même requête que précédemment
SELECT * FROM COMPTA2.ARTICLE a WHERE a.ID_FOU IN (1,3);

-- En utilisant les opérateurs NOT et IN, listez tous les articles dont les fournisseurs ne
-- sont ni Française d’Imports, ni Dubois et Fils.
SELECT * FROM COMPTA2.ARTICLE a WHERE a.ID_FOU NOT IN (1,3);

-- Listez tous les bons de commande dont la date de commande est entre le
-- 01/02/2019 et le 30/04/2019.
SELECT * FROM COMPTA2.BON b WHERE b.DATE_CMDE BETWEEN '2019-02-01' and '2019-04-30';
