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

CREATE TABLE favorites (
    favorites_id SERIAL PRIMARY KEY,
    clothing_id1 INT REFERENCES articles(clothing_id) NOT NULL,
    clothing_id2 INT REFERENCES articles(clothing_id), 
    clothing_id3 INT REFERENCES articles(clothing_id),
    clothing_id4 INT REFERENCES articles(clothing_id),
    clothing_id5 INT REFERENCES articles(clothing_id)
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
('accessories'),
('shoes');


-- Insert keywords

INSERT INTO keyword (keyword_id) 
VALUES 
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
('pool'),
('work');

-- Insert articles of clothing

INSERT INTO articles (username, category_id, description, url) VALUES
('captainangela', 'bottoms', 'blue jeans', 'http://static.lindex.com/Archive/ProductImages/7035/7035006/S0000007071004_F_W40_20131129134203.png'),
('captainangela', 'tops', 'plain grey sweater', 'http://www.teerabbit.com/product_view_image/s/image/4/468/353/sportgrey.png?1441067253'),
('captainangela', 'bottoms', 'black jeggings', 'http://www.olsen.co.uk/out/pictures/master/product/1/14000007-80000_1.png'),
('captainangela', 'bottoms', 'grey yoga pants', 'http://blog.theclymb.com/wp-content/uploads/2013/09/lucy-lotus-pant.png'),
('captainangela', 'tops', 'grey worded tank top', ' http://cdn.shopify.com/s/files/1/0236/0293/products/1_appearanceId_164_width_350_height_350_6ed10627-4720-4451-9c5d-d6052414c747_grande.png?v=1494367772'),
('captainangela', 'tops', 'white tshirt with pocket', 'http://cdn.shopify.com/s/files/1/0226/0157/products/pocket-tee-ashley-womens-001_large.png?v=1433832419'),
('captainangela', 'tops', 'icelandic sweater', 'https://cdn.shopify.com/s/files/1/0790/7429/products/f89941-020-ovik-knit-sweater-w_53617f64-5bb8-4bbd-85c0-f9f3c4ce50a5_grande.png?v=1488861365'),
('captainangela', 'dresses', 'pink polka dot dress', 'http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bef7.png'),
('captainangela', 'jackets', 'leather jacket', 'https://ivoryleathers.com/media/wysiwyg/womens-leather-motorcycle-jacket.png'),
('captainangela', 'jackets', 'peacoat', 'http://www.buzzricksons.com/images/product/Peacoat.png'),
('captainangela', 'jackets', 'jean jacket', 'http://myfashionwants.com/wp-content/uploads/2014/06/cropped-jean-jacket-from-Citizens-of-Humanity.png'),
('captainangela', 'shoes', 'yellow heels', 'https://img.clipartfest.com/16a3d0cfd4d272c1ea32eed332d3b0ef_yellow-women-shoes-png-image-ladies-shoes-clipart-png_1407-1248.png'),
('captainangela', 'shoes', 'running shoes', 'http://www.pngall.com/wp-content/uploads/2016/04/Running-Shoes-PNG-File.png'),
('captainangela', 'shoes', 'black converse', 'https://userscontent2.emaze.com/images/5b64e6f4-18d8-4007-b723-d220a09c6b52/94b0f4423c415805f6aff7e39b5cbef9.png'),
('captainangela', 'dresses', 'blue dress', 'http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bef1.png'),
('captainangela', 'accessories', 'green longchamp', 'http://www.stickpng.com/assets/thumbs/5864f8797d90850fc3ce2a14.png'),
('captainangela', 'tops', 'black dressshirt', 'http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf55.png'),
('captainangela', 'bottoms', 'black pleather skirt', 'http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf65.png'),
('captainangela', 'tops', 'nike sweatshirt', 'http://www.stickpng.com/assets/thumbs/58e38d00204d556bbd97b162.png'),
('captainangela', 'bottoms', 'jean shorts', 'http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf39.png');


INSERT INTO clothing_keyword (clothing_id, keyword_id) 
VALUES (1, 'dinner'),
(1, 'brunch'),
(1, 'casual date'),
(1, 'concert'),
(1, 'urban hike'),
(2, 'urban hike'),
(2, 'workout'),
(2, 'hiking'),
(2, 'stay at home'),
(3, 'urban hike'),
(3, 'casual date'),
(3, 'work'),
(4, 'stay at home'),
(4, 'workout'),
(4, 'hiking'),
(5, 'stay at home'),
(5, 'workout'),
(5, 'hiking'),
(5, 'casual date'),
(6, 'stay at home'),
(6, 'workout'),
(6, 'hiking'),
(6, 'casual date'),
(6, 'beach'),
(7, 'casual date'),
(7, 'stay at home'),
(7, 'picnic'),
(7, 'urban hike'),
(8, 'beach'),
(8, 'casual date'),
(8, 'brunch'),
(8, 'girls night out'),
(8, 'work'),
(9, 'casual date'),
(9, 'brunch'),
(9, 'girls night out'),
(9, 'work'),
(9, 'concert'),
(9, 'date night'),
(10, 'dinner'),
(10, 'casual date'),
(10, 'brunch'),
(10, 'girls night out'),
(10, 'date night'),
(10, 'work'),
(10, 'dinner'),
(11, 'casual date'),
(11, 'brunch'),
(11, 'girls night out'),
(11, 'work'),
(11, 'beach'),
(11, 'dinner'),
(11, 'date night'),
(12, 'girls night out'),
(12, 'date night'),
(13, 'workout'),
(13, 'hiking'),
(13, 'stay at home'),
(13, 'urban hike'),
(14, 'urban hike'),
(14, 'brunch'),
(14, 'concert'),
(14, 'casual date'),
(14, 'beach'),
(14, 'picnic'),
(14, 'work'),
(15, 'work'),
(15, 'date night'),
(15, 'girls night out'),
(16, 'casual date'),
(16, 'brunch'),
(16, 'girls night out'),
(16, 'work'),
(16, 'beach'),
(16, 'dinner'),
(17, 'work'),
(18, 'work'),
(18, 'girls night out'),
(18, 'date night'),
(19, 'urban hike'),
(19, 'workout'),
(19, 'hiking'),
(19, 'stay at home'),
(20, 'beach'),
(20, 'picnic'),
(20, 'brunch'),
(20, 'casual date');

