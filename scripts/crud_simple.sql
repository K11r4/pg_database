INSERT INTO cd.player VALUES
(11, 'khan5842@cd.com', 'Khan', 1, 900);

INSERT INTO cd.player_history VALUES
(31, 11, 'khan5842@cd.com', 'Khan', 1, 900, '2023-04-15 03:26:04');

INSERT INTO cd.tower VALUES
(29, 11, 7, 3589, -7815);

INSERT INTO cd.tower_history VALUES
(34, 29, 11, 7, '2023-04-15 04:17:17');

INSERT INTO cd.squad VALUES 
(26, 11, 6, 10, 5);

SELECT player_id AS weakest_players FROM cd.player
WHERE rank = (SELECT MIN(rank) FROM cd.player);

SELECT tower_id AS target_towers FROM cd.tower
WHERE owner_id = 10;

INSERT INTO cd.attack VALUES
(11, 26, 25, '2023-04-15 04:26:04', False);

UPDATE cd.player
SET rank = 890
WHERE player_id = 10 OR player_id = 11;

INSERT INTO cd.player_history VALUES
(32, 10, 'congo_wire9563@cd.com', 'Congo Wire', 4, 890, '2023-04-15 04:26:04'),
(33, 11, 'khan5842@cd.com', 'Khan', 1, 890, '2023-04-15 04:26:04');

DELETE FROM cd.player
WHERE player_id = 11;
