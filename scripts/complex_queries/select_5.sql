--Dstribute factions by leagues (platinum, gold, silver, bronze)
SELECT faction_nm AS faction,  
        CASE WHEN NTILE(4) OVER(ORDER BY avg_rank DESC) = 1 THEN 'platinum'
            WHEN NTILE(4) OVER(ORDER BY avg_rank DESC) = 2 THEN 'gold'
            WHEN NTILE(4) OVER(ORDER BY avg_rank DESC) = 3 THEN 'silver'
            ELSE 'bronze'
        END AS league
FROM (
  SELECT faction_nm, 
        CASE WHEN AVG(rank) IS NULL THEN 0
            ELSE AVG(rank)
        END AS avg_rank
  FROM cd.faction LEFT JOIN cd.player ON faction.faction_id = player.faction_id
  GROUP BY faction_nm
) AS temp
ORDER BY NTILE(3) OVER(ORDER BY avg_rank DESC), faction_nm;