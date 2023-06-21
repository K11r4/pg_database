--select big factions (big means more than 2 players)
SELECT faction_nm AS name,
        COUNT(*) AS members_count
FROM cd.faction INNER JOIN cd.player ON faction.faction_id = player.faction_id
GROUP BY faction_nm
HAVING COUNT(*) > 2;