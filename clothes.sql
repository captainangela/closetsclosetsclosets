--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: angelalui
--

CREATE TABLE articles (
    clothing_id integer NOT NULL,
    username character varying(30) NOT NULL,
    category_id character varying(30) NOT NULL,
    description character varying(400) NOT NULL,
    url character varying(200) NOT NULL
);


ALTER TABLE articles OWNER TO angelalui;

--
-- Name: articles_clothing_id_seq; Type: SEQUENCE; Schema: public; Owner: angelalui
--

CREATE SEQUENCE articles_clothing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE articles_clothing_id_seq OWNER TO angelalui;

--
-- Name: articles_clothing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: angelalui
--

ALTER SEQUENCE articles_clothing_id_seq OWNED BY articles.clothing_id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: angelalui
--

CREATE TABLE category (
    category_id character varying(30) NOT NULL
);


ALTER TABLE category OWNER TO angelalui;

--
-- Name: clothing_keyword; Type: TABLE; Schema: public; Owner: angelalui
--

CREATE TABLE clothing_keyword (
    clothingkeyword_id integer NOT NULL,
    keyword_id character varying(64) NOT NULL,
    clothing_id integer NOT NULL
);


ALTER TABLE clothing_keyword OWNER TO angelalui;

--
-- Name: clothing_keyword_clothingkeyword_id_seq; Type: SEQUENCE; Schema: public; Owner: angelalui
--

CREATE SEQUENCE clothing_keyword_clothingkeyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clothing_keyword_clothingkeyword_id_seq OWNER TO angelalui;

--
-- Name: clothing_keyword_clothingkeyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: angelalui
--

ALTER SEQUENCE clothing_keyword_clothingkeyword_id_seq OWNED BY clothing_keyword.clothingkeyword_id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: angelalui
--

CREATE TABLE favorites (
    favorite_id integer NOT NULL,
    username character varying(30) NOT NULL,
    keyword_id character varying(64) NOT NULL,
    top_id integer,
    bottom_id integer,
    jacket_id integer,
    accessory_id integer,
    shoes_id integer
);


ALTER TABLE favorites OWNER TO angelalui;

--
-- Name: favorites_favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: angelalui
--

CREATE SEQUENCE favorites_favorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE favorites_favorite_id_seq OWNER TO angelalui;

--
-- Name: favorites_favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: angelalui
--

ALTER SEQUENCE favorites_favorite_id_seq OWNED BY favorites.favorite_id;


--
-- Name: history; Type: TABLE; Schema: public; Owner: angelalui
--

CREATE TABLE history (
    history_id integer NOT NULL,
    username character varying(30) NOT NULL,
    keyword_id character varying(64) NOT NULL,
    date_worn timestamp without time zone,
    top_id integer,
    bottom_id integer,
    jacket_id integer,
    accessory_id integer,
    shoes_id integer
);


ALTER TABLE history OWNER TO angelalui;

--
-- Name: history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: angelalui
--

CREATE SEQUENCE history_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE history_history_id_seq OWNER TO angelalui;

--
-- Name: history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: angelalui
--

ALTER SEQUENCE history_history_id_seq OWNED BY history.history_id;


--
-- Name: keyword; Type: TABLE; Schema: public; Owner: angelalui
--

CREATE TABLE keyword (
    keyword_id character varying(30) NOT NULL
);


ALTER TABLE keyword OWNER TO angelalui;

--
-- Name: users; Type: TABLE; Schema: public; Owner: angelalui
--

CREATE TABLE users (
    username character varying(30) NOT NULL,
    password character varying(64) NOT NULL,
    fname character varying(50) NOT NULL,
    lname character varying(50) NOT NULL,
    bday timestamp without time zone,
    zipcode character varying(10)
);


ALTER TABLE users OWNER TO angelalui;

--
-- Name: articles clothing_id; Type: DEFAULT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY articles ALTER COLUMN clothing_id SET DEFAULT nextval('articles_clothing_id_seq'::regclass);


--
-- Name: clothing_keyword clothingkeyword_id; Type: DEFAULT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY clothing_keyword ALTER COLUMN clothingkeyword_id SET DEFAULT nextval('clothing_keyword_clothingkeyword_id_seq'::regclass);


