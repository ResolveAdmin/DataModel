-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-05-02 10:11:34 BST
--   site:      Oracle Database 21c
--   type:      Oracle Database 21c



-- predefined type, no DDL - SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE res_action_step (
    id                    INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    change_action_plan_id INTEGER NOT NULL,
    step_id               INTEGER NOT NULL,
    create_user_id        INTEGER NOT NULL,
    create_date           TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_action_step ADD CONSTRAINT res_action_step_pk PRIMARY KEY ( id );

CREATE TABLE res_business_area (
    id                 INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    business_area_name VARCHAR2(100) NOT NULL,
    business_area_desc VARCHAR2(1000)
)
LOGGING;

ALTER TABLE res_business_area ADD CONSTRAINT res_business_area_pk PRIMARY KEY ( id );

CREATE TABLE res_business_function (
    id                     INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    business_function_name VARCHAR2(100) NOT NULL,
    business_function_desc VARCHAR2(1000)
)
LOGGING;

ALTER TABLE res_business_function ADD CONSTRAINT res_business_function_pk PRIMARY KEY ( id );

CREATE TABLE res_capa (
    id             INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    incident_id    INTEGER NOT NULL,
    status_id      INTEGER NOT NULL,
    status_date    DATE DEFAULT sysdate NOT NULL,
    create_user_id INTEGER NOT NULL,
    create_date    TIMESTAMP DEFAULT systimestamp,
    update_user_id INTEGER,
    update_date    TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_capa ADD CONSTRAINT res_capa_pk PRIMARY KEY ( id );

CREATE TABLE res_capa_action (
    id              INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    capa_id         INTEGER NOT NULL,
    corrective_desc VARCHAR2(1000),
    preventive_desc VARCHAR2(1000),
    due_date        DATE DEFAULT sysdate
)
LOGGING;

ALTER TABLE res_capa_action ADD CONSTRAINT res_capa_action_pk PRIMARY KEY ( id );

CREATE TABLE res_capa_step (
    id             INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    capa_id        INTEGER NOT NULL,
    step_id        INTEGER NOT NULL,
    create_user_id INTEGER NOT NULL,
    create_date    TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_capa_step ADD CONSTRAINT res_capa_step_pk PRIMARY KEY ( id );

CREATE TABLE res_change_action_plan (
    id                    INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    change_request_id     INTEGER NOT NULL,
    status_id             INTEGER NOT NULL,
    status_date           DATE DEFAULT sysdate NOT NULL,
    due_date              DATE DEFAULT sysdate,
    action_desc           VARCHAR2(1000) NOT NULL,
    is_req_effective_date CHAR(1) DEFAULT 'Y' NOT NULL
)
LOGGING;

ALTER TABLE res_change_action_plan
    ADD CHECK ( is_req_effective_date IN ( 'N', 'Y' ) );

ALTER TABLE res_change_action_plan ADD CONSTRAINT res_change_action_plan_pk PRIMARY KEY ( id );

CREATE TABLE res_change_impact (
    id                     INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    change_request_id      INTEGER NOT NULL,
    business_function_id   INTEGER NOT NULL,
    impact_type            CHAR(1) DEFAULT 'I',
    impact_assessment_desc VARCHAR2(1000) NOT NULL,
    risk_assessment_desc   VARCHAR2(1000) NOT NULL,
    not_doing_desc         VARCHAR2(1000) NOT NULL
)
LOGGING;

ALTER TABLE res_change_impact
    ADD CHECK ( impact_type IN ( 'C', 'I', 'J' ) );

ALTER TABLE res_change_impact ADD CONSTRAINT res_change_impact_pk PRIMARY KEY ( id );

CREATE TABLE res_change_request (
    id                    INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    status_id             INTEGER NOT NULL,
    status_date           DATE DEFAULT sysdate NOT NULL,
    implementation_date   DATE DEFAULT sysdate NOT NULL,
    effective_date        DATE DEFAULT sysdate NOT NULL,
    change_type           CHAR(1) NOT NULL,
    current_process_desc  VARCHAR2(1000) NOT NULL,
    proposed_process_desc VARCHAR2(1000) NOT NULL
)
LOGGING;

ALTER TABLE res_change_request
    ADD CHECK ( change_type IN ( 'P', 'T' ) );

ALTER TABLE res_change_request ADD CONSTRAINT res_change_request_pk PRIMARY KEY ( id );

CREATE TABLE res_change_step (
    id                INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    change_request_id INTEGER NOT NULL,
    step_id           INTEGER NOT NULL,
    create_user_id    INTEGER NOT NULL,
    create_date       TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_change_step ADD CONSTRAINT res_change_step_pk PRIMARY KEY ( id );

CREATE TABLE res_comment (
    id               INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    comment_text     VARCHAR2(1000) NOT NULL,
    create_user_id   INTEGER NOT NULL,
    create_date      TIMESTAMP DEFAULT systimestamp,
    capa_step_id     INTEGER,
    incident_step_id INTEGER,
    action_step_id   INTEGER,
    change_step_id   INTEGER
)
LOGGING;

ALTER TABLE res_comment ADD CONSTRAINT res_comment_pk PRIMARY KEY ( id );

CREATE TABLE res_department (
    id              INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    department_name VARCHAR2(100) NOT NULL,
    department_desc VARCHAR2(1000)
)
LOGGING;

ALTER TABLE res_department ADD CONSTRAINT res_department_pk PRIMARY KEY ( id );

CREATE TABLE res_incident (
    id                 INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    title              VARCHAR2(250) NOT NULL,
    status_id          INTEGER NOT NULL,
    status_date        DATE DEFAULT sysdate NOT NULL,
    business_area_id   INTEGER NOT NULL,
    department_id      INTEGER NOT NULL,
    capa_id            NUMBER,
    due_date           DATE DEFAULT sysdate,
    impact_type        CHAR(1) DEFAULT 'I',
    tags               VARCHAR2(1000),
    what_desc          VARCHAR2(1000),
    when_desc          VARCHAR2(1000),
    where_desc         VARCHAR2(1000),
    which_desc         VARCHAR2(1000),
    how_desc           VARCHAR2(1000),
    full_desc          VARCHAR2(1000),
    man_desc           VARCHAR2(1000),
    machine_desc       VARCHAR2(1000),
    material_desc      VARCHAR2(1000),
    mother_nature_desc VARCHAR2(1000),
    measurement_desc   VARCHAR2(1000),
    method_desc        VARCHAR2(1000),
    rootcause_desc     VARCHAR2(1000)
)
LOGGING;

ALTER TABLE res_incident
    ADD CHECK ( impact_type IN ( 'C', 'I', 'J' ) );

ALTER TABLE res_incident ADD CONSTRAINT res_incident_pk PRIMARY KEY ( id )
    USING INDEX;

CREATE TABLE res_incident_attachment (
    id             INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    incident_id    INTEGER NOT NULL,
    file_name      VARCHAR2(100),
    file_desc      VARCHAR2(1000),
    file_obj       BLOB,
    tags           VARCHAR2(1000),
    create_user_id INTEGER NOT NULL,
    create_date    TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_incident_attachment ADD CONSTRAINT res_incident_attachment_pk PRIMARY KEY ( id );

CREATE TABLE res_incident_impact (
    id                INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    incident_id       INTEGER NOT NULL,
    assessment_type   CHAR(1) NOT NULL,
    risk_impact_value INTEGER,
    severity_value    INTEGER,
    probability_value INTEGER,
    detection_value   INTEGER,
    create_user_id    INTEGER NOT NULL,
    create_date       TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_incident_impact
    ADD CHECK ( assessment_type IN ( 'Q', 'R', 'S' ) );

ALTER TABLE res_incident_impact ADD CHECK ( risk_impact_value BETWEEN 1 AND 5 );

ALTER TABLE res_incident_impact ADD CHECK ( severity_value BETWEEN 1 AND 5 );

ALTER TABLE res_incident_impact ADD CHECK ( probability_value BETWEEN 1 AND 5 );

ALTER TABLE res_incident_impact ADD CHECK ( detection_value BETWEEN 1 AND 5 );

ALTER TABLE res_incident_impact ADD CONSTRAINT res_incident_impact_pk PRIMARY KEY ( id );

CREATE TABLE res_incident_step (
    id             INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    incident_id    INTEGER NOT NULL,
    step_id        INTEGER NOT NULL,
    create_user_id INTEGER NOT NULL,
    create_date    TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_incident_step ADD CONSTRAINT res_incident_step_pk PRIMARY KEY ( id );

CREATE TABLE res_log (
    id                    INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    incident_id           INTEGER,
    change_request_id     INTEGER,
    change_action_plan_id INTEGER,
    capa_id               INTEGER,
    log_text              VARCHAR2(100) NOT NULL,
    create_user_id        INTEGER NOT NULL,
    create_date           TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_log ADD CONSTRAINT res_log_pk PRIMARY KEY ( id );

CREATE TABLE res_notification (
    id                INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    log_id            INTEGER NOT NULL,
    notification_text VARCHAR2(100) NOT NULL,
    notified_user_id  INTEGER NOT NULL,
    notified_date     TIMESTAMP DEFAULT systimestamp
)
LOGGING;

ALTER TABLE res_notification ADD CONSTRAINT res_notification_pk PRIMARY KEY ( id );

CREATE TABLE res_role (
    id        INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    role_name VARCHAR2(100) NOT NULL,
    role_desc VARCHAR2(1000)
)
LOGGING;

ALTER TABLE res_role ADD CONSTRAINT res_role_pk PRIMARY KEY ( id );

CREATE TABLE res_status (
    id          INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    status_type CHAR(1) NOT NULL,
    status_name VARCHAR2(100) NOT NULL,
    status_desc VARCHAR2(1000),
    is_active   CHAR(1) DEFAULT 'N' NOT NULL
)
LOGGING;

ALTER TABLE res_status
    ADD CHECK ( status_type IN ( 'A', 'C', 'I', 'P' ) );

ALTER TABLE res_status
    ADD CHECK ( is_active IN ( 'N', 'Y' ) );

ALTER TABLE res_status ADD CONSTRAINT res_incident_status_pk PRIMARY KEY ( id );

CREATE TABLE res_step (
    id        INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    step_type CHAR(1) NOT NULL,
    status_id INTEGER NOT NULL,
    step_name VARCHAR2(100) NOT NULL,
    step_desc VARCHAR2(1000),
    step_seq  INTEGER DEFAULT 0 NOT NULL
)
LOGGING;

ALTER TABLE res_step
    ADD CHECK ( step_type IN ( 'A', 'C', 'I', 'P' ) );

ALTER TABLE res_step ADD CONSTRAINT res_step_pk PRIMARY KEY ( id );

ALTER TABLE res_step ADD CONSTRAINT res_step_step_seq_un UNIQUE ( step_seq );

CREATE TABLE res_step_role (
    id      INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    step_id INTEGER NOT NULL,
    role_id INTEGER NOT NULL
)
LOGGING;

ALTER TABLE res_step_role ADD CONSTRAINT res_step_role_pk PRIMARY KEY ( id );

CREATE TABLE res_supplier (
    id            INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    supplier_name VARCHAR2(100) NOT NULL,
    supplier_desc VARCHAR2(1000)
)
LOGGING;

ALTER TABLE res_supplier ADD CONSTRAINT res_supplier_pk PRIMARY KEY ( id );

CREATE TABLE res_tag (
    id        INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    tag_text  VARCHAR2(100) NOT NULL,
    tag_count INTEGER NOT NULL
)
LOGGING;

ALTER TABLE res_tag ADD CONSTRAINT res_tag_pk PRIMARY KEY ( id );

CREATE TABLE res_user (
    id         INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    user_name  VARCHAR2(100) NOT NULL,
    user_email VARCHAR2(100)
)
LOGGING;

ALTER TABLE res_user ADD CONSTRAINT res_user_pk PRIMARY KEY ( id );

CREATE TABLE res_user_business_function (
    id                   INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    user_id              INTEGER NOT NULL,
    business_function_id INTEGER NOT NULL
)
LOGGING;

ALTER TABLE res_user_business_function ADD CONSTRAINT res_user_business_function_pk PRIMARY KEY ( id );

CREATE TABLE res_user_role (
    id      INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    role_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL
)
LOGGING;

ALTER TABLE res_user_role ADD CONSTRAINT res_user_role_pk PRIMARY KEY ( id );

ALTER TABLE res_action_step
    ADD CONSTRAINT res_action_step_res_change_action_plan_fk FOREIGN KEY ( change_action_plan_id )
        REFERENCES res_change_action_plan ( id )
    NOT DEFERRABLE;

ALTER TABLE res_action_step
    ADD CONSTRAINT res_action_step_res_step_fk FOREIGN KEY ( step_id )
        REFERENCES res_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_action_step
    ADD CONSTRAINT res_action_step_res_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_capa_action
    ADD CONSTRAINT res_capa_action_res_capa_fk FOREIGN KEY ( capa_id )
        REFERENCES res_capa ( id )
    NOT DEFERRABLE;

ALTER TABLE res_capa
    ADD CONSTRAINT res_capa_res_create_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_capa
    ADD CONSTRAINT res_capa_res_incident_fk FOREIGN KEY ( incident_id )
        REFERENCES res_incident ( id )
    NOT DEFERRABLE;

ALTER TABLE res_capa
    ADD CONSTRAINT res_capa_res_status_fk FOREIGN KEY ( status_id )
        REFERENCES res_status ( id )
    NOT DEFERRABLE;

ALTER TABLE res_capa
    ADD CONSTRAINT res_capa_res_update_user_fk FOREIGN KEY ( update_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_capa_step
    ADD CONSTRAINT res_capa_step_res_capa_fk FOREIGN KEY ( capa_id )
        REFERENCES res_capa ( id )
    NOT DEFERRABLE;

ALTER TABLE res_capa_step
    ADD CONSTRAINT res_capa_step_res_step_fk FOREIGN KEY ( step_id )
        REFERENCES res_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_capa_step
    ADD CONSTRAINT res_capa_step_res_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_change_action_plan
    ADD CONSTRAINT res_change_action_plan_res_change_request_fk FOREIGN KEY ( change_request_id )
        REFERENCES res_change_request ( id )
    NOT DEFERRABLE;

ALTER TABLE res_change_action_plan
    ADD CONSTRAINT res_change_action_plan_res_status_fk FOREIGN KEY ( status_id )
        REFERENCES res_status ( id )
    NOT DEFERRABLE;

ALTER TABLE res_change_impact
    ADD CONSTRAINT res_change_impact_res_business_function_fk FOREIGN KEY ( business_function_id )
        REFERENCES res_business_function ( id )
    NOT DEFERRABLE;

ALTER TABLE res_change_impact
    ADD CONSTRAINT res_change_impact_res_change_request_fk FOREIGN KEY ( change_request_id )
        REFERENCES res_change_request ( id )
    NOT DEFERRABLE;

ALTER TABLE res_change_request
    ADD CONSTRAINT res_change_request_res_status_fk FOREIGN KEY ( status_id )
        REFERENCES res_status ( id )
    NOT DEFERRABLE;

ALTER TABLE res_change_step
    ADD CONSTRAINT res_change_step_res_change_request_fk FOREIGN KEY ( change_request_id )
        REFERENCES res_change_request ( id )
    NOT DEFERRABLE;

ALTER TABLE res_change_step
    ADD CONSTRAINT res_change_step_res_step_fk FOREIGN KEY ( step_id )
        REFERENCES res_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_change_step
    ADD CONSTRAINT res_change_step_res_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_comment
    ADD CONSTRAINT res_comment_res_action_step_fk FOREIGN KEY ( action_step_id )
        REFERENCES res_action_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_comment
    ADD CONSTRAINT res_comment_res_capa_step_fk FOREIGN KEY ( capa_step_id )
        REFERENCES res_capa_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_comment
    ADD CONSTRAINT res_comment_res_change_step_fk FOREIGN KEY ( change_step_id )
        REFERENCES res_change_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_comment
    ADD CONSTRAINT res_comment_res_incident_step_fk FOREIGN KEY ( incident_step_id )
        REFERENCES res_incident_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_comment
    ADD CONSTRAINT res_comment_res_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident_attachment
    ADD CONSTRAINT res_incident_attachment_res_incident_fk FOREIGN KEY ( incident_id )
        REFERENCES res_incident ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident_attachment
    ADD CONSTRAINT res_incident_attachment_res_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident_impact
    ADD CONSTRAINT res_incident_impact_res_incident_fk FOREIGN KEY ( incident_id )
        REFERENCES res_incident ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident_impact
    ADD CONSTRAINT res_incident_impact_res_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident
    ADD CONSTRAINT res_incident_res_business_area_fk FOREIGN KEY ( business_area_id )
        REFERENCES res_business_area ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident
    ADD CONSTRAINT res_incident_res_department_fk FOREIGN KEY ( department_id )
        REFERENCES res_department ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident
    ADD CONSTRAINT res_incident_res_incident_status_fk FOREIGN KEY ( status_id )
        REFERENCES res_status ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident_step
    ADD CONSTRAINT res_incident_step_res_incident_fk FOREIGN KEY ( incident_id )
        REFERENCES res_incident ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident_step
    ADD CONSTRAINT res_incident_step_res_step_fk FOREIGN KEY ( step_id )
        REFERENCES res_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_incident_step
    ADD CONSTRAINT res_incident_step_res_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_log
    ADD CONSTRAINT res_log_res_capa_fk FOREIGN KEY ( capa_id )
        REFERENCES res_capa ( id )
    NOT DEFERRABLE;

ALTER TABLE res_log
    ADD CONSTRAINT res_log_res_change_action_plan_fk FOREIGN KEY ( change_action_plan_id )
        REFERENCES res_change_action_plan ( id )
    NOT DEFERRABLE;

ALTER TABLE res_log
    ADD CONSTRAINT res_log_res_change_request_fk FOREIGN KEY ( change_request_id )
        REFERENCES res_change_request ( id )
    NOT DEFERRABLE;

ALTER TABLE res_log
    ADD CONSTRAINT res_log_res_incident_fk FOREIGN KEY ( incident_id )
        REFERENCES res_incident ( id )
    NOT DEFERRABLE;

ALTER TABLE res_log
    ADD CONSTRAINT res_log_res_user_fk FOREIGN KEY ( create_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_notification
    ADD CONSTRAINT res_notification_res_log_fk FOREIGN KEY ( log_id )
        REFERENCES res_log ( id )
    NOT DEFERRABLE;

ALTER TABLE res_notification
    ADD CONSTRAINT res_notification_res_user_fk FOREIGN KEY ( notified_user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_step
    ADD CONSTRAINT res_step_res_status_fk FOREIGN KEY ( status_id )
        REFERENCES res_status ( id )
    NOT DEFERRABLE;

ALTER TABLE res_step_role
    ADD CONSTRAINT res_step_role_res_role_fk FOREIGN KEY ( role_id )
        REFERENCES res_role ( id )
    NOT DEFERRABLE;

ALTER TABLE res_step_role
    ADD CONSTRAINT res_step_role_res_step_fk FOREIGN KEY ( step_id )
        REFERENCES res_step ( id )
    NOT DEFERRABLE;

ALTER TABLE res_user_business_function
    ADD CONSTRAINT res_user_business_function_res_business_function_fk FOREIGN KEY ( business_function_id )
        REFERENCES res_business_function ( id )
    NOT DEFERRABLE;

ALTER TABLE res_user_business_function
    ADD CONSTRAINT res_user_business_function_res_user_fk FOREIGN KEY ( user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;

ALTER TABLE res_user_role
    ADD CONSTRAINT res_user_role_res_role_fk FOREIGN KEY ( role_id )
        REFERENCES res_role ( id )
    NOT DEFERRABLE;

ALTER TABLE res_user_role
    ADD CONSTRAINT res_user_role_res_user_fk FOREIGN KEY ( user_id )
        REFERENCES res_user ( id )
    NOT DEFERRABLE;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            27
-- CREATE INDEX                             0
-- ALTER TABLE                             88
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
