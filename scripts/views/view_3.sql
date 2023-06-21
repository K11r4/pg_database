CREATE OR REPLACE VIEW v_tower AS 
SELECT 
      player.nick_nm AS owner,
      tower_type.type_nm AS tower,
      REGEXP_REPLACE(tower_type.type_desc, 
                  '(^[A-Za-z,\- ]{20}).*',
                  '\1...') AS description,
      tower_type.magic_damage,
      tower_type.physical_damage,
      tower.x_cord::varchar(5) ||  ' ' || tower.y_cord::varchar(5) 
        AS cordinates
      
FROM cd.tower_type, cd.tower, cd.player
WHERE tower.type_id = tower_type.type_id AND 
      tower.owner_id = player.player_id;