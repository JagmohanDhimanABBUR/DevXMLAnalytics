---------------------------------------------------------------------------------------------------------
------------------------------ Staging Tables Hive (before transformation) ------------------------------
---------------------------------------------------------------------------------------------------------

------------------------------ CREATE TABLE: STG_US_Configurators -------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.STG_US_Configurators (
   ConfiguratorID STRING
  ,ProductID STRING
  ,Name STRING
  ,Business STRING
  ,ViewID INT
  ,ConfiguratorStatusID INT)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '~'
LOCATION '/user/inankal3/sqoop_import/configurators';

------------------------------ CREATE TABLE: STG_US_Products ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.STG_US_Products (
  ProductID STRING
  ,ApplicationID STRING
  ,ProductName STRING
  ,PartFamilyID INT
  ,PartFamilyName STRING
  ,LastUpdated TIMESTAMP) --very less records so partition is not required
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '~'
LOCATION '/user/inankal3/sqoop_import/products';

------------------------------ CREATE TABLE: STG_US_ModelXML ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.STG_US_ModelXML (
   ModelID STRING
  ,ConfiguratorID STRING
  ,XML STRING
  ,Drawing STRING
  ,UserID STRING
  ,LastUpdated TIMESTAMP)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '~'
LOCATION '/user/inankal3/sqoop_import/modelxml';

---------------------------------------------------------------------------------------------------------
------------------------------- Main Tables Hive (before transformation) --------------------------------
---------------------------------------------------------------------------------------------------------

------------------------------ CREATE TABLE: PostStaging_Configurators ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.PostStaging_Configurators (
   ConfiguratorID STRING
  ,ProductID STRING
  ,Name STRING
  ,Business STRING
  ,ViewID INT
  ,ConfiguratorStatusID INT) --very less records so partition is not required
STORED AS PARQUET
LOCATION '/user/inankal3/hive/configurators'; 

------------------------------ CREATE TABLE: PostStaging_Products ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.PostStaging_Products (
  ProductID STRING
  ,ApplicationID STRING
  ,ProductName STRING
  ,PartFamilyID INT
  ,PartFamilyName STRING
  ,LastUpdated TIMESTAMP) ----very less records so partition is not required
STORED AS PARQUET
LOCATION '/user/inankal3/hive/products';

------------------------------ CREATE TABLE: PostStaging_ModelXML ------------------------------

CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.PostStaging_ModelXML (
   ModelID STRING
  ,ConfiguratorID STRING
  ,XML STRING
  ,Drawing STRING
  ,UserID STRING
  ,LastUpdated TIMESTAMP)
STORED AS PARQUET
LOCATION '/user/inankal3/hive/modelxml';


---------------------------------------------------------------------------------------------------------
------------------------------- Data load from Stg to PostStaging ---------------------------------------
---------------------------------------------------------------------------------------------------------

---------- INSERT: PostStaging_Configurators ----------

hdfs dfs -chmod 757 /user/inankal3/hive/configurators

INSERT INTO epis_empower_ingestion.PostStaging_Configurators SELECT * FROM epis_empower_ingestion.STG_US_Configurators;



---------- INSERT: PostStaging_Products ----------

hdfs dfs -chmod 757 /user/inankal3/hive/products

INSERT INTO epis_empower_ingestion.PostStaging_Products SELECT * FROM epis_empower_ingestion.STG_US_Products;


---------- INSERT: PostStaging_ModelXML ----------

hdfs dfs -chmod 777 /user/inankal3/hive/products

INSERT INTO epis_empower_ingestion.PostStaging_ModelXML SELECT * FROM epis_empower_ingestion.STG_US_ModelXML;