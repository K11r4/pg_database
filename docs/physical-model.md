# Физическая модель

---

Таблица `faction`:

| Название        | Описание           | Тип данных     | Ограничение   |
|-----------------|--------------------|----------------|---------------|
| `faction_id`   | Идентификатор      | `INTEGER` | `PRIMARY KEY` |
| `faction_nm`   | Название     		| `VARCHAR(200)` 		| `NOT NULL` |
| `division`      | Лига фракции       | `INTEGER` 	| `NOT NULL`    |

Таблица `player`:

| Название        	| Описание           | Тип данных     	| Ограничение   |
|-------------------|--------------------|----------------	|---------------|
| `player_id`     	| Идентификатор      | `INTEGER`      	| `PRIMARY KEY` |
| `email`     		| Email игрока       | `VARCHAR(200)` 	| `NOT NULL`    |
| `nick_nm`       	| Имя игрока         | `VARCHAR(200)` 	| `NOT NULL`    |
| `faction_id`     | Название фракции   | `INTEGER` 	|     		  	|
| `rank`     		| Рейтинг игрока     | `INTEGER`  		| `NOT NULL`    |

Таблица `tower_type`:

| Название        	| Описание            	| Тип данных     	| Ограничение   |
|-------------------|-------------------- 	|----------------	|---------------|
| `type_id`   | Идентификатор      | `INTEGER` | `PRIMARY KEY` |
| `type_nm`   | Название     		| `VARCHAR(200)` 		| `NOT NULL` |
| `physical_damage` | Физический урон 	  	| `NUMERIC` 			| `NOT NULL`    |
| `magic_damage`    | Магический урон     	| `NUMERIC` 		| `NOT NULL`    |
| `health`       	| Запас здоровья башни	| `NUMERIC`			| `NOT NULL`    |
| `type_desc`     	| Описание типа    		| `VARCHAR(1000)` 	| `NOT NULL`	|

Таблица `tower`:

| Название    		| Описание                        	| Тип данных  	| Ограничение   |
|-------------		|---------------------------------	|-------------	|---------------|
| `tower_id`  		| Идентификатор            			| `INTEGER`		| `PRIMARY KEY` |
| `owner_id`     	| Идентификатор игрока-владельца   	| `INTEGER`   	| `FOREIGN KEY` |
| `type_id` 		| Идентетификатор типа башни        | `INTEGER`		| `FOREIGN KEY` |
| `x_cord`     		| x-координта 						| `INTEGER`   	| `NOT NULL`    |
| `y_cord`     		| y-координата						| `INTEGER`   	| `NOT NULL`    |

Таблица `unit`:

| Название    		| Описание                        	| Тип данных  		| Ограничение   |
|-------------		|---------------------------------	|-------------		|---------------|
| `type_id`   | Идентификатор      | `INTEGER` | `PRIMARY KEY` |
| `type_nm`   | Название     		| `VARCHAR(200)` 		| `NOT NULL` |
| `damage`   		| Базовые урон          			| `NUMERIC`   		| `NOT NULL` 	|
| `speed`     		| Скорость           				| `NUMERIC`   		| `NOT NULL` 	|
| `health` 			| Запас здоровья                    | `INTEGER` 		| `NOT NULL`    |

Таблица `leader`:

| Название    		| Описание                        	| Тип данных  		| Ограничение   |
|-------------		|---------------------------------	|-------------		|---------------|
| `type_id`   		| Идентификатор      | `INTEGER` | `PRIMARY KEY` |
| `type_nm`   		| Название     		| `VARCHAR(200)` 		| `NOT NULL` |
| `type_desc`    	| Описание    						| `VARCHAR(1000)` 	| `NOT NULL`    |
| `physical_damage` | Физический урон					| `NUMERIC` 		| `NOT NULL`    |
| `magic_damage` 	| Магический урон					| `NUMERIC` 		| `NOT NULL`    |
| `damage_inc_coeff`| Коэффициент повышения базового урона юнитов				| `NUMERIC` 		| `NOT NULL`    |
| `speed`    		| Скорость     						| `NUMERIC` 		| `NOT NULL`    |
| `health`    		| Запас здоровья      				| `INTEGER` 		| `NOT NULL`    |

Таблица `squad`:

| Название    		| Описание                        	| Тип данных  	| Ограничение   |
|-------------		|---------------------------------	|-------------	|---------------|
| `squad_id`  		| Идентификатор             		| `INTEGER`   	| `PRIMARY KEY` |
| `owner_id`     	| Идентификатор игрока-владельца   	| `INTEGER`   	| `FOREIGN KEY` |
| `unit_type`    	| Тип юнитов      					| `INTEGER`| `FOREIGN KEY` |
| `unit_cnt` 		| Количество юнитов					| `INTEGER` 	| `NOT NULL`    |
| `leader_type` 	| Тип лидера						| `INTEGER`| `FOREIGN KEY` |


Таблица `attack`:

| Название    		| Описание                        	| Тип данных  	| Ограничение   |
|-------------		|---------------------------------	|-------------	|---------------|
| `attack_id`  		| Идентификатор            			| `INTEGER`   	| `PRIMARY KEY` |
| `squad_id`    	| Атакующий отряд     				| `INTEGER` 	| `FOREIGN KEY` |
| `tower_id` 		| Атакованная башня					| `INTEGER` 	| `FOREIGN KEY` |
| `attack_dttm` 	| Время завершения атаки			| `TIMESTAMP` 	| `NOT NULL`    |
| `succed_flg`		| Захвачена ли башня				| `BOOLEAN` 	| `NOT NULL`    |

Таблица `player_history`:

| Название        	| Описание           | Тип данных     	| Ограничение   |
|-------------------|--------------------|----------------	|---------------|
| `update_id`  		| Идентификатор            			| `INTEGER`		| `PRIMARY KEY` |
| `player_id`  		| Идентификатор объекта изменения   | `INTEGER`		| `FOREIGN KEY` |
| `email`     		| Email игрока       | `VARCHAR(200)` 	| `NOT NULL`    |
| `nick_nm`       	| Имя игрока         | `VARCHAR(200)` 	| `NOT NULL`    |
| `faction_id`     | Название фракции   | `INTEGER` 	|  `FOREIGN KEY`		  	|
| `rank`     		| Рейтинг игрока     | `INTEGER`  		| `NOT NULL`    |
| `history_dttm`   | Время создания           			| `TIMESTAMP` 	| `NOT NULL` 	|

Таблица `tower_history`:

| Название    		| Описание                        	| Тип данных  	| Ограничение   |
|-------------		|---------------------------------	|-------------	|---------------|
| `update_id`  		| Идентификатор            			| `INTEGER`		| `PRIMARY KEY` |
| `tower_id`  		| Идентификатор объекта изменения   | `INTEGER`		| `FOREIGN KEY` |
| `owner_id`     	| Идентификатор игрока-владельца   	| `INTEGER`   	| `FOREIGN KEY` |
| `type_id` 		| Идентетификатор типа башни        | `INTEGER`| `FOREIGN KEY` |
| `history_dttm`   | Время создания           			| `TIMESTAMP` 	| `NOT NULL` 	|
