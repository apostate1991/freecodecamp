--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(25) NOT NULL,
    description text,
    galaxy_type integer,
    distance_from_earth numeric
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: galaxy_types; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy_types (
    galaxy_types_id integer NOT NULL,
    name character varying(15) NOT NULL,
    description text,
    galaxy_id integer
);


ALTER TABLE public.galaxy_types OWNER TO freecodecamp;

--
-- Name: galaxy_types_galaxy_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_types_galaxy_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_types_galaxy_type_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_types_galaxy_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_types_galaxy_type_id_seq OWNED BY public.galaxy_types.galaxy_types_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30),
    description character varying(150),
    number integer NOT NULL,
    planet_id integer,
    has_life boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30),
    description character varying(150),
    number integer NOT NULL,
    star_id integer,
    has_life boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30),
    description character varying(150),
    number integer,
    radius integer,
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: galaxy_types galaxy_types_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_types ALTER COLUMN galaxy_types_id SET DEFAULT nextval('public.galaxy_types_galaxy_type_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Large Magellanic Cloud
', 'The Large Magellanic Cloud (LMC) is a dwarf galaxy and satellite galaxy of the Milky Way.
', NULL, NULL);
INSERT INTO public.galaxy VALUES (2, 'Andromeda Galaxy', 'Andromeda Galaxy — a vast spiral galaxy located around 2.5 million light years away, making it the closest large galaxy to the Milky Way.
', NULL, NULL);
INSERT INTO public.galaxy VALUES (3, 'Cigar Galaxy', 'The Cigar galaxy experiences gravitational interactions with its galactic neighbor, M81, causing it to have an extraordinarily high rate of star formation — a starburst.', NULL, NULL);
INSERT INTO public.galaxy VALUES (4, 'Pinwheel Galaxy', 'The Pinwheel Galaxy (Messier 101) is a large grand design spiral galaxy in Ursa Major constellation, located about 21 million light years from Earth.', NULL, NULL);
INSERT INTO public.galaxy VALUES (5, 'Sombrero Galaxy', 'The Sombrero galaxy is one of the most massive galaxies in the Virgo galaxy cluster.', NULL, NULL);
INSERT INTO public.galaxy VALUES (6, 'Whirlpool Galaxy', 'The Whirlpool Galaxy, or Messier 51, is like the celestial Picasso of galaxies, residing about 23 million light-years away in Canes Venatici.', NULL, NULL);
INSERT INTO public.galaxy VALUES (7, 'Tadpole Galaxy', 'The Tadpole Galaxy, also known as UGC 10214 and Arp 188, is a disrupted barred spiral galaxy located 420 million light-years from Earth in the northern constellation Draco.', NULL, NULL);
INSERT INTO public.galaxy VALUES (8, 'Hoag''s Object', 'Hoag''s Object — an unusual ring galaxy in the constellation of Serpens Caput. It is named after Arthur Hoag, who discovered it in 1950.', NULL, NULL);
INSERT INTO public.galaxy VALUES (9, 'Condor Galaxy', 'The Condor Galaxy (NGC 6872) is a large spiral galaxy located 212 million light-years away in the constellation Pavo (the Peacock).', NULL, NULL);
INSERT INTO public.galaxy VALUES (10, 'Milky Way', 'The Milky Way is the galaxy that contains the Solar System where the planet Earth is located.', NULL, NULL);


--
-- Data for Name: galaxy_types; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy_types VALUES (1, 'Eleptical', NULL, NULL);
INSERT INTO public.galaxy_types VALUES (2, 'Spiral', NULL, NULL);
INSERT INTO public.galaxy_types VALUES (3, 'Dwarf', NULL, NULL);
INSERT INTO public.galaxy_types VALUES (4, 'Globular', NULL, NULL);
INSERT INTO public.galaxy_types VALUES (5, 'Irregular', NULL, NULL);
INSERT INTO public.galaxy_types VALUES (6, 'Star cluster', NULL, NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', NULL, 1, 3, NULL);
INSERT INTO public.moon VALUES (2, 'asteroid 2002 VE68', NULL, 1, 2, NULL);
INSERT INTO public.moon VALUES (3, 'Phobos', NULL, 1, 4, NULL);
INSERT INTO public.moon VALUES (4, 'Deimos', NULL, 2, 4, NULL);
INSERT INTO public.moon VALUES (5, 'Io', NULL, 1, 5, NULL);
INSERT INTO public.moon VALUES (6, 'Europa', NULL, 2, 5, NULL);
INSERT INTO public.moon VALUES (7, 'Ganymede', NULL, 3, 5, NULL);
INSERT INTO public.moon VALUES (8, 'Callisto', NULL, 4, 5, NULL);
INSERT INTO public.moon VALUES (9, 'Amalthea', NULL, 5, 5, NULL);
INSERT INTO public.moon VALUES (10, 'Mimas', NULL, 1, 6, NULL);
INSERT INTO public.moon VALUES (11, 'Enceladus', NULL, 2, 6, NULL);
INSERT INTO public.moon VALUES (12, 'Tethys', NULL, 3, 6, NULL);
INSERT INTO public.moon VALUES (13, 'Dione', NULL, 4, 6, NULL);
INSERT INTO public.moon VALUES (14, 'Rhea', NULL, 5, 6, NULL);
INSERT INTO public.moon VALUES (15, 'Miranda', NULL, 1, 7, NULL);
INSERT INTO public.moon VALUES (16, 'Ariel', NULL, 2, 7, NULL);
INSERT INTO public.moon VALUES (17, 'Umbriel', NULL, 3, 7, NULL);
INSERT INTO public.moon VALUES (18, 'Titania', NULL, 4, 7, NULL);
INSERT INTO public.moon VALUES (19, 'Oberon', NULL, 5, 7, NULL);
INSERT INTO public.moon VALUES (20, 'Triton', NULL, 1, 8, NULL);
INSERT INTO public.moon VALUES (21, 'Proteus', NULL, 2, 8, NULL);
INSERT INTO public.moon VALUES (22, 'Larissa', NULL, 3, 8, NULL);
INSERT INTO public.moon VALUES (23, 'Despina', NULL, 4, 8, NULL);
INSERT INTO public.moon VALUES (24, 'Galatea', NULL, 5, 8, NULL);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', NULL, 1, 7, NULL);
INSERT INTO public.planet VALUES (2, 'Venus', NULL, 2, 7, NULL);
INSERT INTO public.planet VALUES (3, 'Earth', NULL, 3, 7, NULL);
INSERT INTO public.planet VALUES (4, 'Mars', NULL, 4, 7, NULL);
INSERT INTO public.planet VALUES (5, 'Jupiter', NULL, 5, 7, NULL);
INSERT INTO public.planet VALUES (6, 'Saturn', NULL, 6, 7, NULL);
INSERT INTO public.planet VALUES (7, 'Uranus', NULL, 7, 7, NULL);
INSERT INTO public.planet VALUES (8, 'Neptune', NULL, 8, 7, NULL);
INSERT INTO public.planet VALUES (9, 'Cerera', NULL, 9, 7, NULL);
INSERT INTO public.planet VALUES (10, 'Pluto', NULL, 10, 7, NULL);
INSERT INTO public.planet VALUES (11, 'Haumea', NULL, 11, 7, NULL);
INSERT INTO public.planet VALUES (12, 'Eris', NULL, 12, 7, NULL);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'VY Canis Majoris', 'An extreme oxygen-rich red hypergiant or red supergiant and pulsating variable star', 1, NULL, 10);
INSERT INTO public.star VALUES (2, 'RW Cephei', 'A hypergiant and semirregular variable star in the constellation Cepheus', 2, NULL, 10);
INSERT INTO public.star VALUES (3, 'UY Scuti', 'A red supergiant star, located 5.900 light-years away in the constellation Scutum', 3, NULL, 10);
INSERT INTO public.star VALUES (4, 'WOH G64', NULL, 1, NULL, 1);
INSERT INTO public.star VALUES (5, 'WOHS170', NULL, 2, NULL, 1);
INSERT INTO public.star VALUES (6, 'WOH S170', NULL, 3, NULL, 1);
INSERT INTO public.star VALUES (7, 'Sun', NULL, 0, NULL, 10);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 10, true);


--
-- Name: galaxy_types_galaxy_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_types_galaxy_type_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 24, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: galaxy_types galaxy_types_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_types
    ADD CONSTRAINT galaxy_types_pkey PRIMARY KEY (galaxy_types_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy unique_galaxy_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT unique_galaxy_id UNIQUE (galaxy_id);


--
-- Name: galaxy_types unique_galaxy_type_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_types
    ADD CONSTRAINT unique_galaxy_type_id UNIQUE (galaxy_types_id);


--
-- Name: moon unique_moon_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT unique_moon_id UNIQUE (moon_id);


--
-- Name: planet unique_planet_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT unique_planet_id UNIQUE (planet_id);


--
-- Name: star unique_star_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT unique_star_id UNIQUE (star_id);


--
-- Name: galaxy_types galaxy_types_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy_types
    ADD CONSTRAINT galaxy_types_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