--
-- Name: favorites favorite_id; Type: DEFAULT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites ALTER COLUMN favorite_id SET DEFAULT nextval('favorites_favorite_id_seq'::regclass);


--
-- Name: history history_id; Type: DEFAULT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history ALTER COLUMN history_id SET DEFAULT nextval('history_history_id_seq'::regclass);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: angelalui
--

COPY articles (clothing_id, username, category_id, description, url) FROM stdin;
1	captainangela	bottoms	Blue Jeans	http://static.lindex.com/Archive/ProductImages/7035/7035006/S0000007071004_F_W40_20131129134203.png
2	captainangela	tops	plain grey sweater	http://www.teerabbit.com/product_view_image/s/image/4/468/353/sportgrey.png?1441067253
3	captainangela	bottoms	black jeggings	http://www.olsen.co.uk/out/pictures/master/product/1/14000007-80000_1.png
4	captainangela	bottoms	grey yoga pants	http://blog.theclymb.com/wp-content/uploads/2013/09/lucy-lotus-pant.png
5	captainangela	tops	grey worded tank top	 http://cdn.shopify.com/s/files/1/0236/0293/products/1_appearanceId_164_width_350_height_350_6ed10627-4720-4451-9c5d-d6052414c747_grande.png?v=1494367772
6	captainangela	tops	white tshirt with pocket	http://cdn.shopify.com/s/files/1/0226/0157/products/pocket-tee-ashley-womens-001_large.png?v=1433832419
7	captainangela	tops	icelandic sweater	https://cdn.shopify.com/s/files/1/0790/7429/products/f89941-020-ovik-knit-sweater-w_53617f64-5bb8-4bbd-85c0-f9f3c4ce50a5_grande.png?v=1488861365
8	captainangela	dresses	pink polka dot dress	http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bef7.png
9	captainangela	jackets	leather jacket	https://ivoryleathers.com/media/wysiwyg/womens-leather-motorcycle-jacket.png
10	captainangela	jackets	peacoat	http://www.buzzricksons.com/images/product/Peacoat.png
11	captainangela	jackets	jean jacket	http://myfashionwants.com/wp-content/uploads/2014/06/cropped-jean-jacket-from-Citizens-of-Humanity.png
12	captainangela	shoes	yellow heels	https://img.clipartfest.com/16a3d0cfd4d272c1ea32eed332d3b0ef_yellow-women-shoes-png-image-ladies-shoes-clipart-png_1407-1248.png
13	captainangela	shoes	running shoes	http://www.pngall.com/wp-content/uploads/2016/04/Running-Shoes-PNG-File.png
14	captainangela	shoes	black converse	https://userscontent2.emaze.com/images/5b64e6f4-18d8-4007-b723-d220a09c6b52/94b0f4423c415805f6aff7e39b5cbef9.png
15	captainangela	dresses	blue dress	http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bef1.png
16	captainangela	accessories	green longchamp	http://www.stickpng.com/assets/thumbs/5864f8797d90850fc3ce2a14.png
17	captainangela	tops	black dressshirt	http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf55.png
18	captainangela	bottoms	black pleather skirt	http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf65.png
19	captainangela	tops	nike sweatshirt	http://www.stickpng.com/assets/thumbs/58e38d00204d556bbd97b162.png
20	captainangela	bottoms	jean shorts	http://www.stickpng.com/assets/thumbs/580b57fbd9996e24bc43bf39.png
21	captainangela	tops	striped crop tshirt	https://s-media-cache-ak0.pinimg.com/originals/ce/40/1e/ce401e1dd6906d65c79f254ed1d3c371.png
22	captainangela	tops	Boobie tshirt	http://gloimg.zaful.com/zaful/pdm-product-pic/Clothing/2017/02/09/thumb-img/1486596367148544257.jpg
\.


--
-- Name: articles_clothing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: angelalui
--

SELECT pg_catalog.setval('articles_clothing_id_seq', 22, true);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: angelalui
--

COPY category (category_id) FROM stdin;
tops
bottoms
dresses
jackets
accessories
shoes
\.


--
-- Data for Name: clothing_keyword; Type: TABLE DATA; Schema: public; Owner: angelalui
--

