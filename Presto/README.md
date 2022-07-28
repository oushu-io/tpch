


- 01.预先创建presto table
- 02.预先创建HIVE external table
- 03.生成数据 01_dbgenData.sh
- 04.加载数据到hdfs 02_putDataToHdfs.sh
- 05.HDFS数据校验 03_checkHdfsData.sql
- 06.数据入库iceberg 04_dataloadPrestoIceberg.sql
- 07.iceberg数据校验 05_checkDataPrestoIceberg.sql
- 08.tpch SQL 06_run_sql_all.sh
- others 公共脚本 prestoCmd.sh
