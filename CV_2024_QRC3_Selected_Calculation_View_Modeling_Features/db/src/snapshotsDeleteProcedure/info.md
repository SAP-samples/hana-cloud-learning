# [Snapshot Delete Procedure](https://help.sap.com/docs/hana-cloud-database/sap-hana-cloud-sap-hana-database-modeling-guide-for-sap-business-application-studio/create-snapshots?)

When deploying a calculation view with a snapshot query definition, procedure SELECTIVE_DELETION is generated that allows selective deletion of snapshot table entries based on an expression that is passed to the procedure. 

To delete e.g. all entries with timestamps older than 10 days based on the snapshot query column "snapshot date" the following call can be used:

```SQL
CALL "sDP_cv/Query_1/SNAP/SNAPSHOT/SELECTIVE_DELETION"(FILTERSTRING => '"snapshot date"<add_days(now(),-10)')
```

