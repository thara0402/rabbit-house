# Apache Spark Notebook Tips

```python
%%pyspark

# DataFrame の作成
new_rows = [('CA',22, 45000),("WA",35,65000) ,("WA",50,85000)]
demo_df = spark.createDataFrame(new_rows, ['state', 'age', 'salary'])

# CSV の読み取り
df = spark.read.load('abfss://dest4@gooner1226lake.dfs.core.windows.net/2020/12/26/04/*.csv', format='csv'
, header=True
)

display(df.limit(10))

df.printSchema()

df.show(100)

# 一時テーブル作成
df.createOrReplaceTempView("pysparktemptable")

# Spark テーブルを読み取って、別テーブルに書き込み
df = spark.sql("""
   SELECT PassengerCount,
       SUM(TripDistanceMiles) as SumTripDistance,
       AVG(TripDistanceMiles) as AvgTripDistance
   FROM nyctaxi.trip
   WHERE TripDistanceMiles > 0 AND PassengerCount > 0
   GROUP BY PassengerCount
   ORDER BY PassengerCount
""") 
display(df)
df.write.saveAsTable("nyctaxi.passengercountstats")

# ストレージに書き込み
df = df.repartition(1) # This ensure we'll get a single file during write()
df.write.mode("overwrite").csv("/NYCTaxi/PassengerCountStats_csvformat")
df.write.mode("overwrite").parquet("/NYCTaxi/PassengerCountStats_parquetformat")

df.write.csv('demo_df', mode='overwrite')
df.write.parquet('abfss://<<TheNameOfAStorageAccountFileSystem>>@<<TheNameOfAStorageAccount>>.dfs.core.windows.net/demodata/demo_df', mode='overwrite')

```

```scala
%%spark

// Spark DB を作って、SQL のレコードをテーブルに書き込む
spark.sql("CREATE DATABASE IF NOT EXISTS nyctaxi")
val df = spark.read.sqlanalytics("SQLPOOL1.dbo.Trip") 
df.write.mode("overwrite").saveAsTable("nyctaxi.trip")

// Spark テーブルを SQL にコピー
val df = spark.sql("SELECT * FROM nyctaxi.passengercountstats")
df.write.sqlanalytics("SQLPOOL1.dbo.PassengerCountStats", Constants.INTERNAL )

```
