-- entities
CREATE TABLE COMPILATION_UNIT ( ID INT, NAME VARCHAR, PACKAGE VARCHAR );
CREATE TABLE PACKAGE     ( ID INT, NAME VARCHAR UNIQUE);
CREATE TABLE TYPE        ( ID INT, NAME VARCHAR, IS_PUBLIC INT, IS_STATIC INT, IS_FINAL INT, IS_ABSTRACT INT, IS_CLASS INT, IS_INTERFACE INT, IS_ENUMERATION INT, IS_ANNOTATION INT, CU_ID INT, FOREIGN KEY(CU_ID) REFERENCES COMPILATION_UNIT(ID));
CREATE TABLE FIELD       ( ID INT, NAME VARCHAR, TYPE VARCHAR, IS_PUBLIC INT, IS_STATIC INT, IS_FINAL INT, IS_TRANSIENT INT, TYPE_ID INT, FOREIGN KEY(TYPE_ID) REFERENCES TYPE(ID));
CREATE TABLE METHOD      ( ID INT, NAME VARCHAR, IS_PUBLIC INT, IS_STATIC INT, IS_FINAL INT, IS_ABSTRACT INT, IS_CONSTRUCTOR INT, TYPE_ID INT, FOREIGN KEY(TYPE_ID) REFERENCES TYPE(ID) );
CREATE TABLE PARAMETER   ( ID INT, NAME VARCHAR, TYPE VARCHAR, METHOD_ID INT, FOREIGN KEY(METHOD_ID) REFERENCES METHOD(ID));

-- type views
CREATE VIEW CLASS       AS SELECT ID, NAME, IS_PUBLIC, IS_STATIC, IS_FINAL, IS_ABSTRACT, CU_ID FROM TYPE WHERE IS_CLASS = 1;
CREATE VIEW INTERFACE   AS SELECT ID, NAME, IS_PUBLIC, CU_ID FROM TYPE WHERE IS_INTERFACE = 1;
CREATE VIEW ENUMERATION AS SELECT ID, NAME, IS_PUBLIC, CU_ID FROM TYPE WHERE IS_ENUMERATION = 1;
CREATE VIEW ANNOTATION  AS SELECT ID, NAME, IS_PUBLIC, CU_ID FROM TYPE WHERE IS_ANNOTATION = 1;

-- method views
CREATE VIEW CONSTRUCTOR AS SELECT ID, NAME, IS_PUBLIC, TYPE_ID FROM METHOD WHERE IS_CONSTRUCTOR = 1;

-- relations
CREATE TABLE EXTENDS ( TYPE_ID INT, EXTENDED_TYPE_ID INT, PRIMARY KEY (TYPE_ID, EXTENDED_TYPE_ID));
CREATE TABLE IMPLEMENTS ( CLASS_ID INT, IMPLEMENTED_INTERFACE_ID INT, PRIMARY KEY (CLASS_ID, IMPLEMENTED_INTERFACE_ID) );