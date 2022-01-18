-- mysqldump utility
mysqldump -u [user name] –p [password] [options] [database_name] [tablename] > [dumpfilename.sql]

-- Generate the backup of a single database
mysqldump -u root -p sakila > C:\MySQLBackup\sakila_20200424.sql

-- Generate the backup of multiple databases
mysqldump -u root -p --databases sakila employees > C:\MySQLBackup\sakila_employees_20200424.sql

-- Generate the backup of all databases 
mysqldump -u root -p --all-databases > C:\MySQLBackup\all_databases_20200424.sql

-- Generate the backup of database structure
-- if you want to generate the backup of the database structure, then you must use the –no-data option
mysqldump -u root -p --no-data sakila > C:\MySQLBackup\sakila_objects_definition_20200424.sql

-- Generate the backup of a specific table
-- The following command generates the backup of the actor table of the sakila database.
mysqldump -u root -p sakila actor payment > C:\MySQLBackup\actor_payment_table_20200424.sql

-- Generate the backup of database data
-- The following command generates the backup of data of the sakila database.
mysqldump -u root -p sakila --no-create-info > C:\MySQLBackup\sakila_data_only_20200424.sql

-- Restore the MySQL Database
mysql -u root -p sakila < C:\MySQLBackup\sakila_20200424.sql
