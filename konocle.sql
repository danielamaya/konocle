--
-- PostgreSQL database dump unf
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
CREATE EXTENSION ltree;

--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: users; Type: TABLE; Schema: public; Owner: konocle; Tablespace:
--

CREATE TABLE users (
    user_id BIGINT NOT NULL,
    login character varying(20) NOT NULL,
    passwd character varying(256) NOT NULL,
    email character varying(256),
    urls_loved INTEGER DEFAULT 0 NOT NULL,
    posts_loved INTEGER DEFAULT 0 NOT NULL,
    requests_loved INTEGER DEFAULT 0 NOT NULL,
    comments_loved INTEGER DEFAULT 0 NOT NULL,
    spam_count INTEGER DEFAULT 0 NOT NULL,
    created_date timestamp with time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.users OWNER TO konocle;

--
-- Name: urls; Type: TABLE; Schema: public; Owner: konocle; Tablespace:
--

CREATE TABLE urls (
    url_id BIGINT NOT NULL,
    title character varying(80) NOT NULL,
    address character varying(2500) NOT NULL,
    description character varying(200) NOT NULL,
    hearts INTEGER DEFAULT 0 NOT NULL,
    spam INTEGER DEFAULT 0 NOT NULL,
    broken INTEGER DEFAULT 0 NOT NULL,
    miscategorized INTEGER DEFAULT 0 NOT NULL,
    submitted_by bigint NOT NULL,
    last_edited_by bigint,
    created_date timestamp with time zone DEFAULT now() NOT NULL,
    last_edited timestamp with time zone
);
ALTER TABLE public.urls OWNER TO konocle;

--
-- Name: urls_url_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE urls_url_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urls_url_id_seq OWNER TO konocle;

--
-- Name: urls_url_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE urls_url_id_seq OWNED BY urls.url_id;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: konocle; Tablespace:
--

CREATE TABLE posts (
    post_id bigint NOT NULL,
    title character varying(80) NOT NULL,
    description character varying(200) NOT NULL,
    post_text text NOT NULL,
    hearts bigint DEFAULT 0 NOT NULL,
    spam bigint DEFAULT 0 NOT NULL,
    miscategorized bigint DEFAULT 0 NOT NULL,
    submitted_by bigint NOT NULL,
    last_edited_by bigint,
    parent_id INTEGER REFERENCES posts,
    parent_path LTREE
    created_date timestamp with time zone DEFAULT now() NOT NULL,
    edited_date timestamp with time zone,
);


ALTER TABLE public.posts OWNER TO konocle;

--
-- Name: posts_post_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE posts_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_post_id_seq OWNER TO konocle;

--
-- Name: posts_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE posts_post_id_seq OWNED BY posts.post_id;

--
-- Name: requests; Type: TABLE; Schema: public; Owner: konocle; Tablespace:
--

CREATE TABLE requests (
    request_id BIGINT NOT NULL,
    title CHARACTER VARYING(80) NOT NULL,
    description CHARACTER VARYING(250) NOT NULL,
    request_text TEXT,
    hearts INTEGER DEFAULT 0 NOT NULL,
    spam INTEGER DEFAULT 0 NOT NULL,
    miscategorized INTEGER DEFAULT 0 NOT NULL,
    submitted_by integer NOT NULL,
    submitted_date timestamp with time zone DEFAULT now() NOT NULL,
);


ALTER TABLE public.requests OWNER TO konocle;

--
-- Name: requests_request_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE requests_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requests_request_id_seq OWNER TO konocle;

--
-- Name: requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE requests_request_id_seq OWNED BY requests.request_id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: konocle; Tablespace:
--

CREATE TABLE tags (
    tag_id bigint NOT NULL,
    name character varying(25) NOT NULL,
    description CHARACTER VARYING(250),
    wiki TEXT,
    count INTEGER DEFAULT 0 NOT NULL,
    created_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tags OWNER TO konocle;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: konocle; Tablespace:
--

CREATE TABLE categories(
    category_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description CHARACTER VARYING(250),
    parent_id INTEGER REFERENCES categories,
    parent_path LTREE
);

CREATE INDEX category_parent_path_idx ON categories USING GIST (parent_path);
CREATE INDEX category_parent_id_idx ON categories (parent_id);

CREATE OR REPLACE FUNCTION update_categories_parent_path() RETURNS TRIGGER AS $$
    DECLARE
        path ltree;
    BEGIN
        IF NEW.category_parent_id IS NULL THEN
            NEW.category_parent_path = 'root'::ltree;
        ELSEIF TG_OP = 'INSERT' OR OLD.category_parent_id IS NULL OR OLD.category_parent_id != NEW.category_parent_id THEN
            SELECT category_parent_path || id::text FROM section WHERE id = NEW.category_parent_id INTO path;
            IF path IS NULL THEN
                RAISE EXCEPTION 'Invalid parent_id %', NEW.parent_id;
            END IF;
            NEW.category_parent_path = path;
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER parent_path_tgr
    BEFORE INSERT OR UPDATE ON categories
    FOR EACH ROW EXECUTE PROCEDURE update_categories_parent_path();

ALTER TABLE public.categories OWNER TO konocle;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO konocle;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE categories_category_id_seq OWNED BY categories.category_id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace:
--

CREATE TABLE url_comments(
    comment_id INTEGER PRIMARY KEY,
    comment_url_id INTEGER NOT NULL,
    comment_text TEXT NOT NULL,
    comment_hearts INTEGER DEFAULT 0 NOT NULL,
    comment_spam INTEGER DEFAULT 0 NOT NULL,
    comment_parent_id INTEGER REFERENCES comments,
    comment_parent_path LTREE,
    comment_timestamp TIMESTAMP WITH TIMEZONE DEFAULT now() NOT NULL
);

CREATE INDEX category_parent_path_idx ON categories USING GIST (category_parent_path);
CREATE INDEX category_parent_id_idx ON categories (category_parent_id);

CREATE OR REPLACE FUNCTION update_categories_parent_path() RETURNS TRIGGER AS $$
    DECLARE
        path ltree;
    BEGIN
        IF NEW.category_parent_id IS NULL THEN
            NEW.category_parent_path = 'root'::ltree;
        ELSEIF TG_OP = 'INSERT' OR OLD.category_parent_id IS NULL OR OLD.category_parent_id != NEW.category_parent_id THEN
            SELECT category_parent_path || id::text FROM section WHERE id = NEW.category_parent_id INTO path;
            IF path IS NULL THEN
                RAISE EXCEPTION 'Invalid parent_id %', NEW.parent_id;
            END IF;
            NEW.category_parent_path = path;
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER parent_path_tgr
    BEFORE INSERT OR UPDATE ON categories
    FOR EACH ROW EXECUTE PROCEDURE update_categories_parent_path();

ALTER TABLE public.categories OWNER TO konocle;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO konocle;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE categories_category_id_seq OWNED BY categories.category_id;

CREATE TABLE user_preferences (
    preference_id BIGINT NOT NULL,
    preference_user_id BIGINT NOT NULL,
    preference_comments_public INTEGER DEFAULT 1 NOT NULL,
    preference_saved_public INTEGER DEFAULT 1 NOT NULL,
    preference_hearts_public INTEGER DEFAULT 1 NOT NULL,
    preference_sfw INTEGER DEFAULT 1 NOT NULL,
    preference_over_18 INTEGER DEFAULT 0 NOT NULL,
    preference_display_results INTEGER DEFAULT 25 NOT NULL,
    preference_language CHARACTER VARYING(5) DEFAULT 'en' NOT NULL
);
ALTER TABLE public.users OWNER TO konocle;
ALTER TABLE ONLY user_settings
    ADD CONSTRAINT "setting_user_id users fkey" FOREIGN KEY (preference_user_id) REFERENCES users(user_id);


