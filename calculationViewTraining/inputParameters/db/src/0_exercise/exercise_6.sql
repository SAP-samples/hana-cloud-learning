/** Exercise 6 **/
-- last operator shows that the TUDF could not be unfolded
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.solution::TF_PRODUCT_DATA_MVIP_STT"('0301090555,0301012010');

-- complete unfolding here, no blocker in explain plan
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.solution::tf_products_mvip_apply_filter"('0301090555,0301012010');

/** STUDENT QUERY **/
-- by default, no filtering is taking place
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.exercise::tf_products_mvip_apply_filter"('0301090555,0301012010');