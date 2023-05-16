/** Exercise 3 **/
-- will return all data, input parameter exists but it's default is set to ''
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.solution::TF_PRODUCT_DATA_IP_MAPPED"();

-- will return data only for PURCHASEORDERID = 0301090555, as previously defined in CV_PRODUCT_DATA.
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.solution::TF_PRODUCT_DATA_IP_MAPPED"('0301090555');

/** STUDENT QUERY **/
-- will return all data, input parameter exists but it's default is set to ''
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.exercise::TF_PRODUCT_DATA_IP_MAPPED"();

-- will return data only for PURCHASEORDERID = 0301090555, as previously defined in CV_PRODUCT_DATA.
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.exercise::TF_PRODUCT_DATA_IP_MAPPED"('0301090555');