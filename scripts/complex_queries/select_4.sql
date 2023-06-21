--select list of players with average rank in their faction
SELECT  nick_nm AS palyer,
        faction_nm AS faction,
        AVG(rank) OVER(PARTITION BY faction_nm) AS avg_rank
FROM cd.faction INNER JOIN cd.player ON faction.faction_id = player.faction_id;