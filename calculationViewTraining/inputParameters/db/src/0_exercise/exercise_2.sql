/** Exercise 2 **/
-- will return all data*
SELECT PURCHASEORDERID
FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.modelling.solution::CV_PRODUCT_DATA_EMPTY_IP"
	(placeholder."$$IP_PURCHASEORDERID$$"=>'');
	
-- will return data only for PURCHASEORDERID = 0301090555
SELECT PURCHASEORDERID
FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.modelling.solution::CV_PRODUCT_DATA_EMPTY_IP"
	(placeholder."$$IP_PURCHASEORDERID$$"=>'0301090555');

/** STUDENT QUERY **/
-- FILTER EXPRESSION: "PURCHASEORDERID" = IFNULL(NULLIF('$$IP_PURCHASEORDERID$$', ''),"PURCHASEORDERID")	

-- if this does return 0 rows, go back to the model and in the filter expression tab - click "APPLY CHANGES"
SELECT PURCHASEORDERID
FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.modelling.exercise::CV_PRODUCT_DATA_EMPTY_IP"
	(placeholder."$$IP_PURCHASEORDERID$$"=>'');
	
SELECT PURCHASEORDERID
FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.modelling.exercise::CV_PRODUCT_DATA_EMPTY_IP"
	(placeholder."$$IP_PURCHASEORDERID$$"=>'0301090555');