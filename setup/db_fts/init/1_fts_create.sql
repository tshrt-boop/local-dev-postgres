CREATE SCHEMA atlasaz
    AUTHORIZATION root;
    
CREATE TABLE atlasaz.test
(
    id numeric,
    value text COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE atlasaz.test
    OWNER to root;

INSERT INTO atlasaz.test(
	id, value)
	VALUES (1, 'hoge');