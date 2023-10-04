SELECT *
FROM pg_roles;
SELECT current_role;


CREATE ROLE abc_open_data WITH NOSUPERUSER;

CREATE ROLE publishers WITH NOSUPERUSER ROLE abc_open_data;

GRANT USAGE ON SCHEMA analytics TO publishers;
GRANT SELECT ON ALL TABLES IN SCHEMA analytics TO publishers; 

SELECT rolname, rolsuper
FROM pg_roles;

SELECT *
FROM information_schema.table_privileges
WHERE grantee = 'publishers';

SELECT * FROM directory.datasets LIMIT 10;

GRANT USAGE ON SCHEMA directory TO publishers;
GRANT SELECT (id, create_date, hosting_path, publisher, src_size) ON directory.datasets TO publishers;




SET ROLE ccuser;

CREATE POLICY emp_rls_policy ON analytics.downloads 
FOR SELECT TO publishers USING (owner = current_user);

ALTER TABLE analytics.downloads ENABLE ROW LEVEL SECURITY;


SET ROLE abc_open_data;

SELECT * 
FROM analytics.downloads
LIMIT 10;
