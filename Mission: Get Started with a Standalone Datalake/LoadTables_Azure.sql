/* Create an S3 bucket in AWS */
/* Change the following variables: <azure_container_name>, <azure_connection_string> */

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
from 'BB://<azure_container_name>/region.tbl'
CONNECTION_STRING '<azure_connection_string>'
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
from 'BB://<azure_container_name>/nation.tbl'
CONNECTION_STRING '<azure_connection_string>'
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
from 'BB://<azure_container_name>/supplier.tbl'
CONNECTION_STRING '<azure_connection_string>'
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
from 'BB://<azure_container_name>/customer.tbl'
CONNECTION_STRING '<azure_connection_string>'
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

