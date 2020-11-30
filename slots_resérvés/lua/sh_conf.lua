slots_reserves = slots_reserves or {} -- Ne pas toucher :p

slots_reserves.maxnorm = 10
-- Définit le nombre de personnes dites "normales" qui peuvent se connecter.

slots_reserves.reason = "Désolé, le serveur est plein. Achète le vip sur notre boutique pour pouvoir accèder aux slots réservés !"
-- Définit la raison du kick quand le joueur essaye de rejoindre le serveur et qu'il est plein.

slots_reserves.bypassgroups = {
	["superadmin"] = true,
}
-- Définit les groupes de joueur qui peuvent rentrer dans les slots réservés suivre le modèle:
--
--    ["nom_du_groupe"] = true,
--
-- Ne modifiez que le "nom_du_groupe" par le nom du groupe désiré, en respectant les majuscules.

slots_reserves.msgConsoles = true
-- Active ou non le message du chargement dans la console du serveur.

slots_reserves.typekick = 2
-- Mettez 1 ou 2
-- 1 = Kick après le chargement
-- 2 = Kick avant le chargement (conseillé)

slots_reserves.adtype = "ulx"
-- IL N'Y A QU'ULX DE DISPONIBLE POUR LE MOMENT !
