// using delta lake with spark 

val df = spark.read.format("csv").option("header","true").option("inferSchema","true").load("/user/inankal3/dev_directory/data_csv_2010-12-01.csv")