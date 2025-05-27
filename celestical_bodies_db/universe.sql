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
    name character varying NOT NULL,
    galaxy_id integer NOT NULL,
    description text,
    has_life boolean NOT NULL,
    is_spherical boolean NOT NULL,
    age_in_millions_of_years integer,
    galaxy_types text[],
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
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    name character varying NOT NULL,
    moon_id integer NOT NULL,
    description text,
    has_life boolean NOT NULL,
    is_spherical boolean NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric,
    planet_types text[],
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_hierarchy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon_hierarchy (
    name character varying NOT NULL,
    moon_id integer NOT NULL,
    planet_id integer,
    star_id integer,
    galaxy_id integer
);


ALTER TABLE public.moon_hierarchy OWNER TO freecodecamp;

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
    name character varying NOT NULL,
    planet_id integer NOT NULL,
    description text,
    has_life boolean NOT NULL,
    is_spherical boolean NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric,
    star_id integer
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
    name character varying NOT NULL,
    star_id integer NOT NULL,
    description text,
    has_life boolean NOT NULL,
    is_spherical boolean NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric,
    planet_types text[],
    galaxy_id integer
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

INSERT INTO public.galaxy VALUES ('Milky Way', 1, 'Our home galaxy, a barred spiral containing our solar system.', true, false, 13600, '{"barred spiral"}', 0);
INSERT INTO public.galaxy VALUES ('Andromeda', 2, 'Nearest major galaxy to the Milky Way, on a collision course with it.', false, false, 10000, '{spiral}', 2537000);
INSERT INTO public.galaxy VALUES ('Whirlpool Galaxy', 3, 'A classic spiral galaxy with prominent arms, also known as M51.', false, false, 400, '{spiral}', 23000000);
INSERT INTO public.galaxy VALUES ('GN-z11', 4, 'One of the most distant galaxies observed, dating back to the early universe.', false, false, 400, '{irregular}', 32000000000);
INSERT INTO public.galaxy VALUES ('Sombrero Galaxy', 5, 'A spiral galaxy with a bright nucleus and large central bulge.', false, false, 10000, '{spiral}', 29000000);
INSERT INTO public.galaxy VALUES ('Cartwheel Galaxy', 6, 'A ring galaxy formed by a collision, exhibiting intense star formation.', false, false, 400, '{ring}', 500000000);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES ('Moon', 21, 'Earth’s only natural satellite, influencing tides and stabilizing Earth’s axial tilt.', false, true, 4500, 0.00000257, '{terrestrial}', 13);
INSERT INTO public.moon VALUES ('Phobos', 22, 'The larger and closer of Mars’ two moons, gradually spiraling inward.', false, true, 4500, 0.0000158, '{terrestrial}', 14);
INSERT INTO public.moon VALUES ('Deimos', 23, 'The smaller and more distant of Mars’ two moons, with a smooth surface.', false, true, 4500, 0.0000158, '{terrestrial}', 14);
INSERT INTO public.moon VALUES ('Venusia', 24, 'A speculative moon orbiting Venus, mainly theoretical.', false, true, 4500, 0.0000026, '{terrestrial}', 15);
INSERT INTO public.moon VALUES ('Hypo-1a', 25, 'A hypothetical moon orbiting the gas giant Hypothetica-1.', false, true, 1000, 642.5, '{"gas giant"}', 16);
INSERT INTO public.moon VALUES ('Hypo-1b', 26, 'Another hypothetical moon of Hypothetica-1, possibly icy.', false, true, 1000, 642.5, '{"gas giant"}', 16);
INSERT INTO public.moon VALUES ('Hypo-2a', 27, 'A rocky moon orbiting the hypothetical planet Hypothetica-2.', false, true, 1000, 642.5, '{rocky}', 17);
INSERT INTO public.moon VALUES ('Hypo-2b', 28, 'Another rocky moon of Hypothetica-2.', false, true, 1000, 642.5, '{rocky}', 17);
INSERT INTO public.moon VALUES ('Alph-b1', 29, 'A moon orbiting the exoplanet Alpheratz b.', false, true, 5000, 97, '{exoplanet}', 18);
INSERT INTO public.moon VALUES ('Alph-b2', 30, 'A second moon of Alpheratz b.', false, true, 5000, 97, '{exoplanet}', 18);
INSERT INTO public.moon VALUES ('Alph-c1', 31, 'A moon orbiting the exoplanet Alpheratz c.', false, true, 5000, 97, '{exoplanet}', 19);
INSERT INTO public.moon VALUES ('Alph-c2', 32, 'A second moon of Alpheratz c.', false, true, 5000, 97, '{exoplanet}', 19);
INSERT INTO public.moon VALUES ('Mir-b1', 33, 'A moon orbiting the exoplanet Mirach b.', false, true, 6000, 200, '{exoplanet}', 20);
INSERT INTO public.moon VALUES ('Mir-b2', 34, 'A second moon of Mirach b.', false, true, 6000, 200, '{exoplanet}', 20);
INSERT INTO public.moon VALUES ('Mir-c1', 35, 'A moon orbiting the exoplanet Mirach c.', false, true, 6000, 200, '{exoplanet}', 21);
INSERT INTO public.moon VALUES ('Mir-c2', 36, 'A second moon of Mirach c.', false, true, 6000, 200, '{exoplanet}', 21);
INSERT INTO public.moon VALUES ('RSG-b1', 37, 'A massive moon orbiting the exoplanet RSGC1-F08 b.', false, true, 7000, 25000, '{"gas giant"}', 22);
INSERT INTO public.moon VALUES ('RSG-c1', 38, 'A massive moon orbiting the exoplanet RSGC1-F08 c.', false, true, 7000, 25000, '{"gas giant"}', 23);
INSERT INTO public.moon VALUES ('GN-b1', 39, 'A moon orbiting the distant exoplanet GN-z11 b.', false, true, 400, 32000000000, '{exoplanet}', 24);
INSERT INTO public.moon VALUES ('GN-b2', 40, 'A second moon orbiting the exoplanet GN-z11 b.', false, true, 400, 32000000000, '{exoplanet}', 24);


