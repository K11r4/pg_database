CREATE OR REPLACE VIEW v_squad AS 
SELECT 
      leader.type_nm AS leader,
      REGEXP_REPLACE(leader.type_desc, 
                  '(^[A-Za-z ]{20}).*',
                  '\1...') AS description,
      unit.type_nm AS units,
      leader.magic_damage
      
        AS magic_damage,
      leader.physical_damage + squad.unit_cnt * unit.damage * leader.damage_inc_coeff 
        AS total_phys_damage,
      leader.health + unit.health * squad.unit_cnt
        AS total_health
      
FROM cd.squad, cd.leader, cd.unit
WHERE squad.leader_type = leader.type_id AND 
      squad.unit_type = unit.type_id;
