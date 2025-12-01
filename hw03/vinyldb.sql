CREATE SCHEMA vinyl;
SET SEARCH_PATH TO vinyl;

CREATE TABLE vinyl_albums (
   album_id    SERIAL,
   title      VARCHAR(1000) NOT NULL,
   artist     VARCHAR(1000) NOT NULL,
   condition  SMALLINT NOT NULL, -- 5:excellent, 4:very good, 3:good, 2:fair, 1:poor
   price      NUMERIC(5,2) NOT NULL,
   seller_id INT,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
   updated_at TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
   PRIMARY KEY (album_id)
);

CREATE TABLE vinyl_users (
   user_id    SERIAL,
   email      VARCHAR(1000) NOT NULL,
   name       VARCHAR(1000) NOT NULL,
   password   VARCHAR(1000) NOT NULL,
   PRIMARY KEY (user_id)
);

CREATE VIEW get_all_albums AS
    SELECT album_id, title, artist, condition, price, seller_id, email, name, created_at AT TIME ZONE 'America/Chicago' AS create_ts, updated_at AT TIME ZONE 'America/Chicago' AS update_ts
        FROM vinyl_albums INNER JOIN vinyl_users ON (vinyl_albums.seller_id = vinyl_users.user_id) ORDER BY create_ts DESC;

CREATE VIEW get_recent_albums AS
    SELECT album_id, title, artist, condition, price, seller_id, email, name, created_at AT TIME ZONE 'America/Chicago' AS create_ts, updated_at AT TIME ZONE 'America/Chicago' AS update_ts
        FROM vinyl_albums INNER JOIN vinyl_users ON (vinyl_albums.seller_id = vinyl_users.user_id) ORDER BY create_ts DESC LIMIT 10;

INSERT INTO vinyl_users (email, name, password)
VALUES
('alex@vinylmail.com',  'Alex Turner',  'hashed_pw_1'),
('bella@vinylmail.com', 'Bella Cruz',   'hashed_pw_2'),
('charlie@vinylmail.com','Charlie West','hashed_pw_3');

-- Albums ------------------------------------------------------------
INSERT INTO vinyl_albums (title, artist, condition, price, seller_id, created_at)
VALUES
('Abbey Road',                 'The Beatles',           4, 29.99, 1, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Dark Side of the Moon',      'Pink Floyd',            5, 34.50, 1, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Kind of Blue',               'Miles Davis',           3, 22.00, 2, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Rumours',                    'Fleetwood Mac',         4, 27.75, 2, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Thriller',                   'Michael Jackson',       5, 31.00, 3, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Hotel California',           'Eagles',                4, 26.50, 3, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Nevermind',                  'Nirvana',               3, 21.25, 1, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Back in Black',              'AC/DC',                 5, 28.00, 1, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Led Zeppelin IV',            'Led Zeppelin',          4, 25.99, 2, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Born to Run',                'Bruce Springsteen',     3, 23.00, 3, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('The Wall',                   'Pink Floyd',            4, 32.00, 1, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Sgt. Pepper''s Lonely Hearts Club Band', 'The Beatles', 5, 33.50, 2, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('A Night at the Opera',       'Queen',                 4, 29.00, 3, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Purple Rain',                'Prince',                3, 19.75, 1, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('The Joshua Tree',            'U2',                    4, 26.00, 2, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Goodbye Yellow Brick Road',  'Elton John',            5, 28.25, 3, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Appetite for Destruction',   'Guns N'' Roses',        4, 24.50, 2, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('The Rise and Fall of Ziggy Stardust', 'David Bowie',  3, 22.75, 1, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Graceland',                  'Paul Simon',            5, 27.00, 2, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01'))),
('Back to Black',              'Amy Winehouse',         4, 23.99, 3, TIMESTAMP '2025-10-01' + (RANDOM() * (TIMESTAMP '2026-01-30' - TIMESTAMP '2025-10-01')));

UPDATE vinyl_albums SET updated_at=created_at;