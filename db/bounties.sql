DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  value INT2,
  favourite_weapon VARCHAR(255),
  danger_level VARCHAR(255)
);