--
-- Data for Name: moon_hierarchy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon_hierarchy VALUES ('Moon', 21, 13, 1, 1);
INSERT INTO public.moon_hierarchy VALUES ('Phobos', 22, 14, 1, 1);
INSERT INTO public.moon_hierarchy VALUES ('Deimos', 23, 14, 1, 1);
INSERT INTO public.moon_hierarchy VALUES ('Venusia', 24, 15, 1, 1);
INSERT INTO public.moon_hierarchy VALUES ('Hypo-1a', 25, 16, 2, 1);
INSERT INTO public.moon_hierarchy VALUES ('Hypo-1b', 26, 16, 2, 1);
INSERT INTO public.moon_hierarchy VALUES ('Hypo-2a', 27, 17, 2, 1);
INSERT INTO public.moon_hierarchy VALUES ('Hypo-2b', 28, 17, 2, 1);
INSERT INTO public.moon_hierarchy VALUES ('Alph-b1', 29, 18, 3, 2);
INSERT INTO public.moon_hierarchy VALUES ('Alph-b2', 30, 18, 3, 2);
INSERT INTO public.moon_hierarchy VALUES ('Alph-c1', 31, 19, 3, 2);
INSERT INTO public.moon_hierarchy VALUES ('Alph-c2', 32, 19, 3, 2);
INSERT INTO public.moon_hierarchy VALUES ('Mir-b1', 33, 20, 4, 2);
INSERT INTO public.moon_hierarchy VALUES ('Mir-b2', 34, 20, 4, 2);
INSERT INTO public.moon_hierarchy VALUES ('Mir-c1', 35, 21, 4, 2);
INSERT INTO public.moon_hierarchy VALUES ('Mir-c2', 36, 21, 4, 2);
INSERT INTO public.moon_hierarchy VALUES ('RSG-b1', 37, 22, 5, 1);
INSERT INTO public.moon_hierarchy VALUES ('RSG-c1', 38, 23, 5, 1);
INSERT INTO public.moon_hierarchy VALUES ('GN-b1', 39, 24, 6, 4);
INSERT INTO public.moon_hierarchy VALUES ('GN-b2', 40, 24, 6, 4);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES ('Earth', 13, 'Our home planet, the only known planet to support life.', true, true, 4540, 0, 1);
INSERT INTO public.planet VALUES ('Mars', 14, 'The Red Planet, known for its iron oxide-rich surface.', false, true, 4500, 0.0000158, 1);
INSERT INTO public.planet VALUES ('Venus', 15, 'Second planet from the Sun, with a thick, toxic atmosphere.', false, true, 4500, 0.0000026, 1);
INSERT INTO public.planet VALUES ('Hypothetica-1', 16, 'A hypothetical gas giant orbiting Betelgeuse.', false, true, 1000, 642.5, 2);
INSERT INTO public.planet VALUES ('Hypothetica-2', 17, 'A hypothetical rocky planet orbiting Betelgeuse.', false, true, 1000, 642.5, 2);
INSERT INTO public.planet VALUES ('Alpheratz b', 18, 'An exoplanet orbiting the binary star system Alpheratz.', false, true, 5000, 97, 3);
INSERT INTO public.planet VALUES ('Alpheratz c', 19, 'A second exoplanet in the Alpheratz system.', false, true, 5000, 97, 3);
INSERT INTO public.planet VALUES ('Mirach b', 20, 'An exoplanet orbiting the red giant star Mirach.', false, true, 6000, 200, 4);
INSERT INTO public.planet VALUES ('Mirach c', 21, 'A second exoplanet in the Mirach system.', false, true, 6000, 200, 4);
INSERT INTO public.planet VALUES ('RSGC1-F08 b', 22, 'A massive exoplanet orbiting the red supergiant RSGC1-F08.', false, true, 7000, 25000, 5);
INSERT INTO public.planet VALUES ('RSGC1-F08 c', 23, 'A second massive exoplanet in the RSGC1-F08 system.', false, true, 7000, 25000, 5);
INSERT INTO public.planet VALUES ('GN-z11 b', 24, 'A hypothetical exoplanet in the distant galaxy GN-z11.', false, true, 400, 32000000000, 6);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES ('Sun', 1, 'The central star of our solar system, providing light and heat to Earth.', true, true, 4600, 0, '{terrestrial,"gas giant"}', 1);
INSERT INTO public.star VALUES ('Betelgeuse', 2, 'A red supergiant star nearing the end of its life, located in the Orion constellation.', false, true, 10000, 642.5, '{none}', 1);
INSERT INTO public.star VALUES ('Alpheratz', 3, 'A binary star system and the brightest star in the Andromeda constellation.', false, true, 60, 97, '{unknown}', 2);
INSERT INTO public.star VALUES ('Mirach', 4, 'A red giant star in the Andromeda constellation, known for its brightness and variability.', false, true, 10000, 200, '{unknown}', 2);
INSERT INTO public.star VALUES ('RSGC1-F08', 5, 'A massive red supergiant star located in the Scutum constellation.', false, true, 10000, 25000, '{none}', 1);
INSERT INTO public.star VALUES ('GN-z11 Star A', 6, 'A hypothetical massive star in the distant galaxy GN-z11, one of the earliest known galaxies.', false, true, 400, 32000000000, '{unknown}', 4);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 40, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 24, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon_hierarchy moon_hierarchy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon_hierarchy
    ADD CONSTRAINT moon_hierarchy_pkey PRIMARY KEY (name);


--
-- Name: moon_hierarchy moon_name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon_hierarchy
    ADD CONSTRAINT moon_name UNIQUE (name);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


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
