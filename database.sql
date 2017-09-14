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
    favorite_id SERIAL PRIMARY KEY,
    username VARCHAR(30) REFERENCES users(username) NOT NULL,
    keyword_id VARCHAR(30) REFERENCES keyword(keyword_id) NOT NULL,
    top_id INT REFERENCES articles(clothing_id) NOT NULL,
    bottom_id INT REFERENCES articles(clothing_id), 
    jacket_id INT REFERENCES articles(clothing_id),
    accessory_id INT REFERENCES articles(clothing_id),
    shoes_id INT REFERENCES articles(clothing_id)
);


CREATE TABLE history (
    history_id SERIAL PRIMARY KEY,
    username VARCHAR(30) REFERENCES users(username) NOT NULL,
    date_worn DATE NOT NULL,
    keyword_id VARCHAR(30) REFERENCES keyword(keyword_id) NOT NULL,
    top_id INT REFERENCES articles(clothing_id) NOT NULL,
    bottom_id INT REFERENCES articles(clothing_id), 
    jacket_id INT REFERENCES articles(clothing_id),
    accessory_id INT REFERENCES articles(clothing_id),
    shoes_id INT REFERENCES articles(clothing_id)
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
('Urban Hike'),
('Dinner'),
('Brunch'),
('Workout'),
('Concert'),
('Girls Night Out'),
('Hiking'),
('Casual Date'),
('Stay At Home'),
('Beach'),
('Picnic'),
('Date Night'),
('Pool'),
('Work');

INSERT INTO articles (username, category_id, description, url) VALUES
('captainangela', 'bottoms', 'Blue Jeans', 'http://static.lindex.com/Archive/ProductImages/7035/7035006/S0000007071004_F_W40_20131129134203.png'),
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
('captainangela', 'bottoms', 'jean shorts', 'http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf39.png'),
('captainangela', 'tops', 'striped crop tshirt', 'https://s-media-cache-ak0.pinimg.com/originals/ce/40/1e/ce401e1dd6906d65c79f254ed1d3c371.png'),
('captainangela', 'tops', 'Boobie tshirt', 'http://gloimg.zaful.com/zaful/pdm-product-pic/Clothing/2017/02/09/thumb-img/1486596367148544257.jpg');

INSERT INTO clothing_keyword (clothing_id, keyword_id) 
VALUES (1, 'Dinner'),
(1, 'Brunch'),
(1, 'Casual Date'),
(1, 'Concert'),
(1, 'Urban Hike'),
(2, 'Casual Date'),
(2, 'Urban Hike'),
(2, 'Workout'),
(2, 'Hiking'),
(2, 'Stay At Home'),
(3, 'Urban Hike'),
(3, 'Casual Date'),
(3, 'Work'),
(4, 'Stay At Home'),
(4, 'Workout'),
(4, 'Hiking'),
(5, 'Stay At Home'),
(5, 'Workout'),
(5, 'Hiking'),
(5, 'Casual Date'),
(6, 'Stay At Home'),
(6, 'Workout'),
(6, 'Hiking'),
(6, 'Casual Date'),
(6, 'Beach'),
(7, 'Casual Date'),
(7, 'Stay At Home'),
(7, 'Picnic'),
(7, 'Urban Hike'),
(8, 'Beach'),
(8, 'Casual Date'),
(8, 'Brunch'),
(8, 'Girls Night Out'),
(8, 'Work'),
(9, 'Casual Date'),
(9, 'Brunch'),
(9, 'Girls Night Out'),
(9, 'Work'),
(9, 'Concert'),
(9, 'Date Night'),
(10, 'Dinner'),
(10, 'Casual Date'),
(10, 'Brunch'),
(10, 'Girls Night Out'),
(10, 'Date Night'),
(10, 'Work'),
(10, 'Dinner'),
(11, 'Casual Date'),
(11, 'Brunch'),
(11, 'Girls Night Out'),
(11, 'Work'),
(11, 'Beach'),
(11, 'Dinner'),
(11, 'Date Night'),
(12, 'Girls Night Out'),
(12, 'Date Night'),
(13, 'Workout'),
(13, 'Hiking'),
(13, 'Stay At Home'),
(13, 'Urban Hike'),
(14, 'Urban Hike'),
(14, 'Brunch'),
(14, 'Concert'),
(14, 'Casual Date'),
(14, 'Beach'),
(14, 'Picnic'),
(14, 'Work'),
(15, 'Work'),
(15, 'Date Night'),
(15, 'Girls Night Out'),
(16, 'Casual Date'),
(16, 'Brunch'),
(16, 'Girls Night Out'),
(16, 'Work'),
(16, 'Beach'),
(16, 'Dinner'),
(17, 'Work'),
(18, 'Work'),
(18, 'Girls Night Out'),
(18, 'Date Night'),
(19, 'Urban Hike'),
(19, 'Workout'),
(19, 'Hiking'),
(19, 'Stay At Home'),
(20, 'Beach'),
(20, 'Picnic'),
(20, 'Brunch'),
(20, 'Casual Date'),
(21, 'Casual Date'),
(21, 'Brunch'),
(21, 'Concert'),
(21, 'Girls Night Out'),
(22, 'Casual Date'),
(22, 'Brunch'),
(22, 'Concert'),
(22, 'Girls Night Out');

INSERT INTO favorites (username, keyword_id, top_id, bottom_id) 
VALUES ('captainangela', 'Girls Night Out', 22, 18),
('captainangela', 'Casual Date', 2, 3),
('captainangela', 'Brunch', 21, 1);

INSERT INTO history (username, date_worn, keyword_id, top_id, bottom_id) 
VALUES ('captainangela', '2017-05-01', 'Girls Night Out', 2, 3),
('captainangela', '2017-05-02', 'Brunch', 21, 1),
('captainangela', '2017-05-05', 'Casual Date', 2, 3),
('captainangela', '2017-05-06', 'Hiking', 2, 4),
('captainangela', '2017-05-08', 'Work', 17, 18),
('captainangela', '2017-05-09', 'Concert', 22, 1),
('captainangela', '2017-05-11', 'Urban Hike', 6, 4),
('captainangela', '2017-05-15', 'Workout', 5, 4),
('captainangela', '2017-05-20', 'Brunch', 21, 20),
('captainangela', '2017-05-21', 'Stay At Home', 19, 1),
('captainangela', '2017-05-24', 'Girls Night Out', 22, 3);


