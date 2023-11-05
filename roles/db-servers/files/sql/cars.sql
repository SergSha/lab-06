
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

CREATE DATABASE cars WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru_RU.UTF-8';

ALTER DATABASE cars OWNER TO postgres;

\connect cars

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

CREATE TABLE public.new (
    id integer NOT NULL,
    name character varying(20) DEFAULT NULL::character varying,
    year integer,
    price integer
);


ALTER TABLE public.new OWNER TO postgres;

CREATE SEQUENCE public.new_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.new_id_seq OWNER TO postgres;

ALTER SEQUENCE public.new_id_seq OWNED BY public.new.id;

CREATE TABLE public.used (
    id integer NOT NULL,
    name character varying(20) DEFAULT NULL::character varying,
    year integer,
    price integer
);


ALTER TABLE public.used OWNER TO postgres;

CREATE SEQUENCE public.used_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.used_id_seq OWNER TO postgres;

ALTER SEQUENCE public.used_id_seq OWNED BY public.used.id;

ALTER TABLE ONLY public.new ALTER COLUMN id SET DEFAULT nextval('public.new_id_seq'::regclass);

ALTER TABLE ONLY public.used ALTER COLUMN id SET DEFAULT nextval('public.used_id_seq'::regclass);

COPY public.new (id, name, year, price) FROM stdin;
\.

COPY public.used (id, name, year, price) FROM stdin;
\.

SELECT pg_catalog.setval('public.new_id_seq', 1, false);

SELECT pg_catalog.setval('public.used_id_seq', 1, false);

ALTER TABLE ONLY public.new
    ADD CONSTRAINT new_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.used
    ADD CONSTRAINT used_pkey PRIMARY KEY (id);
