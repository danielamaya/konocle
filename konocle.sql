--
-- PostgreSQL database dump
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


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


SET search_path = public, pg_catalog;

--
-- Name: request_post_comments_parent_path(); Type: FUNCTION; Schema: public; Owner: konocle
--

CREATE FUNCTION request_post_comments_parent_path() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        path ltree;
    BEGIN
        IF NEW.parent_id IS NULL THEN
            NEW.parent_path = 'root'::ltree;
        ELSEIF TG_OP = 'INSERT' OR OLD.parent_id IS NULL OR OLD.parent_id != NEW.parent_id THEN
            SELECT parent_path || id::text FROM request_comments WHERE id = NEW.parent_id INTO path;
            IF path IS NULL THEN
                RAISE EXCEPTION 'Invalid parent_id %', NEW.parent_id;
            END IF;
            NEW.parent_path = path;
        END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.request_post_comments_parent_path() OWNER TO konocle;

--
-- Name: update_categories_parent_path(); Type: FUNCTION; Schema: public; Owner: konocle
--

CREATE FUNCTION update_categories_parent_path() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        path ltree;
    BEGIN
        IF NEW.parent_id IS NULL THEN
            NEW.parent_path = 'root'::ltree;
        ELSEIF TG_OP = 'INSERT' OR OLD.parent_id IS NULL OR OLD.parent_id != NEW.parent_id THEN
            SELECT parent_path || category_id::text FROM categories WHERE category_id = NEW.parent_id INTO path;
            IF path IS NULL THEN
                RAISE EXCEPTION 'Invalid parent_id %', NEW.parent_id;
            END IF;
            NEW.parent_path = path;
        END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_categories_parent_path() OWNER TO konocle;

--
-- Name: update_post_comments_parent_path(); Type: FUNCTION; Schema: public; Owner: konocle
--

CREATE FUNCTION update_post_comments_parent_path() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        path ltree;
    BEGIN
        IF NEW.parent_id IS NULL THEN
            NEW.parent_path = 'root'::ltree;
        ELSEIF TG_OP = 'INSERT' OR OLD.parent_id IS NULL OR OLD.parent_id != NEW.parent_id THEN
            SELECT parent_path || id::text FROM post_comments WHERE id = NEW.parent_id INTO path;
            IF path IS NULL THEN
                RAISE EXCEPTION 'Invalid parent_id %', NEW.parent_id;
            END IF;
            NEW.parent_path = path;
        END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_post_comments_parent_path() OWNER TO konocle;

--
-- Name: update_posts_parent_path(); Type: FUNCTION; Schema: public; Owner: konocle
--

CREATE FUNCTION update_posts_parent_path() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        path ltree;
    BEGIN
        IF NEW.parent_id IS NULL THEN
            NEW.parent_path = 'root'::ltree;
        ELSEIF TG_OP = 'INSERT' OR OLD.parent_id IS NULL OR OLD.parent_id != NEW.parent_id THEN
            SELECT parent_path || id::text FROM posts WHERE id = NEW.parent_id INTO path;
            IF path IS NULL THEN
                RAISE EXCEPTION 'Invalid parent_id %', NEW.parent_id;
            END IF;
            NEW.parent_path = path;
        END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_posts_parent_path() OWNER TO konocle;

