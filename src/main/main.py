import pyspark
from delta import configure_spark_with_delta_pip

def main():
    builder = pyspark.sql.SparkSession.builder.appName("gold") \
        .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
        .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog") \
        .config("spark.sql.warehouse.dir", "./")

    spark = configure_spark_with_delta_pip(builder).getOrCreate()

    spark.sql("SHOW TABLES").show()

if __name__ == '__main__':
  main()
