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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE categories (
    category_id bigint NOT NULL,
    category_name character varying(50) NOT NULL,
    category_created_date timestamp with time zone DEFAULT now() NOT NULL
);


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
-- Name: categories_disciplines; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE categories_disciplines (
    categories_disciplines_id bigint NOT NULL,
    categories_disciplines_category_id bigint NOT NULL,
    categories_disciplines_discipline_id bigint NOT NULL,
    categories_disciplines_created_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories_disciplines OWNER TO konocle;

--
-- Name: categories_disciplines_categories_disciplines_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE categories_disciplines_categories_disciplines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_disciplines_categories_disciplines_id_seq OWNER TO konocle;

--
-- Name: categories_disciplines_categories_disciplines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE categories_disciplines_categories_disciplines_id_seq OWNED BY categories_disciplines.categories_disciplines_id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE comments (
    comment_id bigint NOT NULL,
    comment_url_id bigint NOT NULL,
    comment_user_id bigint NOT NULL,
    comment_parent_id bigint,
    comment_text text NOT NULL,
    comment_hearts bigint DEFAULT 0 NOT NULL,
    comment_spam bigint DEFAULT 0 NOT NULL,
    comment_created_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comments OWNER TO konocle;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE comments_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_comment_id_seq OWNER TO konocle;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE comments_comment_id_seq OWNED BY comments.comment_id;


--
-- Name: disciplines; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE disciplines (
    discipline_id bigint NOT NULL,
    discipline_name character varying(100) NOT NULL,
    discipline_created_date timestamp with time zone DEFAULT now() NOT NULL,
    discipline_description text
);


ALTER TABLE public.disciplines OWNER TO konocle;

--
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE disciplines_discipline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disciplines_discipline_id_seq OWNER TO konocle;

--
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE disciplines_discipline_id_seq OWNED BY disciplines.discipline_id;


--
-- Name: disciplines_posts; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE disciplines_posts (
    disciplines_posts_id bigint NOT NULL,
    disciplines_posts_post_id bigint NOT NULL,
    disciplines_posts_discipline_id bigint NOT NULL
);


ALTER TABLE public.disciplines_posts OWNER TO konocle;

--
-- Name: disciplines_posts_disciplines_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE disciplines_posts_disciplines_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disciplines_posts_disciplines_posts_id_seq OWNER TO konocle;

--
-- Name: disciplines_posts_disciplines_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE disciplines_posts_disciplines_posts_id_seq OWNED BY disciplines_posts.disciplines_posts_id;


--
-- Name: disciplines_requests; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE disciplines_requests (
    disciplines_requests_id bigint NOT NULL,
    disciplines_requests_request_id bigint NOT NULL,
    disciplines_requests_discipline_id bigint NOT NULL
);


ALTER TABLE public.disciplines_requests OWNER TO konocle;

--
-- Name: disciplines_requests_disciplines_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE disciplines_requests_disciplines_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disciplines_requests_disciplines_requests_id_seq OWNER TO konocle;

--
-- Name: disciplines_requests_disciplines_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE disciplines_requests_disciplines_requests_id_seq OWNED BY disciplines_requests.disciplines_requests_id;


--
-- Name: disciplines_to_parents; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE disciplines_to_parents (
    disciplines_to_parents_id bigint NOT NULL,
    disciplines_to_parents_parent_id bigint NOT NULL,
    disciplines_to_parents_child_id bigint NOT NULL
);


ALTER TABLE public.disciplines_to_parents OWNER TO konocle;

--
-- Name: disciplines_to_parents_disciplines_to_parents_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE disciplines_to_parents_disciplines_to_parents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disciplines_to_parents_disciplines_to_parents_id_seq OWNER TO konocle;

--
-- Name: disciplines_to_parents_disciplines_to_parents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE disciplines_to_parents_disciplines_to_parents_id_seq OWNED BY disciplines_to_parents.disciplines_to_parents_id;


--
-- Name: disciplines_urls; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE disciplines_urls (
    disciplines_urls_id bigint NOT NULL,
    disciplines_urls_url_id bigint NOT NULL,
    disciplines_urls_discipline_id bigint NOT NULL
);


ALTER TABLE public.disciplines_urls OWNER TO konocle;

--
-- Name: disciplines_urls_disciplines_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE disciplines_urls_disciplines_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disciplines_urls_disciplines_urls_id_seq OWNER TO konocle;

--
-- Name: disciplines_urls_disciplines_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE disciplines_urls_disciplines_urls_id_seq OWNED BY disciplines_urls.disciplines_urls_id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE posts (
    post_id bigint NOT NULL,
    post_title character varying(80) NOT NULL,
    post_description character varying(200) NOT NULL,
    post_text text NOT NULL,
    post_hearts bigint DEFAULT 0 NOT NULL,
    post_spam bigint DEFAULT 0 NOT NULL,
    post_miscategorized bigint DEFAULT 0 NOT NULL,
    post_created_date timestamp with time zone DEFAULT now() NOT NULL,
    post_edited_date timestamp with time zone,
    post_submitted_by bigint NOT NULL,
    post_last_edited_by bigint,
    post_parent_id bigint
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
    request_title character varying(80) NOT NULL,
    request_desc character varying(250) NOT NULL,
    request_submitted_by integer NOT NULL,
    request_submitted_date timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint NOT NULL
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
    tag_name character varying(25) NOT NULL,
    tag_description text,
    tag_count bigint DEFAULT 0 NOT NULL,
    tag_created_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tags OWNER TO konocle;

--
-- Name: tags_disciplines; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE tags_disciplines (
    tags_disciplines_id bigint NOT NULL,
    tags_disciplines_discipline_id bigint,
    tags_disciplines_tag_id bigint NOT NULL
);


ALTER TABLE public.tags_disciplines OWNER TO konocle;

--
-- Name: tags_disciplines_tags_disciplines_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE tags_disciplines_tags_disciplines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_disciplines_tags_disciplines_id_seq OWNER TO konocle;

--
-- Name: tags_disciplines_tags_disciplines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE tags_disciplines_tags_disciplines_id_seq OWNED BY tags_disciplines.tags_disciplines_id;


--
-- Name: tags_posts; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE tags_posts (
    tags_posts_id bigint NOT NULL,
    tags_posts_post_id bigint NOT NULL,
    tags_posts_tag_id bigint NOT NULL
);


ALTER TABLE public.tags_posts OWNER TO konocle;

--
-- Name: tags_posts_tags_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE tags_posts_tags_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_posts_tags_posts_id_seq OWNER TO konocle;

--
-- Name: tags_posts_tags_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE tags_posts_tags_posts_id_seq OWNED BY tags_posts.tags_posts_id;


--
-- Name: tags_requests; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE tags_requests (
    tags_requests_id bigint NOT NULL,
    tags_requests_request_id bigint NOT NULL,
    tags_requests_tag_id bigint NOT NULL
);


ALTER TABLE public.tags_requests OWNER TO konocle;

--
-- Name: tags_requests_tags_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE tags_requests_tags_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_requests_tags_requests_id_seq OWNER TO konocle;

--
-- Name: tags_requests_tags_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE tags_requests_tags_requests_id_seq OWNED BY tags_requests.tags_requests_id;


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
-- Name: tags_urls; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE tags_urls (
    tags_urls_id bigint NOT NULL,
    tags_urls_url_id bigint NOT NULL,
    tags_urls_tag_id bigint NOT NULL
);


ALTER TABLE public.tags_urls OWNER TO konocle;

--
-- Name: tags_urls_tags_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE tags_urls_tags_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_urls_tags_urls_id_seq OWNER TO konocle;

--
-- Name: tags_urls_tags_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE tags_urls_tags_urls_id_seq OWNED BY tags_urls.tags_urls_id;


--
-- Name: tags_users; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE tags_users (
    tags_users_id bigint NOT NULL,
    tags_users_user_id bigint NOT NULL,
    tags_users_tag_id bigint NOT NULL,
    tags_users_count bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.tags_users OWNER TO konocle;

--
-- Name: tags_users_tags_users_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE tags_users_tags_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_users_tags_users_id_seq OWNER TO konocle;

--
-- Name: tags_users_tags_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE tags_users_tags_users_id_seq OWNED BY tags_users.tags_users_id;


--
-- Name: urls; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE urls (
    url_id bigint NOT NULL,
    url_title character(80)[] NOT NULL,
    url_address character varying(2500) NOT NULL,
    url_description character varying(200) NOT NULL,
    url_hearts bigint DEFAULT 0 NOT NULL,
    url_spam bigint DEFAULT 0 NOT NULL,
    url_broken bigint DEFAULT 0 NOT NULL,
    url_miscategorized bigint DEFAULT 0 NOT NULL,
    url_created_date timestamp with time zone DEFAULT now() NOT NULL,
    url_last_edited timestamp with time zone,
    url_submitted_by bigint NOT NULL,
    url_last_edited_by bigint
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
-- Name: users; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users (
    user_id bigint NOT NULL,
    user_login character varying(20)[] NOT NULL,
    user_passwd character varying(256) NOT NULL,
    user_email character varying(254),
    user_created_date timestamp with time zone DEFAULT now() NOT NULL,
    user_urls_loved integer DEFAULT 0 NOT NULL,
    user_posts_loved integer DEFAULT 0 NOT NULL,
    user_comments_loved integer DEFAULT 0 NOT NULL,
    user_edits_loved integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO konocle;

--
-- Name: users_comments_loved; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_comments_loved (
    users_comments_loved_id bigint NOT NULL,
    users_comments_loved_user_id bigint NOT NULL,
    users_comments_loved_comment_id bigint NOT NULL,
    users_comments_loved_ip_addr character varying NOT NULL,
    users_comments_loved_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_comments_loved OWNER TO konocle;

--
-- Name: users_comments_loved_users_comments_loved_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_comments_loved_users_comments_loved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_comments_loved_users_comments_loved_id_seq OWNER TO konocle;

--
-- Name: users_comments_loved_users_comments_loved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_comments_loved_users_comments_loved_id_seq OWNED BY users_comments_loved.users_comments_loved_id;


--
-- Name: users_comments_saved; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_comments_saved (
    users_comments_saved_id bigint NOT NULL,
    users_comments_saved_user_id bigint NOT NULL,
    users_comments_saved_comment_id bigint NOT NULL,
    users_comments_saved_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_comments_saved OWNER TO konocle;

--
-- Name: users_comments_saved_users_comments_saved_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_comments_saved_users_comments_saved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_comments_saved_users_comments_saved_id_seq OWNER TO konocle;

--
-- Name: users_comments_saved_users_comments_saved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_comments_saved_users_comments_saved_id_seq OWNED BY users_comments_saved.users_comments_saved_id;


--
-- Name: users_disciplines; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_disciplines (
    users_disciplines_id bigint NOT NULL,
    users_disciplines_user_id bigint NOT NULL,
    users_disciplines_discipline_id bigint NOT NULL
);


ALTER TABLE public.users_disciplines OWNER TO konocle;

--
-- Name: users_disciplines_users_disciplines_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_disciplines_users_disciplines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_disciplines_users_disciplines_id_seq OWNER TO konocle;

--
-- Name: users_disciplines_users_disciplines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_disciplines_users_disciplines_id_seq OWNED BY users_disciplines.users_disciplines_id;


--
-- Name: users_posts_loved; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_posts_loved (
    users_posts_loved_id bigint NOT NULL,
    users_posts_loved_user_id bigint NOT NULL,
    users_posts_loved_post_id bigint NOT NULL,
    users_posts_loved_ip_addr character varying(256) NOT NULL,
    users_posts_loved_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_posts_loved OWNER TO konocle;

--
-- Name: users_posts_loved_users_posts_loved_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_posts_loved_users_posts_loved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_posts_loved_users_posts_loved_id_seq OWNER TO konocle;

--
-- Name: users_posts_loved_users_posts_loved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_posts_loved_users_posts_loved_id_seq OWNED BY users_posts_loved.users_posts_loved_id;


--
-- Name: users_posts_saved; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_posts_saved (
    users_posts_saved_id bigint NOT NULL,
    users_posts_saved_user_id bigint NOT NULL,
    users_posts_saved_post_id bigint NOT NULL,
    users_posts_saved_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_posts_saved OWNER TO konocle;

--
-- Name: users_posts_saved_users_posts_saved_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_posts_saved_users_posts_saved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_posts_saved_users_posts_saved_id_seq OWNER TO konocle;

--
-- Name: users_posts_saved_users_posts_saved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_posts_saved_users_posts_saved_id_seq OWNED BY users_posts_saved.users_posts_saved_id;


--
-- Name: users_requests_loved; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_requests_loved (
    users_requests_loved_id bigint NOT NULL,
    users_requests_loved_user_id bigint NOT NULL,
    users_requests_loved_request_id bigint NOT NULL,
    users_requests_loved_ip_addr character varying(256) NOT NULL,
    users_requests_loved_date time with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_requests_loved OWNER TO konocle;

--
-- Name: users_requests_loved_users_requests_loved_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_requests_loved_users_requests_loved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_requests_loved_users_requests_loved_id_seq OWNER TO konocle;

--
-- Name: users_requests_loved_users_requests_loved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_requests_loved_users_requests_loved_id_seq OWNED BY users_requests_loved.users_requests_loved_id;


--
-- Name: users_requests_loved_users_requests_loved_request_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_requests_loved_users_requests_loved_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_requests_loved_users_requests_loved_request_id_seq OWNER TO konocle;

--
-- Name: users_requests_loved_users_requests_loved_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_requests_loved_users_requests_loved_request_id_seq OWNED BY users_requests_loved.users_requests_loved_request_id;


--
-- Name: users_requests_saved; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_requests_saved (
    users_requests_saved_id bigint NOT NULL,
    users_requests_saved_user_id bigint NOT NULL,
    users_requests_saved_request_id bigint NOT NULL,
    users_requests_saved_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_requests_saved OWNER TO konocle;

--
-- Name: users_requests_saved_users_requests_saved_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_requests_saved_users_requests_saved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_requests_saved_users_requests_saved_id_seq OWNER TO konocle;

--
-- Name: users_requests_saved_users_requests_saved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_requests_saved_users_requests_saved_id_seq OWNED BY users_requests_saved.users_requests_saved_id;


--
-- Name: users_urls_loved; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_urls_loved (
    users_urls_loved_id bigint NOT NULL,
    users_urls_loved_user_id bigint NOT NULL,
    users_urls_loved_url_id bigint NOT NULL,
    users_urls_loved_ip_addr character varying NOT NULL,
    users_urls_loved_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_urls_loved OWNER TO konocle;

--
-- Name: users_urls_loved_users_urls_loved_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_urls_loved_users_urls_loved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_urls_loved_users_urls_loved_id_seq OWNER TO konocle;

--
-- Name: users_urls_loved_users_urls_loved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_urls_loved_users_urls_loved_id_seq OWNED BY users_urls_loved.users_urls_loved_id;


--
-- Name: users_urls_saved; Type: TABLE; Schema: public; Owner: konocle; Tablespace: 
--

CREATE TABLE users_urls_saved (
    users_urls_saved_id bigint NOT NULL,
    users_urls_saved_user_id bigint NOT NULL,
    users_urls_saved_url_id bigint NOT NULL,
    users_urls_saved_date timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_urls_saved OWNER TO konocle;

--
-- Name: users_urls_saved_users_urls_saved_id_seq; Type: SEQUENCE; Schema: public; Owner: konocle
--

CREATE SEQUENCE users_urls_saved_users_urls_saved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_urls_saved_users_urls_saved_id_seq OWNER TO konocle;

--
-- Name: users_urls_saved_users_urls_saved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE users_urls_saved_users_urls_saved_id_seq OWNED BY users_urls_saved.users_urls_saved_id;


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

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('categories_category_id_seq'::regclass);


--
-- Name: categories_disciplines_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY categories_disciplines ALTER COLUMN categories_disciplines_id SET DEFAULT nextval('categories_disciplines_categories_disciplines_id_seq'::regclass);


--
-- Name: comment_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY comments ALTER COLUMN comment_id SET DEFAULT nextval('comments_comment_id_seq'::regclass);


--
-- Name: discipline_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines ALTER COLUMN discipline_id SET DEFAULT nextval('disciplines_discipline_id_seq'::regclass);


--
-- Name: disciplines_posts_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_posts ALTER COLUMN disciplines_posts_id SET DEFAULT nextval('disciplines_posts_disciplines_posts_id_seq'::regclass);


--
-- Name: disciplines_requests_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_requests ALTER COLUMN disciplines_requests_id SET DEFAULT nextval('disciplines_requests_disciplines_requests_id_seq'::regclass);


--
-- Name: disciplines_to_parents_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_to_parents ALTER COLUMN disciplines_to_parents_id SET DEFAULT nextval('disciplines_to_parents_disciplines_to_parents_id_seq'::regclass);


--
-- Name: disciplines_urls_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_urls ALTER COLUMN disciplines_urls_id SET DEFAULT nextval('disciplines_urls_disciplines_urls_id_seq'::regclass);


--
-- Name: post_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY posts ALTER COLUMN post_id SET DEFAULT nextval('posts_post_id_seq'::regclass);


--
-- Name: request_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY requests ALTER COLUMN request_id SET DEFAULT nextval('requests_request_id_seq'::regclass);


--
-- Name: tag_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags ALTER COLUMN tag_id SET DEFAULT nextval('tags_tag_id_seq'::regclass);


--
-- Name: tags_disciplines_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_disciplines ALTER COLUMN tags_disciplines_id SET DEFAULT nextval('tags_disciplines_tags_disciplines_id_seq'::regclass);


--
-- Name: tags_posts_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_posts ALTER COLUMN tags_posts_id SET DEFAULT nextval('tags_posts_tags_posts_id_seq'::regclass);


--
-- Name: tags_requests_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_requests ALTER COLUMN tags_requests_id SET DEFAULT nextval('tags_requests_tags_requests_id_seq'::regclass);


--
-- Name: tags_urls_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_urls ALTER COLUMN tags_urls_id SET DEFAULT nextval('tags_urls_tags_urls_id_seq'::regclass);


--
-- Name: tags_users_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_users ALTER COLUMN tags_users_id SET DEFAULT nextval('tags_users_tags_users_id_seq'::regclass);


--
-- Name: url_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY urls ALTER COLUMN url_id SET DEFAULT nextval('urls_url_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: users_comments_loved_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_comments_loved ALTER COLUMN users_comments_loved_id SET DEFAULT nextval('users_comments_loved_users_comments_loved_id_seq'::regclass);


--
-- Name: users_comments_saved_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_comments_saved ALTER COLUMN users_comments_saved_id SET DEFAULT nextval('users_comments_saved_users_comments_saved_id_seq'::regclass);


--
-- Name: users_disciplines_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_disciplines ALTER COLUMN users_disciplines_id SET DEFAULT nextval('users_disciplines_users_disciplines_id_seq'::regclass);


--
-- Name: users_posts_loved_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_posts_loved ALTER COLUMN users_posts_loved_id SET DEFAULT nextval('users_posts_loved_users_posts_loved_id_seq'::regclass);


--
-- Name: users_posts_saved_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_posts_saved ALTER COLUMN users_posts_saved_id SET DEFAULT nextval('users_posts_saved_users_posts_saved_id_seq'::regclass);


--
-- Name: users_requests_loved_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_requests_loved ALTER COLUMN users_requests_loved_id SET DEFAULT nextval('users_requests_loved_users_requests_loved_id_seq'::regclass);


--
-- Name: users_requests_loved_request_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_requests_loved ALTER COLUMN users_requests_loved_request_id SET DEFAULT nextval('users_requests_loved_users_requests_loved_request_id_seq'::regclass);


--
-- Name: users_requests_saved_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_requests_saved ALTER COLUMN users_requests_saved_id SET DEFAULT nextval('users_requests_saved_users_requests_saved_id_seq'::regclass);


--
-- Name: users_urls_loved_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_urls_loved ALTER COLUMN users_urls_loved_id SET DEFAULT nextval('users_urls_loved_users_urls_loved_id_seq'::regclass);


--
-- Name: users_urls_saved_id; Type: DEFAULT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_urls_saved ALTER COLUMN users_urls_saved_id SET DEFAULT nextval('users_urls_saved_users_urls_saved_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY categories (category_id, category_name, category_created_date) FROM stdin;
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('categories_category_id_seq', 1, false);


--
-- Data for Name: categories_disciplines; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY categories_disciplines (categories_disciplines_id, categories_disciplines_category_id, categories_disciplines_discipline_id, categories_disciplines_created_date) FROM stdin;
\.


--
-- Name: categories_disciplines_categories_disciplines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('categories_disciplines_categories_disciplines_id_seq', 1, false);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY comments (comment_id, comment_url_id, comment_user_id, comment_parent_id, comment_text, comment_hearts, comment_spam, comment_created_date) FROM stdin;
\.


--
-- Name: comments_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('comments_comment_id_seq', 1, false);


--
-- Data for Name: disciplines; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY disciplines (discipline_id, discipline_name, discipline_created_date, discipline_description) FROM stdin;
\.


--
-- Name: disciplines_discipline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('disciplines_discipline_id_seq', 1, false);


--
-- Data for Name: disciplines_posts; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY disciplines_posts (disciplines_posts_id, disciplines_posts_post_id, disciplines_posts_discipline_id) FROM stdin;
\.


--
-- Name: disciplines_posts_disciplines_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('disciplines_posts_disciplines_posts_id_seq', 1, false);


--
-- Data for Name: disciplines_requests; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY disciplines_requests (disciplines_requests_id, disciplines_requests_request_id, disciplines_requests_discipline_id) FROM stdin;
\.


--
-- Name: disciplines_requests_disciplines_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('disciplines_requests_disciplines_requests_id_seq', 1, false);


--
-- Data for Name: disciplines_to_parents; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY disciplines_to_parents (disciplines_to_parents_id, disciplines_to_parents_parent_id, disciplines_to_parents_child_id) FROM stdin;
\.


--
-- Name: disciplines_to_parents_disciplines_to_parents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('disciplines_to_parents_disciplines_to_parents_id_seq', 1, false);


--
-- Data for Name: disciplines_urls; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY disciplines_urls (disciplines_urls_id, disciplines_urls_url_id, disciplines_urls_discipline_id) FROM stdin;
\.


--
-- Name: disciplines_urls_disciplines_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('disciplines_urls_disciplines_urls_id_seq', 1, false);


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY posts (post_id, post_title, post_description, post_text, post_hearts, post_spam, post_miscategorized, post_created_date, post_edited_date, post_submitted_by, post_last_edited_by, post_parent_id) FROM stdin;
\.


--
-- Name: posts_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('posts_post_id_seq', 1, false);


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY requests (request_title, request_desc, request_submitted_by, request_submitted_date, request_id) FROM stdin;
\.


--
-- Name: requests_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('requests_request_id_seq', 1, false);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY tags (tag_id, tag_name, tag_description, tag_count, tag_created_date) FROM stdin;
\.


--
-- Data for Name: tags_disciplines; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY tags_disciplines (tags_disciplines_id, tags_disciplines_discipline_id, tags_disciplines_tag_id) FROM stdin;
\.


--
-- Name: tags_disciplines_tags_disciplines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('tags_disciplines_tags_disciplines_id_seq', 1, false);


--
-- Data for Name: tags_posts; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY tags_posts (tags_posts_id, tags_posts_post_id, tags_posts_tag_id) FROM stdin;
\.


--
-- Name: tags_posts_tags_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('tags_posts_tags_posts_id_seq', 1, false);


--
-- Data for Name: tags_requests; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY tags_requests (tags_requests_id, tags_requests_request_id, tags_requests_tag_id) FROM stdin;
\.


--
-- Name: tags_requests_tags_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('tags_requests_tags_requests_id_seq', 1, false);


--
-- Name: tags_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('tags_tag_id_seq', 1, false);


--
-- Data for Name: tags_urls; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY tags_urls (tags_urls_id, tags_urls_url_id, tags_urls_tag_id) FROM stdin;
\.


--
-- Name: tags_urls_tags_urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('tags_urls_tags_urls_id_seq', 1, false);


--
-- Data for Name: tags_users; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY tags_users (tags_users_id, tags_users_user_id, tags_users_tag_id, tags_users_count) FROM stdin;
\.


--
-- Name: tags_users_tags_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('tags_users_tags_users_id_seq', 1, false);


--
-- Data for Name: urls; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY urls (url_id, url_title, url_address, url_description, url_hearts, url_spam, url_broken, url_miscategorized, url_created_date, url_last_edited, url_submitted_by, url_last_edited_by) FROM stdin;
\.


--
-- Name: urls_url_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('urls_url_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users (user_id, user_login, user_passwd, user_email, user_created_date, user_urls_loved, user_posts_loved, user_comments_loved, user_edits_loved) FROM stdin;
\.


--
-- Data for Name: users_comments_loved; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_comments_loved (users_comments_loved_id, users_comments_loved_user_id, users_comments_loved_comment_id, users_comments_loved_ip_addr, users_comments_loved_date) FROM stdin;
\.


--
-- Name: users_comments_loved_users_comments_loved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_comments_loved_users_comments_loved_id_seq', 1, false);


--
-- Data for Name: users_comments_saved; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_comments_saved (users_comments_saved_id, users_comments_saved_user_id, users_comments_saved_comment_id, users_comments_saved_date) FROM stdin;
\.


--
-- Name: users_comments_saved_users_comments_saved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_comments_saved_users_comments_saved_id_seq', 1, false);


--
-- Data for Name: users_disciplines; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_disciplines (users_disciplines_id, users_disciplines_user_id, users_disciplines_discipline_id) FROM stdin;
\.


--
-- Name: users_disciplines_users_disciplines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_disciplines_users_disciplines_id_seq', 1, false);


--
-- Data for Name: users_posts_loved; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_posts_loved (users_posts_loved_id, users_posts_loved_user_id, users_posts_loved_post_id, users_posts_loved_ip_addr, users_posts_loved_date) FROM stdin;
\.


--
-- Name: users_posts_loved_users_posts_loved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_posts_loved_users_posts_loved_id_seq', 1, false);


--
-- Data for Name: users_posts_saved; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_posts_saved (users_posts_saved_id, users_posts_saved_user_id, users_posts_saved_post_id, users_posts_saved_date) FROM stdin;
\.


--
-- Name: users_posts_saved_users_posts_saved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_posts_saved_users_posts_saved_id_seq', 1, false);


--
-- Data for Name: users_requests_loved; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_requests_loved (users_requests_loved_id, users_requests_loved_user_id, users_requests_loved_request_id, users_requests_loved_ip_addr, users_requests_loved_date) FROM stdin;
\.


--
-- Name: users_requests_loved_users_requests_loved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_requests_loved_users_requests_loved_id_seq', 1, false);


--
-- Name: users_requests_loved_users_requests_loved_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_requests_loved_users_requests_loved_request_id_seq', 1, false);


--
-- Data for Name: users_requests_saved; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_requests_saved (users_requests_saved_id, users_requests_saved_user_id, users_requests_saved_request_id, users_requests_saved_date) FROM stdin;
\.


--
-- Name: users_requests_saved_users_requests_saved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_requests_saved_users_requests_saved_id_seq', 1, false);


--
-- Data for Name: users_urls_loved; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_urls_loved (users_urls_loved_id, users_urls_loved_user_id, users_urls_loved_url_id, users_urls_loved_ip_addr, users_urls_loved_date) FROM stdin;
\.


--
-- Name: users_urls_loved_users_urls_loved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_urls_loved_users_urls_loved_id_seq', 1, false);


--
-- Data for Name: users_urls_saved; Type: TABLE DATA; Schema: public; Owner: konocle
--

COPY users_urls_saved (users_urls_saved_id, users_urls_saved_user_id, users_urls_saved_url_id, users_urls_saved_date) FROM stdin;
\.


--
-- Name: users_urls_saved_users_urls_saved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_urls_saved_users_urls_saved_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: konocle
--

SELECT pg_catalog.setval('users_user_id_seq', 1, false);


--
-- Name: Category Primary Key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT "Category Primary Key" PRIMARY KEY (category_id);


--
-- Name: Comments Primary Key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT "Comments Primary Key" PRIMARY KEY (comment_id);


--
-- Name: Discipline Name Unique; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY disciplines
    ADD CONSTRAINT "Discipline Name Unique" UNIQUE (discipline_name);


--
-- Name: Disciplines Primary Key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY disciplines
    ADD CONSTRAINT "Disciplines Primary Key" PRIMARY KEY (discipline_id);


--
-- Name: Name must be unique; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT "Name must be unique" UNIQUE (category_name);


--
-- Name: Tags Primary Key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT "Tags Primary Key" PRIMARY KEY (tag_id);


--
-- Name: URLs Primary Key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT "URLs Primary Key" PRIMARY KEY (url_id);


--
-- Name: Users Primary Key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT "Users Primary Key" PRIMARY KEY (user_id);


--
-- Name: categories_disciplines pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY categories_disciplines
    ADD CONSTRAINT "categories_disciplines pkey" PRIMARY KEY (categories_disciplines_id);


--
-- Name: disciplines_posts pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY disciplines_posts
    ADD CONSTRAINT "disciplines_posts pkey" PRIMARY KEY (disciplines_posts_id);


--
-- Name: disciplines_requests pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY disciplines_requests
    ADD CONSTRAINT "disciplines_requests pkey" PRIMARY KEY (disciplines_requests_id);


--
-- Name: disciplines_to_parents_pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY disciplines_to_parents
    ADD CONSTRAINT disciplines_to_parents_pkey PRIMARY KEY (disciplines_to_parents_id);


--
-- Name: disciplines_urls pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY disciplines_urls
    ADD CONSTRAINT "disciplines_urls pkey" PRIMARY KEY (disciplines_urls_id);


--
-- Name: posts pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT "posts pkey" PRIMARY KEY (post_id);


--
-- Name: request pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT "request pkey" PRIMARY KEY (request_id);


--
-- Name: tags_disciplines pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags_disciplines
    ADD CONSTRAINT "tags_disciplines pkey" PRIMARY KEY (tags_disciplines_id);


--
-- Name: tags_disciplines_tags_disciplines_discipline_id_tags_discip_key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags_disciplines
    ADD CONSTRAINT tags_disciplines_tags_disciplines_discipline_id_tags_discip_key UNIQUE (tags_disciplines_discipline_id, tags_disciplines_tag_id);


--
-- Name: tags_posts pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags_posts
    ADD CONSTRAINT "tags_posts pkey" PRIMARY KEY (tags_posts_id);


--
-- Name: tags_requests pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags_requests
    ADD CONSTRAINT "tags_requests pkey" PRIMARY KEY (tags_requests_id);


--
-- Name: tags_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_tag_name_key UNIQUE (tag_name);


--
-- Name: tags_urls pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags_urls
    ADD CONSTRAINT "tags_urls pkey" PRIMARY KEY (tags_urls_id);


--
-- Name: tags_users pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY tags_users
    ADD CONSTRAINT "tags_users pkey" PRIMARY KEY (tags_users_id);


--
-- Name: urls_url_address_key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_url_address_key UNIQUE (url_address);


--
-- Name: users_comments_loved pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_comments_loved
    ADD CONSTRAINT "users_comments_loved pkey" PRIMARY KEY (users_comments_loved_id);


--
-- Name: users_comments_loved unique; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_comments_loved
    ADD CONSTRAINT "users_comments_loved unique" UNIQUE (users_comments_loved_comment_id, users_comments_loved_ip_addr);


--
-- Name: users_comments_saved pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_comments_saved
    ADD CONSTRAINT "users_comments_saved pkey" PRIMARY KEY (users_comments_saved_id);


--
-- Name: users_disciplines pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_disciplines
    ADD CONSTRAINT "users_disciplines pkey" PRIMARY KEY (users_disciplines_id);


--
-- Name: users_posts_loved pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_posts_loved
    ADD CONSTRAINT "users_posts_loved pkey" PRIMARY KEY (users_posts_loved_id);


--
-- Name: users_posts_loved_users_posts_loved_post_id_users_posts_lov_key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_posts_loved
    ADD CONSTRAINT users_posts_loved_users_posts_loved_post_id_users_posts_lov_key UNIQUE (users_posts_loved_post_id, users_posts_loved_ip_addr);


--
-- Name: users_posts_saved pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_posts_saved
    ADD CONSTRAINT "users_posts_saved pkey" PRIMARY KEY (users_posts_saved_id);


--
-- Name: users_requests_loved pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_requests_loved
    ADD CONSTRAINT "users_requests_loved pkey" PRIMARY KEY (users_requests_loved_id);


--
-- Name: users_requests_loved_users_requests_loved_request_id_users__key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_requests_loved
    ADD CONSTRAINT users_requests_loved_users_requests_loved_request_id_users__key UNIQUE (users_requests_loved_request_id, users_requests_loved_ip_addr);


--
-- Name: users_requests_saved pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_requests_saved
    ADD CONSTRAINT "users_requests_saved pkey" PRIMARY KEY (users_requests_saved_id);


--
-- Name: users_urls_loved pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_urls_loved
    ADD CONSTRAINT "users_urls_loved pkey" PRIMARY KEY (users_urls_loved_id);


--
-- Name: users_urls_loved unique; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_urls_loved
    ADD CONSTRAINT "users_urls_loved unique" UNIQUE (users_urls_loved_url_id, users_urls_loved_ip_addr);


--
-- Name: users_urls_saved pkey; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users_urls_saved
    ADD CONSTRAINT "users_urls_saved pkey" PRIMARY KEY (users_urls_saved_id);


--
-- Name: users_user_login_key; Type: CONSTRAINT; Schema: public; Owner: konocle; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_user_login_key UNIQUE (user_login);


--
-- Name: Comment Submitted By; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT "Comment Submitted By" FOREIGN KEY (comment_user_id) REFERENCES users(user_id);


--
-- Name: Comment URL; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT "Comment URL" FOREIGN KEY (comment_url_id) REFERENCES urls(url_id);


--
-- Name: URLs Edited By; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT "URLs Edited By" FOREIGN KEY (url_last_edited_by) REFERENCES users(user_id);


--
-- Name: URLs Submitted By; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT "URLs Submitted By" FOREIGN KEY (url_submitted_by) REFERENCES users(user_id);


--
-- Name: categories_disciplines category fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY categories_disciplines
    ADD CONSTRAINT "categories_disciplines category fkey" FOREIGN KEY (categories_disciplines_category_id) REFERENCES categories(category_id);


--
-- Name: categories_disciplines discipline fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY categories_disciplines
    ADD CONSTRAINT "categories_disciplines discipline fkey" FOREIGN KEY (categories_disciplines_discipline_id) REFERENCES disciplines(discipline_id);


--
-- Name: disciplines_posts discipline fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_posts
    ADD CONSTRAINT "disciplines_posts discipline fkey" FOREIGN KEY (disciplines_posts_discipline_id) REFERENCES disciplines(discipline_id);


--
-- Name: disciplines_posts post fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_posts
    ADD CONSTRAINT "disciplines_posts post fkey" FOREIGN KEY (disciplines_posts_post_id) REFERENCES posts(post_id);


--
-- Name: disciplines_requests discipline fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_requests
    ADD CONSTRAINT "disciplines_requests discipline fkey" FOREIGN KEY (disciplines_requests_discipline_id) REFERENCES disciplines(discipline_id);


--
-- Name: disciplines_requests request fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_requests
    ADD CONSTRAINT "disciplines_requests request fkey" FOREIGN KEY (disciplines_requests_request_id) REFERENCES requests(request_id);


--
-- Name: disciplines_to_parents_disciplines_to_parents_child_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_to_parents
    ADD CONSTRAINT disciplines_to_parents_disciplines_to_parents_child_id_fkey FOREIGN KEY (disciplines_to_parents_child_id) REFERENCES disciplines(discipline_id);


--
-- Name: disciplines_to_parents_disciplines_to_parents_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_to_parents
    ADD CONSTRAINT disciplines_to_parents_disciplines_to_parents_parent_id_fkey FOREIGN KEY (disciplines_to_parents_parent_id) REFERENCES disciplines(discipline_id);


--
-- Name: disciplines_urls discipline fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_urls
    ADD CONSTRAINT "disciplines_urls discipline fkey" FOREIGN KEY (disciplines_urls_discipline_id) REFERENCES disciplines(discipline_id);


--
-- Name: disciplines_urls url fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY disciplines_urls
    ADD CONSTRAINT "disciplines_urls url fkey" FOREIGN KEY (disciplines_urls_url_id) REFERENCES urls(url_id);


--
-- Name: posts edited fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT "posts edited fkey" FOREIGN KEY (post_last_edited_by) REFERENCES users(user_id);


--
-- Name: posts submitted fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT "posts submitted fkey" FOREIGN KEY (post_submitted_by) REFERENCES users(user_id);


--
-- Name: requests_request_submitted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY requests
    ADD CONSTRAINT requests_request_submitted_by_fkey FOREIGN KEY (request_submitted_by) REFERENCES users(user_id);


--
-- Name: tags_disciplines discipline fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_disciplines
    ADD CONSTRAINT "tags_disciplines discipline fkey" FOREIGN KEY (tags_disciplines_discipline_id) REFERENCES disciplines(discipline_id);


--
-- Name: tags_disciplines tag fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_disciplines
    ADD CONSTRAINT "tags_disciplines tag fkey" FOREIGN KEY (tags_disciplines_discipline_id) REFERENCES tags(tag_id);


--
-- Name: tags_posts post fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_posts
    ADD CONSTRAINT "tags_posts post fkey" FOREIGN KEY (tags_posts_post_id) REFERENCES posts(post_id);


--
-- Name: tags_posts tag fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_posts
    ADD CONSTRAINT "tags_posts tag fkey" FOREIGN KEY (tags_posts_tag_id) REFERENCES tags(tag_id);


--
-- Name: tags_requests request fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_requests
    ADD CONSTRAINT "tags_requests request fkey" FOREIGN KEY (tags_requests_request_id) REFERENCES requests(request_id);


--
-- Name: tags_requests tag fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_requests
    ADD CONSTRAINT "tags_requests tag fkey" FOREIGN KEY (tags_requests_tag_id) REFERENCES tags(tag_id);


--
-- Name: tags_urls connection to url; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_urls
    ADD CONSTRAINT "tags_urls connection to url" FOREIGN KEY (tags_urls_url_id) REFERENCES urls(url_id);


--
-- Name: tags_urls_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_urls
    ADD CONSTRAINT tags_urls_tag_id FOREIGN KEY (tags_urls_tag_id) REFERENCES tags(tag_id);


--
-- Name: tags_users tag fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_users
    ADD CONSTRAINT "tags_users tag fkey" FOREIGN KEY (tags_users_tag_id) REFERENCES tags(tag_id);


--
-- Name: tags_users users fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY tags_users
    ADD CONSTRAINT "tags_users users fkey" FOREIGN KEY (tags_users_user_id) REFERENCES users(user_id);


--
-- Name: users_comments_loved comment fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_comments_loved
    ADD CONSTRAINT "users_comments_loved comment fkey" FOREIGN KEY (users_comments_loved_comment_id) REFERENCES comments(comment_id);


--
-- Name: users_comments_loved user fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_comments_loved
    ADD CONSTRAINT "users_comments_loved user fkey" FOREIGN KEY (users_comments_loved_user_id) REFERENCES users(user_id);


--
-- Name: users_comments_saved comment fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_comments_saved
    ADD CONSTRAINT "users_comments_saved comment fkey" FOREIGN KEY (users_comments_saved_comment_id) REFERENCES comments(comment_id);


--
-- Name: users_comments_saved user fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_comments_saved
    ADD CONSTRAINT "users_comments_saved user fkey" FOREIGN KEY (users_comments_saved_user_id) REFERENCES users(user_id);


--
-- Name: users_disciplines disciplines fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_disciplines
    ADD CONSTRAINT "users_disciplines disciplines fkey" FOREIGN KEY (users_disciplines_discipline_id) REFERENCES disciplines(discipline_id);


--
-- Name: users_disciplines user fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_disciplines
    ADD CONSTRAINT "users_disciplines user fkey" FOREIGN KEY (users_disciplines_user_id) REFERENCES users(user_id);


--
-- Name: users_posts_loved post fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_posts_loved
    ADD CONSTRAINT "users_posts_loved post fkey" FOREIGN KEY (users_posts_loved_post_id) REFERENCES posts(post_id);


--
-- Name: users_posts_loved user fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_posts_loved
    ADD CONSTRAINT "users_posts_loved user fkey" FOREIGN KEY (users_posts_loved_user_id) REFERENCES users(user_id);


--
-- Name: users_posts_saved post fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_posts_saved
    ADD CONSTRAINT "users_posts_saved post fkey" FOREIGN KEY (users_posts_saved_post_id) REFERENCES posts(post_id);


--
-- Name: users_posts_saved user fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_posts_saved
    ADD CONSTRAINT "users_posts_saved user fkey" FOREIGN KEY (users_posts_saved_user_id) REFERENCES users(user_id);


--
-- Name: users_requests_loved request fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_requests_loved
    ADD CONSTRAINT "users_requests_loved request fkey" FOREIGN KEY (users_requests_loved_request_id) REFERENCES requests(request_id);


--
-- Name: users_requests_loved user fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_requests_loved
    ADD CONSTRAINT "users_requests_loved user fkey" FOREIGN KEY (users_requests_loved_user_id) REFERENCES users(user_id);


--
-- Name: users_requests_saved request fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_requests_saved
    ADD CONSTRAINT "users_requests_saved request fkey" FOREIGN KEY (users_requests_saved_request_id) REFERENCES requests(request_id);


--
-- Name: users_requests_saved user fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_requests_saved
    ADD CONSTRAINT "users_requests_saved user fkey" FOREIGN KEY (users_requests_saved_user_id) REFERENCES users(user_id);


--
-- Name: users_urls_loved url fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_urls_loved
    ADD CONSTRAINT "users_urls_loved url fkey" FOREIGN KEY (users_urls_loved_url_id) REFERENCES urls(url_id);


--
-- Name: users_urls_loved user fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_urls_loved
    ADD CONSTRAINT "users_urls_loved user fkey" FOREIGN KEY (users_urls_loved_user_id) REFERENCES users(user_id);


--
-- Name: users_urls_saved url fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_urls_saved
    ADD CONSTRAINT "users_urls_saved url fkey" FOREIGN KEY (users_urls_saved_url_id) REFERENCES urls(url_id);


--
-- Name: users_urls_saved users fkey; Type: FK CONSTRAINT; Schema: public; Owner: konocle
--

ALTER TABLE ONLY users_urls_saved
    ADD CONSTRAINT "users_urls_saved users fkey" FOREIGN KEY (users_urls_saved_user_id) REFERENCES users(user_id);


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

