/** Exercise 5 **/
-- Call table function with comma-seperated string list and get a table back with the list values.
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.solution::TF_SPLIT_STRING"('4712,4711');

-- Call table function which takes a comma-seperated string list and applies this filter to a calculation view
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.solution::TF_PRODUCT_DATA_MVIP_STT"('0301090555,0301012010');

/** STUDENT QUERY **/
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.exercise::TF_SPLIT_STRING"('4712,4711');

SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.exercise::TF_PRODUCT_DATA_MVIP_STT"('0301090555,0301012010');