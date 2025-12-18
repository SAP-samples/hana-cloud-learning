# Column Lineage

Function [SYS.GET_CALC_VIEW_COLUMN_DEPENDENCIES](https://help.sap.com/docs/hana-cloud-database/sap-hana-cloud-sap-hana-database-modeling-guide-for-sap-business-application-studio/using-built-in-table-function-to-analyze-column-lineage) returns the base columns of individual calculation view columns. With this it becomes easy to track, for example, from which table a certain measure is coming to increase the insight into the behavior of the calculation view.

## Parameters

The parameters of the SQL function are: 
- schema name of the calculation view to analyze
- the calculation view name
- the column to track or an empty string 
- a literal to control the output details of the function. Currently only 'BASE' is available

\<schema_name\>, \<calculation view name\>, \<column name\> | '', 'BASE'

If the column name is left empty (''), all columns are treated as target columns.
Currently only the option BASE is available which omits intermediate objects and reports the underlying tables only.

## Authorizations
The caller requires system privilege CATALOG READ

## Example Call

```SQL
SELECT
    TARGET_VIEW_NAME,
    TARGET_COLUMN_NAME,
    BASE_OBJECT_NAME,
    BASE_COLUMN_NAME
FROM
    SYS.GET_CALC_VIEW_COLUMN_DEPENDENCIES(current_schema,'layer2','','BASE');
```

**TARGET\_VIEW\_NAME**|**TARGET\_COLUMN\_NAME**|**BASE\_OBJECT\_NAME**|**BASE\_COLUMN\_NAME**
:-----:|:-----|:-----:|:-----:
layer2|TCL1\_M|tcL1|TCL1\_M
layer2|tcL1\_c1|tcL1|tcL1\_c1
layer2|tcL1\_c4|tcL1|tcL1\_c4
layer2|tclRenamed3\_M|tcL3|TCL3\_M
layer2|tclRenamed3\_c1|tcL3|tcL3\_c1
layer2|tclRenamed3\_c3Renamed|tcL3|tcL3\_c3
layer2|tclRenamed1\_M|tcL1|TCL1\_M
layer2|tclRenamed1\_c1|tcL1|tcL1\_c1
layer2|tclRenamed1\_c4|tcL1|tcL1\_c4
    

## Limitations
Tracking is blocked by table functions and procedures

> Trace the origin of columns with this function