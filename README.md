# TPCH Benchmark Test
### Modify configuration: tpch.config
```shell
# Load data server host,comma separated, multi host for distributed data to multiple nodes.  
GPLOAD_HOST=192.168.115.130,192.168.115.131,192.168.115.132 

# HAWQ server host.  
GP_DBHOST=192.168.115.130              

# HAWQ home greenplum_path.sh  
BASH_PROFILE=/usr/local/hawq/greenplum_path.sh      

# Load data server directory ,comma separated, multi directory for distributed data.  
DIRS=/data1/hawq/data,/data2/hawq/data                

# Table type : o(orc) p(parquet) m(magmaap)  
DDLTYPE=o                                             

# Test data size ,The 1 is 1GB.  
DATASIZE=1                        

# use <n> processes to generate data.  
PARALLEL=2

# OushuDB Table bucket number
BUCKETNUM=8	

# Query parallelism, currently maximum 20.  
QUERY_STREAMS=1                                     

# Insert parallelism (Load Data).  
INSERT_STREAMS=8                    

# if ISGENDATA equal 0 then the test not generate data else need generate data.   
ISGENDATA=0                                                 
```
### Run test
```shell
sh runall-gpload.sh
```
### Only generate data
```shell
sh gen_data.sh
```
### Only load data
```shell
set tpch.config ISGENDATA=0

sh reload-gpload.sh 
```
### Only run query
```shell
sh queries.sh
```
### Delete generated data
```shell
sh deletefile.sh
```
