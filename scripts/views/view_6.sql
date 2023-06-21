CREATE OR REPLACE VIEW v_player_ranking AS 
SELECT  
        nick_nm AS player,
        faction_nm AS faction,
        CASE  WHEN 3 * rank >= 2 *  first_value(rank) OVER(PARTITION BY faction_nm ORDER BY rank DESC) THEN 'strong' 
              WHEN 3 * rank >= first_value(rank) OVER(PARTITION BY faction_nm ORDER BY rank DESC) THEN 'medium'
              ELSE 'trash'
        END AS status
FROM cd.faction INNER JOIN cd.player ON faction.faction_id = player.faction_id;