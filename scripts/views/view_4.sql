CREATE OR REPLACE VIEW v_player_kpd AS 
SELECT  
        nick_nm AS name,
        CASE WHEN SUM(succed_flg::int) IS NULL THEN 0
            ELSE SUM(succed_flg::int)::float * 100 / COUNT(*) END AS  successful_attacks_percents
FROM 
  (cd.player INNER JOIN cd.squad ON player.player_id = squad.owner_id) AS temp
  LEFT JOIN cd.attack ON attack.squad_id = temp.squad_id
GROUP BY nick_nm
ORDER BY successful_attacks_percents DESC;