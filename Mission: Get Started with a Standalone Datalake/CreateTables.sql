
/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
create table TPCH.CUSTOMER (
   C_CUSTKEY            integer                        not null iq unique (150000),
   C_NAME               varchar(25)                    not null,
   C_ADDRESS            varchar(40)                    not null,
   C_NATIONKEY          integer                        not null iq unique (25),
   C_PHONE              char(15)                       not null,
   C_ACCTBAL            decimal(15,2)                  not null,
   C_MKTSEGMENT         char(10)                       not null,
   C_COMMENT            varchar(117)                   not null,
   constraint PK_CUSTOMER primary key (C_CUSTKEY)
);


/*==============================================================*/
/* Table: NATION                                                */
/*==============================================================*/
create table TPCH.NATION (
   N_NATIONKEY          integer                        not null iq unique (25),
   N_NAME               char(25)                       not null,
   N_REGIONKEY          integer                        not null iq unique (5),
   N_COMMENT            varchar(152)                   not null,
   constraint PK_NATION primary key (N_NATIONKEY)
);


/*==============================================================*/
/* Table: REGION                                                */
/*==============================================================*/
create table TPCH.REGION (
   R_REGIONKEY          integer                        not null iq unique (5),
   R_NAME               char(25)                       not null,
   R_COMMENT            varchar(152)                   not null,
   constraint PK_REGION primary key (R_REGIONKEY)
);


/*==============================================================*/
/* Table: SUPPLIER                                              */
/*==============================================================*/
create table TPCH.SUPPLIER (
   S_SUPPKEY            integer                        not null iq unique (10000),
   S_NAME               char(25)                       not null,
   S_ADDRESS            varchar(40)                    not null,
   S_NATIONKEY          integer                        not null iq unique (25),
   S_PHONE              char(15)                       not null,
   S_ACCTBAL            decimal(15,2)                  not null,
   S_COMMENT            varchar(101)                   not null,
   constraint PK_SUPPLIER primary key (S_SUPPKEY)
);

alter table TPCH.CUSTOMER
   add foreign key FK_CUSTOMER_REFERENCE_NATION (C_NATIONKEY)
      references TPCH.NATION (N_NATIONKEY)
      on delete restrict on update restrict;

alter table TPCH.NATION
   add foreign key FK_NATION_REFERENCE_REGION (N_REGIONKEY)
      references TPCH.REGION (R_REGIONKEY)
      on delete restrict on update restrict;

alter table TPCH.SUPPLIER
   add foreign key FK_SUPPLIER_REFERENCE_NATION (S_NATIONKEY)
      references TPCH.NATION (N_NATIONKEY)
      on delete restrict on update restrict;

