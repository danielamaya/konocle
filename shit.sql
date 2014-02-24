CREATE TABLE categories(
    category_id INTEGER PRIMARY KEY,
    name CHARACTER VARYING(250) NOT NULL,
    description CHARACTER VARYING(250),
    wiki TEXT,
    parent_id INTEGER REFERENCES categories,
    parent_path LTREE
);

CREATE INDEX category_parent_path_idx ON categories USING GIST (parent_path);
CREATE INDEX category_parent_id_idx ON categories (parent_id);

CREATE OR REPLACE FUNCTION update_categories_parent_path() RETURNS TRIGGER AS $$
    DECLARE
        path ltree;
    BEGIN
        IF NEW.parent_id IS NULL THEN
            NEW.parent_path = 'root'::ltree;
        ELSEIF TG_OP = 'INSERT' OR OLD.parent_id IS NULL OR OLD.parent_id != NEW.parent_id THEN
            SELECT parent_path || id::text FROM categories WHERE id = NEW.parent_id INTO path;
            IF path IS NULL THEN
                RAISE EXCEPTION 'Invalid parent_id %', NEW.parent_id;
            END IF;
            NEW.parent_path = path;
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER categories_parent_path_tgr
    BEFORE INSERT OR UPDATE ON categories
    FOR EACH ROW EXECUTE PROCEDURE update_categories_parent_path();

ALTER TABLE public.categories OWNER TO konocle;

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO konocle;

--
-- Name: requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.category_id;


CREATE TABLE posts(
    post_id BIGINT PRIMARY KEY NOT NULL,
    title character varying(80) NOT NULL,
    description character varying(200) NOT NULL,
    post_body text NOT NULL,
    hearts bigint DEFAULT 0 NOT NULL,
    spam bigint DEFAULT 0 NOT NULL,
    miscategorized bigint DEFAULT 0 NOT NULL,
    submitted_by bigint NOT NULL,
    edited_by bigint,
    parent_id INTEGER REFERENCES posts,
    parent_path LTREE,
    created_date timestamp with time zone DEFAULT now() NOT NULL,
    edited_date timestamp with time zone
);

CREATE INDEX posts_parent_path_idx ON posts USING GIST (parent_path);
CREATE INDEX posts_parent_id_idx ON posts (parent_id);

CREATE OR REPLACE FUNCTION update_posts_parent_path() RETURNS TRIGGER AS $$
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
$$ LANGUAGE plpgsql;

CREATE TRIGGER posts_parent_path_tgr
    BEFORE INSERT OR UPDATE ON posts
    FOR EACH ROW EXECUTE PROCEDURE update_posts_parent_path();

ALTER TABLE public.posts OWNER TO konocle;

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO konocle;

ALTER SEQUENCE posts_id_seq OWNED BY posts.post_id;