--
-- Name: update_url_comments_parent_path(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_url_comments_parent_path() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        path ltree;
    BEGIN
        IF NEW.parent_id IS NULL THEN
            NEW.parent_path = 'root'::ltree;
        ELSEIF TG_OP = 'INSERT' OR OLD.parent_id IS NULL OR OLD.parent_id != NEW.parent_id THEN
            SELECT parent_path || id::text FROM url_comments WHERE id = NEW.parent_id INTO path;
            IF path IS NULL THEN
                RAISE EXCEPTION 'Invalid parent_id %', NEW.parent_id;
            END IF;
            NEW.parent_path = path;
        END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_url_comments_parent_path() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE categories (
    category_id integer NOT NULL,
    name character varying(250) NOT NULL,
    description character varying(250),
    wiki text,
    parent_id integer,
    parent_path ltree
);


ALTER TABLE public.categories OWNER TO konocle;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO konocle;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.category_id;


--
-- Name: post_categories; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE post_categories (
    post_id bigint NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.post_categories OWNER TO konocle;

--
-- Name: post_categories_post_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE post_categories_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_categories_post_id_seq OWNER TO konocle;

--
-- Name: post_categories_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE post_categories_post_id_seq OWNED BY post_categories.post_id;


--
-- Name: post_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE post_comments (
    comment_id bigint NOT NULL,
    post_id integer NOT NULL,
    comment_body text NOT NULL,
    hearts integer DEFAULT 0 NOT NULL,
    spam integer DEFAULT 0 NOT NULL,
    parent_id integer,
    parent_path ltree,
    date_created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.post_comments OWNER TO konocle;

--
-- Name: post_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE post_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_comments_id_seq OWNER TO konocle;

--
-- Name: post_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE post_comments_id_seq OWNED BY post_comments.comment_id;


--
-- Name: post_tags; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE post_tags (
    post_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.post_tags OWNER TO konocle;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE posts (
    post_id bigint NOT NULL,
    title character varying(80) NOT NULL,
    description character varying(200) NOT NULL,
    post_body text NOT NULL,
    hearts bigint DEFAULT 0 NOT NULL,
    spam bigint DEFAULT 0 NOT NULL,
    miscategorized bigint DEFAULT 0 NOT NULL,
    submitted_by bigint NOT NULL,
    edited_by bigint,
    parent_id integer,
    parent_path ltree,
    created_date timestamp with time zone DEFAULT now() NOT NULL,
    edited_date timestamp with time zone
);


ALTER TABLE public.posts OWNER TO konocle;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO konocle;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.post_id;


--
-- Name: request_categories; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE request_categories (
    request_id bigint NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.request_categories OWNER TO konocle;

--
-- Name: request_categories_request_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE request_categories_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.request_categories_request_id_seq OWNER TO konocle;

--
-- Name: request_categories_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE request_categories_request_id_seq OWNED BY request_categories.request_id;


--
-- Name: request_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE request_comments (
    comment_id bigint NOT NULL,
    request_id integer NOT NULL,
    comment_body text NOT NULL,
    hearts integer DEFAULT 0 NOT NULL,
    spam integer DEFAULT 0 NOT NULL,
    parent_id integer,
    parent_path ltree,
    date_created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.request_comments OWNER TO konocle;

--
-- Name: request_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE request_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.request_comments_id_seq OWNER TO konocle;

--
-- Name: request_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE request_comments_id_seq OWNED BY request_comments.comment_id;


--
-- Name: request_tags; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE request_tags (
    request_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.request_tags OWNER TO konocle;

--
-- Name: requests; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE requests (
    request_id bigint NOT NULL,
    title character varying(80) NOT NULL,
    description character varying(250) NOT NULL,
    body text,
    hearts integer DEFAULT 0 NOT NULL,
    spam integer DEFAULT 0 NOT NULL,
    miscategorized integer DEFAULT 0 NOT NULL,
    fulfilled smallint DEFAULT 0 NOT NULL,
    submitted_by bigint NOT NULL,
    date_created timestamp with time zone DEFAULT now() NOT NULL
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
    description character varying(80),
    count integer DEFAULT 0 NOT NULL,
    date_created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tags OWNER TO konocle;

--
-- Name: tags_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE tags_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_tag_id_seq OWNER TO konocle;

--
-- Name: tags_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE tags_tag_id_seq OWNED BY tags.tag_id;


--
-- Name: url_categories; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE url_categories (
    url_id bigint NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.url_categories OWNER TO konocle;

--
-- Name: url_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE url_comments (
    comment_id bigint NOT NULL,
    url_id bigint NOT NULL,
    comment_body text NOT NULL,
    hearts integer DEFAULT 0 NOT NULL,
    spam integer DEFAULT 0 NOT NULL,
    parent_id integer,
    parent_path ltree,
    date_created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.url_comments OWNER TO konocle;

--
-- Name: url_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE url_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.url_comments_id_seq OWNER TO konocle;

--
-- Name: url_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE url_comments_id_seq OWNED BY url_comments.comment_id;


--
-- Name: url_tags; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE url_tags (
    url_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.url_tags OWNER TO konocle;

--
-- Name: urls; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE urls (
    url_id bigint NOT NULL,
    title character varying(80) NOT NULL,
    address character varying(2500) NOT NULL,
    description character varying(200) NOT NULL,
    hearts integer DEFAULT 0 NOT NULL,
    spam integer DEFAULT 0 NOT NULL,
    broken integer DEFAULT 0 NOT NULL,
    miscategorized integer DEFAULT 0 NOT NULL,
    submitted_by bigint NOT NULL,
    edited_by bigint,
    date_created timestamp with time zone DEFAULT now() NOT NULL,
    date_edited timestamp with time zone
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
-- Name: user_categories; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_categories (
    user_id bigint NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.user_categories OWNER TO konocle;

--
-- Name: user_loved_post_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_loved_post_comments (
    user_id bigint NOT NULL,
    comment_id bigint NOT NULL,
    ip_addr character varying(64) NOT NULL,
    date_loved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_loved_post_comments OWNER TO konocle;

--
-- Name: user_loved_posts; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_loved_posts (
    user_id bigint NOT NULL,
    post_id bigint NOT NULL,
    ip_addr character varying(64) NOT NULL,
    date_loved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_loved_posts OWNER TO konocle;

--
-- Name: user_loved_request_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_loved_request_comments (
    user_id bigint NOT NULL,
    comment_id bigint NOT NULL,
    ip_addr character varying(64) NOT NULL,
    date_loved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_loved_request_comments OWNER TO konocle;

--
-- Name: user_loved_requests; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_loved_requests (
    user_id bigint NOT NULL,
    request_id bigint NOT NULL,
    ip_addr character varying(64) NOT NULL,
    date_loved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_loved_requests OWNER TO konocle;

--
-- Name: user_loved_url_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_loved_url_comments (
    user_id bigint NOT NULL,
    comment_id bigint NOT NULL,
    ip_addr character varying(64) NOT NULL,
    date_loved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_loved_url_comments OWNER TO konocle;

--
-- Name: user_loved_urls; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_loved_urls (
    user_id bigint NOT NULL,
    url_id bigint NOT NULL,
    ip_addr character varying(64) NOT NULL,
    date_loved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_loved_urls OWNER TO konocle;

--
-- Name: user_saved_post_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_saved_post_comments (
    user_id bigint NOT NULL,
    comment_id bigint NOT NULL,
    date_saved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_saved_post_comments OWNER TO konocle;

--
-- Name: user_saved_posts; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_saved_posts (
    user_id bigint NOT NULL,
    post_id bigint NOT NULL,
    date_saved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_saved_posts OWNER TO konocle;

--
-- Name: user_saved_request_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_saved_request_comments (
    user_id bigint NOT NULL,
    comment_id bigint NOT NULL,
    date_saved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_saved_request_comments OWNER TO konocle;

--
-- Name: user_saved_requests; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_saved_requests (
    user_id bigint NOT NULL,
    request_id bigint NOT NULL,
    date_saved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_saved_requests OWNER TO konocle;

--
-- Name: user_saved_url_comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_saved_url_comments (
    user_id bigint NOT NULL,
    comment_id bigint NOT NULL,
    date_saved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_saved_url_comments OWNER TO konocle;

--
-- Name: user_saved_urls; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_saved_urls (
    user_id bigint NOT NULL,
    url_id bigint NOT NULL,
    date_saved timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_saved_urls OWNER TO konocle;

--
-- Name: user_tags; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE user_tags (
    user_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.user_tags OWNER TO konocle;

--
-- Name: users; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users (
    user_id bigint NOT NULL,
    login character varying(20) NOT NULL,
    passwd character varying(256) NOT NULL,
    email character varying(256),
    urls_loved integer DEFAULT 0 NOT NULL,
    posts_loved integer DEFAULT 0 NOT NULL,
    requests_loved integer DEFAULT 0 NOT NULL,
    comments_loved integer DEFAULT 0 NOT NULL,
    spam_count integer DEFAULT 0 NOT NULL,
    date_created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO konocle;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO konocle;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: category_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: post_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY post_categories ALTER COLUMN post_id SET DEFAULT nextval('post_categories_post_id_seq'::regclass);


--
-- Name: request_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY request_categories ALTER COLUMN request_id SET DEFAULT nextval('request_categories_request_id_seq'::regclass);


--
-- Name: request_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY requests ALTER COLUMN request_id SET DEFAULT nextval('requests_request_id_seq'::regclass);


--
-- Name: tag_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags ALTER COLUMN tag_id SET DEFAULT nextval('tags_tag_id_seq'::regclass);


--
-- Name: url_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY urls ALTER COLUMN url_id SET DEFAULT nextval('urls_url_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: post_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY post_comments
    ADD CONSTRAINT post_comments_pkey PRIMARY KEY (comment_id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


--
-- Name: request_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY request_comments
    ADD CONSTRAINT request_comments_pkey PRIMARY KEY (comment_id);


--
-- Name: requests_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (request_id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: url_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY url_comments
    ADD CONSTRAINT url_comments_pkey PRIMARY KEY (comment_id);


--
-- Name: urls_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_pkey PRIMARY KEY (url_id);


--
-- Name: user_loved_posts_user_id_post_id_ip_addr_key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY user_loved_posts
    ADD CONSTRAINT user_loved_posts_user_id_post_id_ip_addr_key UNIQUE (user_id, post_id, ip_addr);


--
-- Name: user_loved_requests_user_id_request_id_ip_addr_key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY user_loved_requests
    ADD CONSTRAINT user_loved_requests_user_id_request_id_ip_addr_key UNIQUE (user_id, request_id, ip_addr);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: category_parent_id_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX category_parent_id_idx ON categories USING btree (parent_id);


--
-- Name: category_parent_path_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX category_parent_path_idx ON categories USING gist (parent_path);


--
-- Name: post_comments_parent_id_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX post_comments_parent_id_idx ON post_comments USING btree (parent_id);


--
-- Name: post_comments_parent_path_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX post_comments_parent_path_idx ON post_comments USING gist (parent_path);


--
-- Name: posts_parent_id_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX posts_parent_id_idx ON posts USING btree (parent_id);


--
-- Name: posts_parent_path_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX posts_parent_path_idx ON posts USING gist (parent_path);


--
-- Name: request_comments_parent_path_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX request_comments_parent_path_idx ON request_comments USING gist (parent_path);


--
-- Name: requests_comments_parent_id_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX requests_comments_parent_id_idx ON request_comments USING btree (parent_id);


--
-- Name: url_comments_parent_id_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX url_comments_parent_id_idx ON url_comments USING btree (parent_id);


--
-- Name: url_comments_parent_path_idx; Type: INDEX; Schema: public; Owner: konocle; Tablespace: 
--

CREATE INDEX url_comments_parent_path_idx ON url_comments USING gist (parent_path);


--
-- Name: categories_parent_path_tgr; Type: TRIGGER; Schema: public; Owner: konocle
--

CREATE TRIGGER categories_parent_path_tgr BEFORE INSERT OR UPDATE ON categories FOR EACH ROW EXECUTE PROCEDURE update_categories_parent_path();


--
-- Name: post_comments_parent_path_tgr; Type: TRIGGER; Schema: public; Owner: konocle
--

CREATE TRIGGER post_comments_parent_path_tgr BEFORE INSERT OR UPDATE ON post_comments FOR EACH ROW EXECUTE PROCEDURE update_post_comments_parent_path();


--
-- Name: posts_parent_path_tgr; Type: TRIGGER; Schema: public; Owner: konocle
--

CREATE TRIGGER posts_parent_path_tgr BEFORE INSERT OR UPDATE ON posts FOR EACH ROW EXECUTE PROCEDURE update_posts_parent_path();


--
-- Name: url_comments_parent_path_tgr; Type: TRIGGER; Schema: public; Owner: konocle
--

CREATE TRIGGER url_comments_parent_path_tgr BEFORE INSERT OR UPDATE ON url_comments FOR EACH ROW EXECUTE PROCEDURE update_url_comments_parent_path();


--
-- Name: categories_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES categories(category_id);


--
-- Name: post id; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY post_comments
    ADD CONSTRAINT "post id" FOREIGN KEY (post_id) REFERENCES posts(post_id);


--
-- Name: post_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY post_categories
    ADD CONSTRAINT post_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(category_id);


--
-- Name: post_categories_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY post_categories
    ADD CONSTRAINT post_categories_post_id_fkey FOREIGN KEY (post_id) REFERENCES posts(post_id);


--
-- Name: post_comments_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY post_comments
    ADD CONSTRAINT post_comments_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES post_comments(comment_id);


--
-- Name: post_tags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY post_tags
    ADD CONSTRAINT post_tags_post_id_fkey FOREIGN KEY (post_id) REFERENCES posts(post_id);


--
-- Name: post_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY post_tags
    ADD CONSTRAINT post_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(tag_id);


--
-- Name: posts edited by; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT "posts edited by" FOREIGN KEY (edited_by) REFERENCES users(user_id);


--
-- Name: posts submitted by; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT "posts submitted by" FOREIGN KEY (submitted_by) REFERENCES users(user_id);


--
-- Name: posts_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES posts(post_id);


--
-- Name: request id; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY request_comments
    ADD CONSTRAINT "request id" FOREIGN KEY (request_id) REFERENCES requests(request_id);


--
-- Name: request_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY request_categories
    ADD CONSTRAINT request_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(category_id);


--
-- Name: request_categories_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY request_categories
    ADD CONSTRAINT request_categories_request_id_fkey FOREIGN KEY (request_id) REFERENCES requests(request_id);


--
-- Name: request_comments_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY request_comments
    ADD CONSTRAINT request_comments_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES request_comments(comment_id);


--
-- Name: request_tags_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY request_tags
    ADD CONSTRAINT request_tags_request_id_fkey FOREIGN KEY (request_id) REFERENCES requests(request_id);


--
-- Name: request_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY request_tags
    ADD CONSTRAINT request_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(tag_id);


--
-- Name: requests_submitted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_submitted_by_fkey FOREIGN KEY (submitted_by) REFERENCES users(user_id);


--
-- Name: url id; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY url_comments
    ADD CONSTRAINT "url id" FOREIGN KEY (url_id) REFERENCES urls(url_id);


--
-- Name: url_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY url_categories
    ADD CONSTRAINT url_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(category_id);


--
-- Name: url_categories_url_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY url_categories
    ADD CONSTRAINT url_categories_url_id_fkey FOREIGN KEY (url_id) REFERENCES urls(url_id);


--
-- Name: url_comments_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY url_comments
    ADD CONSTRAINT url_comments_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES url_comments(comment_id);


--
-- Name: url_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY url_tags
    ADD CONSTRAINT url_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags(tag_id);


--
-- Name: url_tags_url_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY url_tags
    ADD CONSTRAINT url_tags_url_id_fkey FOREIGN KEY (url_id) REFERENCES urls(url_id);


--
-- Name: urls_edited_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_edited_by_fkey FOREIGN KEY (edited_by) REFERENCES users(user_id);


--
-- Name: urls_submitted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_submitted_by_fkey FOREIGN KEY (submitted_by) REFERENCES users(user_id);


--
-- Name: user_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_categories
    ADD CONSTRAINT user_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(category_id);


--
-- Name: user_categories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_categories
    ADD CONSTRAINT user_categories_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_loved_post_comments_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_post_comments
    ADD CONSTRAINT user_loved_post_comments_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES post_comments(comment_id);


--
-- Name: user_loved_post_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_post_comments
    ADD CONSTRAINT user_loved_post_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_loved_posts_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_posts
    ADD CONSTRAINT user_loved_posts_post_id_fkey FOREIGN KEY (post_id) REFERENCES posts(post_id);


--
-- Name: user_loved_posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_posts
    ADD CONSTRAINT user_loved_posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_loved_request_comments_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_request_comments
    ADD CONSTRAINT user_loved_request_comments_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES request_comments(comment_id);


--
-- Name: user_loved_request_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_request_comments
    ADD CONSTRAINT user_loved_request_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_loved_requests_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_requests
    ADD CONSTRAINT user_loved_requests_request_id_fkey FOREIGN KEY (request_id) REFERENCES requests(request_id);


--
-- Name: user_loved_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_requests
    ADD CONSTRAINT user_loved_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_loved_url_comments_url_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_url_comments
    ADD CONSTRAINT user_loved_url_comments_url_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES url_comments(comment_id);


--
-- Name: user_loved_url_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_url_comments
    ADD CONSTRAINT user_loved_url_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_loved_urls_url_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_urls
    ADD CONSTRAINT user_loved_urls_url_id_fkey FOREIGN KEY (url_id) REFERENCES urls(url_id);


--
-- Name: user_loved_urls_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_loved_urls
    ADD CONSTRAINT user_loved_urls_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_saved_post_comments_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_post_comments
    ADD CONSTRAINT user_saved_post_comments_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES post_comments(comment_id);


--
-- Name: user_saved_post_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_post_comments
    ADD CONSTRAINT user_saved_post_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_saved_posts_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_posts
    ADD CONSTRAINT user_saved_posts_post_id_fkey FOREIGN KEY (post_id) REFERENCES posts(post_id);


--
-- Name: user_saved_posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_posts
    ADD CONSTRAINT user_saved_posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_saved_request_comments_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_request_comments
    ADD CONSTRAINT user_saved_request_comments_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES request_comments(comment_id);


--
-- Name: user_saved_request_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_request_comments
    ADD CONSTRAINT user_saved_request_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_saved_requests_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_requests
    ADD CONSTRAINT user_saved_requests_request_id_fkey FOREIGN KEY (request_id) REFERENCES requests(request_id);


--
-- Name: user_saved_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_requests
    ADD CONSTRAINT user_saved_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_saved_url_comments_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_url_comments
    ADD CONSTRAINT user_saved_url_comments_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES url_comments(comment_id);


--
-- Name: user_saved_url_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_url_comments
    ADD CONSTRAINT user_saved_url_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_saved_urls_url_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_urls
    ADD CONSTRAINT user_saved_urls_url_id_fkey FOREIGN KEY (url_id) REFERENCES urls(url_id);


--
-- Name: user_saved_urls_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY user_saved_urls
    ADD CONSTRAINT user_saved_urls_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