COPY clothing_keyword (clothingkeyword_id, keyword_id, clothing_id) FROM stdin;
1	Dinner	1
2	Brunch	1
3	Casual Date	1
4	Concert	1
5	Urban Hike	1
6	Casual Date	2
7	Urban Hike	2
8	Workout	2
9	Hiking	2
10	Stay At Home	2
11	Urban Hike	3
12	Casual Date	3
13	Work	3
14	Stay At Home	4
15	Workout	4
16	Hiking	4
17	Stay At Home	5
18	Workout	5
19	Hiking	5
20	Casual Date	5
21	Stay At Home	6
22	Workout	6
23	Hiking	6
24	Casual Date	6
25	Beach	6
26	Casual Date	7
27	Stay At Home	7
28	Picnic	7
29	Urban Hike	7
30	Beach	8
31	Casual Date	8
32	Brunch	8
33	Girls Night Out	8
34	Work	8
35	Casual Date	9
36	Brunch	9
37	Girls Night Out	9
38	Work	9
39	Concert	9
40	Date Night	9
41	Dinner	10
42	Casual Date	10
43	Brunch	10
44	Girls Night Out	10
45	Date Night	10
46	Work	10
47	Dinner	10
48	Casual Date	11
49	Brunch	11
50	Girls Night Out	11
51	Work	11
52	Beach	11
53	Dinner	11
54	Date Night	11
55	Girls Night Out	12
56	Date Night	12
57	Workout	13
58	Hiking	13
59	Stay At Home	13
60	Urban Hike	13
61	Urban Hike	14
62	Brunch	14
63	Concert	14
64	Casual Date	14
65	Beach	14
66	Picnic	14
67	Work	14
68	Work	15
69	Date Night	15
70	Girls Night Out	15
71	Casual Date	16
72	Brunch	16
73	Girls Night Out	16
74	Work	16
75	Beach	16
76	Dinner	16
77	Work	17
78	Work	18
79	Girls Night Out	18
80	Date Night	18
81	Urban Hike	19
82	Workout	19
83	Hiking	19
84	Stay At Home	19
85	Beach	20
86	Picnic	20
87	Brunch	20
88	Casual Date	20
89	Casual Date	21
90	Brunch	21
91	Concert	21
92	Girls Night Out	21
93	Casual Date	22
94	Brunch	22
95	Concert	22
96	Girls Night Out	22
\.


--
-- Name: clothing_keyword_clothingkeyword_id_seq; Type: SEQUENCE SET; Schema: public; Owner: angelalui
--

SELECT pg_catalog.setval('clothing_keyword_clothingkeyword_id_seq', 96, true);


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: angelalui
--

COPY favorites (favorite_id, username, keyword_id, top_id, bottom_id, jacket_id, accessory_id, shoes_id) FROM stdin;
1	captainangela	Girls Night Out	22	18	\N	\N	\N
2	captainangela	Casual Date	2	3	\N	\N	\N
3	captainangela	Brunch	21	1	\N	\N	\N
\.


--
-- Name: favorites_favorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: angelalui
--

SELECT pg_catalog.setval('favorites_favorite_id_seq', 3, true);


--
-- Data for Name: history; Type: TABLE DATA; Schema: public; Owner: angelalui
--

COPY history (history_id, username, keyword_id, date_worn, top_id, bottom_id, jacket_id, accessory_id, shoes_id) FROM stdin;
1	captainangela	Girls Night Out	2017-05-01 00:00:00	2	3	\N	\N	\N
2	captainangela	Brunch	2017-05-02 00:00:00	21	1	\N	\N	\N
3	captainangela	Casual Date	2017-05-05 00:00:00	2	3	\N	\N	\N
4	captainangela	Hiking	2017-05-06 00:00:00	2	4	\N	\N	\N
5	captainangela	Work	2017-05-08 00:00:00	17	18	\N	\N	\N
6	captainangela	Concert	2017-05-09 00:00:00	22	1	\N	\N	\N
7	captainangela	Urban Hike	2017-05-11 00:00:00	6	4	\N	\N	\N
8	captainangela	Workout	2017-05-15 00:00:00	5	4	\N	\N	\N
9	captainangela	Brunch	2017-05-20 00:00:00	21	20	\N	\N	\N
10	captainangela	Stay At Home	2017-05-21 00:00:00	19	1	\N	\N	\N
11	captainangela	Girls Night Out	2017-05-24 00:00:00	22	3	\N	\N	\N
\.


