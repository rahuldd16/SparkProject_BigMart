import config as conf
from pyspark.sql.functions import *
from pyspark.sql import SparkSession

# for local setup
# spark = SparkSession.builder.appName(conf.ProjectName).getOrCreate()

# for AWS
spark = SparkSession.builder \
    .appName("Spark_BigMartData_Project") \
    .config('spark.jars', 'dependencyJar/hadoop-aws-3.3.1.jar,dependencyJar/aws-java-sdk-bundle-1.11.1026.jar') \
    .config("spark.driver.bindAddress", "127.0.0.1") \
    .config("spark.driver.host", "127.0.0.1") \
    .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem") \
    .config('spark.hadoop.fs.s3a.aws.credentials.provider', 'com.amazonaws.auth.DefaultAWSCredentialsProviderChain') \
    .getOrCreate()