CREATE TABLE url_comments(
    comment_id BIGINT PRIMARY KEY,
    url_id BIGINT NOT NULL,
    comment_body TEXT NOT NULL,
    hearts INTEGER DEFAULT 0 NOT NULL,
    spam INTEGER DEFAULT 0 NOT NULL,
    parent_id INTEGER REFERENCES url_comments,
    parent_path LTREE,
    date_created timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX url_comments_parent_path_idx ON url_comments USING GIST (parent_path);
CREATE INDEX url_comments_parent_id_idx ON url_comments (parent_id);

CREATE OR REPLACE FUNCTION update_url_comments_parent_path() RETURNS TRIGGER AS $$
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
$$ LANGUAGE plpgsql;

CREATE TRIGGER url_comments_parent_path_tgr
    BEFORE INSERT OR UPDATE ON url_comments
    FOR EACH ROW EXECUTE PROCEDURE update_url_comments_parent_path();

ALTER TABLE public.url_comments OWNER TO konocle;

CREATE SEQUENCE url_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.url_comments_id_seq OWNER TO konocle;

--
-- Name: requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE url_comments_id_seq OWNED BY url_comments.comment_id;


CREATE TABLE post_comments(
    comment_id BIGINT PRIMARY KEY,
    post_id INTEGER NOT NULL,
    comment_body TEXT NOT NULL,
    hearts INTEGER DEFAULT 0 NOT NULL,
    spam INTEGER DEFAULT 0 NOT NULL,
    parent_id INTEGER REFERENCES post_comments,
    parent_path LTREE,
    date_created timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX post_comments_parent_path_idx ON post_comments USING GIST (parent_path);
CREATE INDEX post_comments_parent_id_idx ON post_comments (parent_id);

CREATE OR REPLACE FUNCTION update_post_comments_parent_path() RETURNS TRIGGER AS $$
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
$$ LANGUAGE plpgsql;

CREATE TRIGGER post_comments_parent_path_tgr
    BEFORE INSERT OR UPDATE ON post_comments
    FOR EACH ROW EXECUTE PROCEDURE update_post_comments_parent_path();

ALTER TABLE public.post_comments OWNER TO konocle;

CREATE SEQUENCE post_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_comments_id_seq OWNER TO konocle;

--
-- Name: requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE post_comments_id_seq OWNED BY post_comments.comment_id;

CREATE TABLE request_comments(
    comment_id BIGINT PRIMARY KEY,
    request_id INTEGER NOT NULL,
    comment_body TEXT NOT NULL,
    hearts INTEGER DEFAULT 0 NOT NULL,
    spam INTEGER DEFAULT 0 NOT NULL,
    parent_id INTEGER REFERENCES request_comments,
    parent_path LTREE,
    date_created timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX request_comments_parent_path_idx ON request_comments USING GIST (parent_path);
CREATE INDEX requests_comments_parent_id_idx ON request_comments (parent_id);

CREATE OR REPLACE FUNCTION request_post_comments_parent_path() RETURNS TRIGGER AS $$
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
$$ LANGUAGE plpgsql;

CREATE TRIGGER post_comments_parent_path_tgr
    BEFORE INSERT OR UPDATE ON request_comments
    FOR EACH ROW EXECUTE PROCEDURE update_request_comments_parent_path();

ALTER TABLE public.request_comments OWNER TO konocle;

CREATE SEQUENCE request_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.request_comments_id_seq OWNER TO konocle;

--
-- Name: requests_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: konocle
--

ALTER SEQUENCE request_comments_id_seq OWNED BY request_comments.comment_id;

ALTER TABLE ONLY categories
    ADD CONSTRAINT "categories pkey" PRIMARY KEY (category_id);

ALTER TABLE ONLY posts
    ADD CONSTRAINT "posts pkey" PRIMARY KEY (post_id);

ALTER TABLE ONLY url_comments
    ADD CONSTRAINT "url_comments pkey" PRIMARY KEY (comment_id);

ALTER TABLE ONLY post_comments
    ADD CONSTRAINT "post_comments pkey" PRIMARY KEY (comment_id);

ALTER TABLE ONLY request_comments
    ADD CONSTRAINT "request_comments pkey" PRIMARY KEY (comment_id);

ALTER TABLE ONLY posts
    ADD CONSTRAINT "posts submitted by" FOREIGN KEY (submitted_by) REFERENCES users(user_id);

ALTER TABLE ONLY posts
    ADD CONSTRAINT "posts edited by" FOREIGN KEY (edited_by) REFERENCES users(user_id);

ALTER TABLE ONLY url_comments
    ADD CONSTRAINT "url id" FOREIGN KEY (url_id) REFERENCES urls(url_id);

ALTER TABLE ONLY post_comments
    ADD CONSTRAINT "post id" FOREIGN KEY (post_id) REFERENCES posts(post_id);

ALTER TABLE ONLY request_comments
    ADD CONSTRAINT "request id" FOREIGN KEY (request_id) REFERENCES requests(request_id);

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('categories_id_seq'::regclass);

SELECT pg_catalog.setval('categories_id_seq', 1, false);

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('posts_id_seq'::regclass);

SELECT pg_catalog.setval('posts_id_seq', 1, false);

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('url_comments_id_seq'::regclass);

SELECT pg_catalog.setval('url_comments_id_seq', 1, false);

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('post_comments_id_seq'::regclass);

SELECT pg_catalog.setval('post_comments_id_seq', 1, false);

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('request_comments_id_seq'::regclass);

SELECT pg_catalog.setval('request_comments_id_seq', 1, false);
