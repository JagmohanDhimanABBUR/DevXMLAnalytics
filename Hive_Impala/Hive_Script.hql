---------------------------------------------------------------------------------------------------------
------------------------------ Staging Tables Hive (before transformation) ------------------------------
---------------------------------------------------------------------------------------------------------

------------------------------ CREATE TABLE: STG_US_Configurators ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.STG_US_Configurators (
   ConfiguratorID STRING
  ,ProductID STRING
  ,Name STRING
  ,Business STRING
  ,ViewID INT
  ,ConfiguratorStatusID INT)
STORED AS PARQUET;

------------------------------ CREATE TABLE: STG_US_Products ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.STG_US_Products (
  ProductID STRING
  ,ApplicationID STRING
  ,ProductName STRING
  ,PartFamilyID INT
  ,PartFamilyName STRING
  ,LastUpdate TIMESTAMP) --very less records so partition is not required
STORED AS PARQUET;

------------------------------ CREATE TABLE: STG_US_ModelXML ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.STG_US_ModelXML (
   ModelID STRING
  ,XML STRING
  ,Drawing STRING
  ,UserID STRING
  ,LastUpdated TIMESTAMP)
PARTITIONED BY (ConfiguratorID STRING)
STORED AS PARQUET;


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
STORED AS PARQUET; 

------------------------------ CREATE TABLE: PostStaging_Products ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.PostStaging_Products (
  ProductID STRING
  ,ApplicationID STRING
  ,ProductName STRING
  ,PartFamilyID INT
  ,PartFamilyName STRING
  ,LastUpdate TIMESTAMP) ----very less records so partition is not required
STORED AS PARQUET;

------------------------------ CREATE TABLE: PostStaging_ModelXML ------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.PostStaging_ModelXML (
   ModelID STRING
  ,XML STRING
  ,Drawing STRING
  ,UserID STRING
  ,LastUpdated TIMESTAMP)
PARTITIONED BY (ConfiguratorID STRING)
STORED AS PARQUET;














------------------------------------------------------------------------------------------------------------------------
----------------------------------- Successfully run -------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.test_STG_US_Configurators (
   ConfiguratorID STRING
  ,ProductID STRING
  ,Name STRING
  ,Business STRING
  ,ViewID INT
  ,ConfiguratorStatusID INT);
  
  
  
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

CREATE EXTERNAL TABLE IF NOT EXISTS epis_empower_ingestion.test_STG_US_ModelXML (
   ModelID STRING
  ,XML STRING
  ,Drawing STRING
  ,UserID STRING
  ,LastUpdated TIMESTAMP)
PARTITIONED BY (ConfiguratorID STRING)
STORED AS PARQUET
LOCATION "/user/inankal3/sqoop_import/test_STG_US_ModelXML";

DROP TABLE IF EXISTS epis_empower_ingestion.test_STG_US_ModelXML;

LOAD DATA INPATH '/user/inankal3/sqoop_import/products/ec45dbb3-1f72-4b71-960e-1f3cbbeab824.parquet' OVERWRITE INTO TABLE epis_empower_ingestion.STG_US_Products;
