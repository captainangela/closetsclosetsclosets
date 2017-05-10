-- NOTE that sqlalchemy/database.sql is a symbolic link to sql/database.sql. 
-- ALL changes will be reflected in the sqlalchemy assessment.

CREATE TABLE users (
    username VARCHAR(30) PRIMARY KEY,
    password VARCHAR(64) NOT NULL,
    fname VARCHAR(50),
    lname VARCHAR(50),
    bday DATE,
    zipcode VARCHAR(10)
);


CREATE TABLE category (
    category_id VARCHAR(30) PRIMARY KEY
);


CREATE TABLE keyword (
    keyword_id VARCHAR(30) PRIMARY KEY
);


CREATE TABLE articles (
    clothing_id SERIAL PRIMARY KEY,
    username VARCHAR(30) REFERENCES users(username) NOT NULL,
    category_id VARCHAR(30) REFERENCES category(category_id) NOT NULL,
    description VARCHAR(400) NOT NULL,
    url VARCHAR(400) NOT NULL
);


CREATE TABLE clothing_keyword (
    clothingkeyword_id SERIAL PRIMARY KEY,
    clothing_id INT REFERENCES articles(clothing_id) NOT NULL,
    keyword_id VARCHAR(30) REFERENCES keyword(keyword_id) NOT NULL
);

-- Insert User

INSERT INTO users (username, password, fname, lname, bday, zipcode)
VALUES ('captainangela', 'b37550eace0ed2ee4805608b4986c332', 'Angela', 'Lui', '1988-07-23', '94109');

-- Insert categories

INSERT INTO category (category_id) 
VALUES ('tops'),
('bottoms'),
('dresses'),
('jackets'),
('lounge'),
('swim'),
('active'),
('accessories'),
('shoes');


-- Insert keywords

INSERT INTO keyword (keyword_id) 
VALUES ('spring'),
('summer'),
('fall'),
('winter'),
('urban hike'),
('dinner'),
('brunch'),
('workout'),
('concert'),
('girls night out'),
('hiking'),
('casual date'),
('stay at home'),
('beach'),
('picnic'),
('date night'),
('pool');

-- Insert articles of clothing

INSERT INTO articles (username, category_id, description, url) VALUES
('captainangela', 'bottoms', 'blue jeans', 'https://pics.ae.com/is/image/aeo/3437_9867_068_f?$bvFeed$'),
('captainangela', 'tops', 'sports tank', 'https://s-media-cache-ak0.pinimg.com/736x/62/da/5d/62da5d4cef335c5b9afd407a2c859bd9.jpg'),
('captainangela', 'tops', 'grey knitted sweater', 'http://bpc.h-cdn.co/assets/16/33/480x480/gallery-1471365092-hm-melange-knit-gray-sweater.jpg'),
('captainangela', 'tops', 'grey sweatshirt', 'https://s-media-cache-ak0.pinimg.com/736x/5f/78/46/5f7846258ab336146214fa1019217dad.jpg'),
('captainangela', 'bottoms', 'yoga pants', 'https://photos.cdn-outlet.com/photos/options/8141421-51837-1A-zoomin.jpg'),
('captainangela', 'jackets', 'leather jacket', 'https://static.zara.net/photos///2017/V/0/1/p/5479/241/800/3/w/560/5479241800_6_1_1.jpg?ts=1468842909156'),
('captainangela', 'lounge', 'sweatpants', 'https://uniqlo.scene7.com/is/image/UNIQLO/goods_03_183508?$prod$'),
('captainangela', 'swim', 'one piece swimsuit', 'https://cdn.shopify.com/s/files/1/0077/0432/products/Oasis-Prod-FrontBackjpg_720x720.jpg?v=1490899379'),
('captainangela', 'bottoms', 'black skinny jeans', 'https://s-media-cache-ak0.pinimg.com/736x/8d/f3/65/8df365c6582de260011d84495e8a1a65.jpg'),
('captainangela', 'shoes', 'christian louboutin neon pumps', 'http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=51751607');

-- Insert association

INSERT INTO clothing_keyword (clothing_id, keyword_id) 
VALUES (1, 'dinner'),
(1, 'brunch'),
(1, 'casual date'),
(1, 'fall'),
(1, 'winter'),
(1, 'concert'),
(1, 'spring'),
(1, 'urban hike'),
(2, 'urban hike'),
(2, 'workout'),
(2, 'hiking'),
(3, 'spring'),
(3, 'fall'),
(3, 'winter'),
(3, 'urban hike'),
(3, 'casual date'),
(4, 'stay at home'),
(4, 'workout'),
(4, 'hiking'),
(5, 'stay at home'),
(5, 'workout'),
(5, 'hiking'),
(6, 'fall'),
(6, 'winter'),
(6, 'dinner'),
(6, 'brunch'),
(6, 'concert'),
(6, 'girls night out'),
(6, 'casual date'),
(6, 'date night'),
(7, 'hiking'),
(7, 'stay at home'),
(7, 'workout'),
(8, 'beach'),
(8, 'pool'),
(9, 'brunch'),
(9, 'casual date'),
(9, 'fall'),
(9, 'winter'),
(9, 'concert'),
(9, 'spring'),
(9, 'urban hike'),
(10, 'girls night out'),
(10, 'date night');




