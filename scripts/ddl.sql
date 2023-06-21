DROP SCHEMA IF EXISTS cd;
CREATE SCHEMA cd;

CREATE TABLE cd.faction (
    faction_id INTEGER NOT NULL PRIMARY KEY,
    faction_nm VARCHAR(200) NOT NULL,
    division INTEGER NOT NULL
);

CREATE TABLE cd.player (
    player_id INTEGER NOT NULL PRIMARY KEY,
    email VARCHAR(200) NOT NULL,
    nick_nm VARCHAR(200) NOT NULL,
    faction_id INTEGER,
    rank INTEGER NOT NULL,
        FOREIGN KEY (faction_id) REFERENCES cd.faction(faction_id) ON DELETE SET NULL
);

CREATE TABLE cd.tower_type (
    type_id INTEGER NOT NULL PRIMARY KEY,
    type_nm VARCHAR(200) NOT NULL,
    physical_damage NUMERIC NOT NULL,
    magic_damage NUMERIC NOT NULL,
    health NUMERIC NOT NULL,
    type_desc VARCHAR(1000) NOT NULL
);

CREATE TABLE cd.tower (
    tower_id INTEGER NOT NULL PRIMARY KEY,
    owner_id INTEGER NOT NULL,
    type_id INTEGER NOT NULL,
    x_cord INTEGER NOT NULL,
    y_cord INTEGER NOT NULL,
        FOREIGN KEY (owner_id) REFERENCES cd.player(player_id) ON DELETE CASCADE,
        FOREIGN KEY (type_id) REFERENCES cd.tower_type(type_id)
);

CREATE TABLE cd.unit (
    type_id INTEGER NOT NULL PRIMARY KEY,
    type_nm VARCHAR(200) NOT NULL,
    damage NUMERIC NOT NULL,
    speed NUMERIC NOT NULL,
    health INTEGER NOT NULL
    
);

CREATE TABLE cd.leader (
    type_id INTEGER NOT NULL PRIMARY KEY,
    type_nm VARCHAR(200) NOT NULL,
    type_desc VARCHAR(1000) NOT NULL,
    physical_damage NUMERIC NOT NULL,
    magic_damage NUMERIC NOT NULL,
    damage_inc_coeff NUMERIC NOT NULL,
    speed NUMERIC NOT NULL,
    health INTEGER NOT NULL
    
);

CREATE TABLE cd.squad (
    squad_id INTEGER NOT NULL PRIMARY KEY,
    owner_id INTEGER NOT NULL,
    unit_type INTEGER NOT NULL,
    unit_cnt INTEGER NOT NULL,
    leader_type INTEGER NOT NULL,
        FOREIGN KEY (owner_id) REFERENCES cd.player(player_id) ON DELETE CASCADE,
        FOREIGN KEY (unit_type) REFERENCES cd.unit(type_id),
        FOREIGN KEY (leader_type) REFERENCES cd.leader(type_id)
);

CREATE TABLE cd.attack (
    attack_id INTEGER NOT NULL PRIMARY KEY,
    squad_id INTEGER NOT NULL,
    tower_id INTEGER NOT NULL,
    attack_dttm TIMESTAMP NOT NULL,
    succed_flg BOOLEAN NOT NULL
);

CREATE TABLE cd.player_history (
    update_id INTEGER NOT NULL PRIMARY KEY,
    player_id INTEGER NOT NULL, 
    email VARCHAR(200) NOT NULL,
    nick_nm VARCHAR(200) NOT NULL,
    faction_id INTEGER,
    rank INTEGER NOT NULL,
    history_dttm TIMESTAMP NOT NULL
);

CREATE TABLE cd.tower_history (
    update_id INTEGER NOT NULL PRIMARY KEY,
    tower_id INTEGER NOT NULL,
    owner_id INTEGER NOT NULL,
    type_id INTEGER NOT NULL,
    history_dttm TIMESTAMP NOT NULL
);
