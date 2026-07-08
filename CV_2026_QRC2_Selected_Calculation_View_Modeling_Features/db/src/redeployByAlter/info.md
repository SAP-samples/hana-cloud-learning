# [Replace Instead of Drop and Recreate During Redeployment](https://help.sap.com/docs/hana-cloud-database/sap-hana-cloud-sap-hana-database-performance-guide-for-developers/optimized-redeployment-of-calculation-views)

By default, calculation views are dropped and recreated during redeployment. Dropping a calculation view also removes all privileges associated with it:

- **Privileges defined in HDI roles of the same HDI container** are reassigned automatically at the end of deployment.
- **Privileges in roles outside the current HDI container** that directly reference the calculation view are **not** reassigned automatically, resulting in a permanent loss of access.

In addition to the privilege loss risk, the drop-and-recreate cycle adds deployment time due to privilege revocation and regrant operations. This overhead is especially pronounced when multiple objects reference the redeployed calculation view.

## Replace Option

The replace option substitutes the drop-and-recreate cycle with an in-place replacement of the calculation view. Because the object is never dropped, existing privileges are preserved throughout deployment.

The benefit is most significant when combined with [optimized redeployment](../optimizedRedeployment/info.md): without optimized redeployment, dependent calculation views are dropped before the root view is redeployed, so they never reach the replace step. With both options enabled, the replacement strategy applies to the dependent views as well.

## Enabling Replace Option

To enable the replace behavior for calculation views, pass the following parameter to the `hdi-deploy` command in `package.json`:

```text
--parameter optimized_replace=true
```

The resulting `start` script in `package.json`:

```json
"start": "node node_modules/@sap/hdi-deploy/deploy.js --parameter optimized_replace=true"
```
> Use this option together with the optimized redeployment option to preserve privileges on the redeployed calculation view and to speed up redeployment