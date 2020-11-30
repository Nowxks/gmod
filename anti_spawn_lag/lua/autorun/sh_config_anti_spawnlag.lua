WASL = WASL or {}

-- CE FICHIER DE CONFIGURATION EST AVANCÉ EST N'EST PAS NÉCESSAIRE À MODIFIER.
-- CE FICHIER DE CONFIGURATION EST AVANCÉ EST N'EST PAS NÉCESSAIRE À MODIFIER.
-- CE FICHIER DE CONFIGURATION EST AVANCÉ EST N'EST PAS NÉCESSAIRE À MODIFIER.

-- Le caching d'un véhicule par le script va faire lag le serveur pendant 1 seconde, c'est pourquoi il s'exécute au démarrage pour éviter de déranger les joueurs par la suite.
-- ATTENTION : S'il y a trop de caching en même temps, le serveur va crash. Je vous conseille fortement de rester sur la configuration de base.

-- Le temps entre 2 caching de véhicule, en secondes.
WASL.Cooldown = 2

-- Liste des véhicules à cache (pour éviter de le remplir avec les véhicules inutiles)
-- Si vous souhaitez rajouter des véhicules, visez un véhicule et tappez la commande "vehmodel" dans votre console (F10).
-- Ensuite, ajoutez une partie du resultat dans cette table et redémarrez votre serveur.
WASL.WhitelistedModels = {
    "tdmcars",
    "lonewolfie",
    "rytrak",
    "sentry",
    "perrynsvehicles",
    "inaki",
    "azok30"
    -- ajoutez une catégorie ici (sans oublier les virgules)
}
