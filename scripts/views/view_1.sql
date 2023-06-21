CREATE OR REPLACE VIEW v_player AS 
SELECT player.nick_nm AS nick,
      REGEXP_REPLACE(player.email, 
                  '(\A[[:alpha:]]{3}).*([[:digit:]]{2})',
                  '\1****\2') AS blured_email,
        rank,
        CASE WHEN faction IS NULL THEN 'No faction'
             ELSE faction_nm
        END AS faction
FROM cd.faction RIGHT JOIN cd.player ON faction.faction_id = player.faction_id;
