# [Option to Store Combinations of Input Parameter Values at Loading Time](https://help.sap.com/docs/hana-cloud-database/sap-hana-cloud-sap-hana-database-administration-guide/api-for-managing-mds-cubes)

It is now possible to materialize MDS Cube data for different combinations of input parameter values at MDS Cube loading time. This provides the flexibility to use input parameters at reporting time.
The combinations of input parameter values that should be stored have to be explicitly listed. 

Input Parameters used in currency/unit conversion don't require materialization with mode *Query Execution*.

Ensure that all potential input parameter value combinations that are relevant for reporting are covered at loading time. Queries will fail if their input parameter value combinations have not been materialized.

> Use option to allow choosing between several input parameter values at query runtime
