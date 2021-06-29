/* Create an S3 bucket in AWS */
/* Change the following variables: <your_bucket_name>, <your_access_key_id>, <your_secret_access_key>, <your_aws_region> */

set temporary option escape_character='on'
go
set temporary option date_order='ymd'
go
set temporary option date_format='YYYY-MM-DD'
go

truncate table TPCH.REGION;
commit;

load table TPCH.REGION (
R_REGIONKEY,
R_NAME,
R_COMMENT
)
from 's3://<your_bucket_name>/region.tbl'
ACCESS_KEY_ID '<your_access_key_id>'
SECRET_ACCESS_KEY '<your_secret_access_key>' 
REGION '<your_aws_region>'
quotes off
escapes off
format ascii
delimited by '|'
row delimited by '\n'
;
commit
;
rollback
;

truncate table TPCH.NATION;
commit;

load table TPCH.NATION (
   N_NATIONKEY,
   N_NAME,
   N_REGIONKEY,
   N_COMMENT
)
from 's3://<your_bucket_name>/nation.tbl'
ACCESS_KEY_ID '<your_access_key_id>'
SECRET_ACCESS_KEY '<your_secret_access_key>' 
REGION '<your_aws_region>'
quotes off
escapes off
format ascii
delimited by '|'
row delimited by '\n'
;
commit
;
rollback
;

truncate table TPCH.SUPPLIER;
commit;

load table TPCH.SUPPLIER (
   S_SUPPKEY,
   S_NAME,
   S_ADDRESS,
   S_NATIONKEY,
   S_PHONE,
   S_ACCTBAL,
   S_COMMENT
)
from 's3://<your_bucket_name>/supplier.tbl'
ACCESS_KEY_ID '<your_access_key_id>'
SECRET_ACCESS_KEY '<your_secret_access_key>' 
REGION '<your_aws_region>'
quotes off
escapes off
format ascii
delimited by '|'
row delimited by '\n'
;
commit
;
rollback
;

truncate table TPCH.CUSTOMER;
commit;

load table TPCH.CUSTOMER (
   C_CUSTKEY,
   C_NAME,
   C_ADDRESS,
   C_NATIONKEY,
   C_PHONE,
   C_ACCTBAL,
   C_MKTSEGMENT,
   C_COMMENT            
)
from 's3://<your_bucket_name>/customer.tbl'
ACCESS_KEY_ID '<your_access_key_id>'
SECRET_ACCESS_KEY '<your_secret_access_key>' 
REGION '<your_aws_region>'
quotes off
escapes off
format ascii
delimited by '|'
row delimited by '\n'
;
commit
;
rollback
;
