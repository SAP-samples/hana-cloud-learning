/** Exercise 4 **/
-- will return data only for PURCHASEORDERID = 0301090555, as previously defined in CV_PRODUCT_DATA.
SELECT * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.tf.solution::TF_PRODUCT_DATA_MVIP_MAPPED"('0301090555','0301012012','0301012013');

--1. Empty if not provided (default)
select * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.modelling.solution::CV_PRODUCT_DATA_MVIP"
	(placeholder."$$IP_PURCHASEORDERID$$"=>'''''');
	
--2. Returns result filtered for list of values
select * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.modelling.solution::CV_PRODUCT_DATA_MVIP"
	(placeholder."$$IP_PURCHASEORDERID$$"=>'''0301090555'',''0301012010''')

/** STUDENT QUERY **/
select * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.modelling.exercise::CV_PRODUCT_DATA_MVIP"
	(placeholder."$$IP_PURCHASEORDERID$$"=>'''0301090555'',''0301012010''');

select * FROM "EPM_DEMO_DATA_FOUNDATION"."dl.df.epm_demo.modelling.exercise::CV_PRODUCT_DATA_MVIP"
	(placeholder."$$IP_PURCHASEORDERID$$"=>'''''');