--
-- Name: history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: angelalui
--

SELECT pg_catalog.setval('history_history_id_seq', 11, true);


--
-- Data for Name: keyword; Type: TABLE DATA; Schema: public; Owner: angelalui
--

COPY keyword (keyword_id) FROM stdin;
Urban Hike
Dinner
Brunch
Workout
Concert
Girls Night Out
Hiking
Casual Date
Stay At Home
Beach
Picnic
Date Night
Pool
Work
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: angelalui
--

COPY users (username, password, fname, lname, bday, zipcode) FROM stdin;
captainangela	b37550eace0ed2ee4805608b4986c332	Angela	Lui	1988-07-23 00:00:00	94109
\.


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (clothing_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: clothing_keyword clothing_keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY clothing_keyword
    ADD CONSTRAINT clothing_keyword_pkey PRIMARY KEY (clothingkeyword_id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (favorite_id);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_pkey PRIMARY KEY (history_id);


--
-- Name: keyword keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY keyword
    ADD CONSTRAINT keyword_pkey PRIMARY KEY (keyword_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: articles articles_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_category_id_fkey FOREIGN KEY (category_id) REFERENCES category(category_id);


--
-- Name: articles articles_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_username_fkey FOREIGN KEY (username) REFERENCES users(username);


--
-- Name: clothing_keyword clothing_keyword_clothing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY clothing_keyword
    ADD CONSTRAINT clothing_keyword_clothing_id_fkey FOREIGN KEY (clothing_id) REFERENCES articles(clothing_id);


--
-- Name: clothing_keyword clothing_keyword_keyword_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY clothing_keyword
    ADD CONSTRAINT clothing_keyword_keyword_id_fkey FOREIGN KEY (keyword_id) REFERENCES keyword(keyword_id);


--
-- Name: favorites favorites_accessory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_accessory_id_fkey FOREIGN KEY (accessory_id) REFERENCES articles(clothing_id);


--
-- Name: favorites favorites_bottom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_bottom_id_fkey FOREIGN KEY (bottom_id) REFERENCES articles(clothing_id);


--
-- Name: favorites favorites_jacket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_jacket_id_fkey FOREIGN KEY (jacket_id) REFERENCES articles(clothing_id);


--
-- Name: favorites favorites_keyword_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_keyword_id_fkey FOREIGN KEY (keyword_id) REFERENCES keyword(keyword_id);


--
-- Name: favorites favorites_shoes_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_shoes_id_fkey FOREIGN KEY (shoes_id) REFERENCES articles(clothing_id);


--
-- Name: favorites favorites_top_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_top_id_fkey FOREIGN KEY (top_id) REFERENCES articles(clothing_id);


--
-- Name: favorites favorites_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_username_fkey FOREIGN KEY (username) REFERENCES users(username);


--
-- Name: history history_accessory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_accessory_id_fkey FOREIGN KEY (accessory_id) REFERENCES articles(clothing_id);


--
-- Name: history history_bottom_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_bottom_id_fkey FOREIGN KEY (bottom_id) REFERENCES articles(clothing_id);


--
-- Name: history history_jacket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_jacket_id_fkey FOREIGN KEY (jacket_id) REFERENCES articles(clothing_id);


--
-- Name: history history_keyword_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_keyword_id_fkey FOREIGN KEY (keyword_id) REFERENCES keyword(keyword_id);


--
-- Name: history history_shoes_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_shoes_id_fkey FOREIGN KEY (shoes_id) REFERENCES articles(clothing_id);


--
-- Name: history history_top_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_top_id_fkey FOREIGN KEY (top_id) REFERENCES articles(clothing_id);


--
-- Name: history history_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: angelalui
--

ALTER TABLE ONLY history
    ADD CONSTRAINT history_username_fkey FOREIGN KEY (username) REFERENCES users(username);


--
-- PostgreSQL database dump complete
--

