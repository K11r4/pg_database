--select list with palyers with their place in faction
SELECT  
        nick_nm AS player,
        faction_nm AS faction,
        ROW_NUMBER() OVER(PARTITION BY faction_nm ORDER BY rank DESC) AS place_in_faction
FROM cd.faction INNER JOIN cd.player ON faction.faction_id = player.faction_id
ORDER BY nick_nm;
