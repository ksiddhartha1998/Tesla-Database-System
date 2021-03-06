DROP TABLE :-
DROP TABLE VEHICLE_TYPE2;
DROP TABLE VEHICLE_TYPE3;
DROP TABLE EMPLOYEE2;
DROP TABLE PLANT2;
DROP TABLE PLANT_ORDER;
DROP TABLE PARTS;
DROP TABLE PROCESSED_BY;
DROP TABLE CONTAINS;
DROP TABLE PARTS_LOG;
DROP TABLE VEHICLE_TYPE1;
DROP TABLE SUPPLIER;
DROP TABLE VEHICLE;
DROP TABLE PLANT_PART_ORDER;
DROP TABLE ORDERS;
DROP TABLE PLANT1;
DROP TABLE EMPLOYEE1;
DROP TABLE CUSTOMER;

CREATE TABLE :-

CREATE TABLE VEHICLE_TYPE2(
MODEL_NAME VARCHAR(10),
ENGINE VARCHAR(20) NOT NULL,
BRAKE VARCHAR(20) NOT NULL,
CONSTRAINT PK_VEHICLE_TYPE2
PRIMARY KEY(MODEL_NAME));

CREATE TABLE VEHICLE_TYPE3(
ENGINE VARCHAR(20),
GEAR VARCHAR(20),
CONSTRAINT PK_VEHICLE_TYPE3
PRIMARY KEY(ENGINE));

CREATE TABLE EMPLOYEE1(
EMPLOYEE_ID VARCHAR(10),
DESIGNATION VARCHAR(20),
RATING INT,
SUPERVISOR_ID VARCHAR(10),
FIRST_NAME VARCHAR(20) NOT NULL,
LAST_NAME VARCHAR(20),
ADDRESS VARCHAR(50),
PHONE_NUMBER INT,
GENDER VARCHAR(10),
SALARY INT,
CONSTRAINT PK_EMPLOYEE1
PRIMARY KEY(EMPLOYEE_ID),
CONSTRAINT CHECK_EMPLOYEE_GENDER
CHECK(GENDER IN('MALE','FEMALE','UNKNOWN')),
CONSTRAINT FK_EMPLOYEE1
FOREIGN KEY(SUPERVISOR_ID) REFERENCES EMPLOYEE1(EMPLOYEE_ID) ON DELETE SET NULL);

CREATE TABLE EMPLOYEE2(
DESIGNATION VARCHAR(20),
RATING INT,
SALARY_INCREMENT INT,
CONSTRAINT PK_EMPLOYEE2
PRIMARY KEY(DESIGNATION,RATING),
CONSTRAINT CHECK_EMPLOYEE_RATING
CHECK(RATING IN(0,1,2,3,4,5)));

CREATE TABLE CUSTOMER(
CUSTOMER_ID VARCHAR(10),
EMAIL VARCHAR(50) NOT NULL,
FIRST_NAME VARCHAR(20) NOT NULL,
LAST_NAME VARCHAR(20),
ADDRESS VARCHAR(50),
PHONE_NUMBER INT,
GENDER VARCHAR(10),
CONSTRAINT PK_CUSTOMER
PRIMARY KEY(CUSTOMER_ID),
CONSTRAINT CHECK_CUSTOMER_GENDER
CHECK(GENDER IN('MALE','FEMALE','UNKNOWN')));

CREATE TABLE PLANT1(
PLANT_ID VARCHAR(10),
PLANT_LOCATION VARCHAR(20) NOT NULL,
MANAGER_ID VARCHAR(10),
CONSTRAINT PK_PLANT1
PRIMARY KEY(PLANT_ID));

CREATE TABLE PLANT2(
PLANT_LOCATION VARCHAR(20),
PLANT_NAME VARCHAR(20) UNIQUE,
CONSTRAINT PK_PLANT2
PRIMARY KEY(PLANT_LOCATION));

CREATE TABLE SUPPLIER(
SUPPLIER_ID VARCHAR(10),
SUPPLIER_NAME VARCHAR(20) NOT NULL,
ADDRESS VARCHAR(50),
PHONE_NUMBER INT,
CONSTRAINT PK_SUPPLIER
PRIMARY KEY(SUPPLIER_ID));

CREATE TABLE VEHICLE(
VEHICLE_ID VARCHAR(10),
MODEL_NAME VARCHAR(10) NOT NULL,
EXTERIOR_COLOR VARCHAR(20) NOT NULL,
INTERIOR_COLOR VARCHAR(20) NOT NULL,
WHEELS VARCHAR(20) NOT NULL,
AUTOPILOT_KIT VARCHAR(20) NOT NULL,
PLANT_ID VARCHAR(10),
CONSTRAINT PK_VEHICLE
PRIMARY KEY(VEHICLE_ID),
CONSTRAINT FK_VEHICLE_PLANT1
FOREIGN KEY(PLANT_ID) REFERENCES PLANT1(PLANT_ID));

CREATE TABLE PLANT_ORDER(
PLANT_ORDER_ID VARCHAR(10),
MODEL_NAME VARCHAR(10) NOT NULL,
EXTERIOR_COLOR VARCHAR(20) NOT NULL,
INTERIOR_COLOR VARCHAR(20) NOT NULL,
WHEELS VARCHAR(20) NOT NULL,
AUTOPILOT_KIT VARCHAR(20) NOT NULL,
STATUS VARCHAR(20),
PLANT_ID VARCHAR(10),
CONSTRAINT PK_PLANT_ORDER
PRIMARY KEY(PLANT_ORDER_ID),
CONSTRAINT FK_PLANT_ORDER_PLANT1
FOREIGN KEY(PLANT_ID) REFERENCES PLANT1(PLANT_ID) ON DELETE CASCADE);

CREATE TABLE PLANT_PART_ORDER(
PLANT_PART_ORDER_ID VARCHAR(10),
PART_NAME VARCHAR(20) NOT NULL,
PLANT_ID VARCHAR(10),
CONSTRAINT PK_PLANT_PART_ORDER
PRIMARY KEY(PLANT_PART_ORDER_ID),
CONSTRAINT FK_PLANT_PART_ORDER_PLANT1
FOREIGN KEY(PLANT_ID) REFERENCES PLANT1(PLANT_ID) ON DELETE CASCADE);

CREATE TABLE PARTS(
PART_ID VARCHAR(10),
PART_NAME VARCHAR(20) NOT NULL,
PLANT_ID VARCHAR(10),
SUPPLIER_ID VARCHAR(10),
VEHICLE_ID VARCHAR(10),
CONSTRAINT PK_PARTS
PRIMARY KEY(PART_ID),
CONSTRAINT FK_PARTS_PLANT1
FOREIGN KEY(PLANT_ID) REFERENCES PLANT1(PLANT_ID) ON DELETE CASCADE,
CONSTRAINT FK_PARTS_SUPPLIER
FOREIGN KEY(SUPPLIER_ID) REFERENCES SUPPLIER(SUPPLIER_ID) ON DELETE CASCADE,
CONSTRAINT FK_PARTS_VEHICLE
FOREIGN KEY(VEHICLE_ID) REFERENCES VEHICLE(VEHICLE_ID) ON DELETE CASCADE);

CREATE TABLE PROCESSED_BY(
PLANT_PART_ORDER_ID VARCHAR(10),
SUPPLIER_ID VARCHAR(10),
STATUS VARCHAR(20),
CONSTRAINT PK_PROCESSED_BY
PRIMARY KEY(PLANT_PART_ORDER_ID, SUPPLIER_ID),
CONSTRAINT FK_PROCESSED_BY_PLANTPARTORDER
FOREIGN KEY(PLANT_PART_ORDER_ID) REFERENCES
PLANT_PART_ORDER(PLANT_PART_ORDER_ID) ON DELETE CASCADE,
CONSTRAINT FK_PROCESSED_BY_SUPPLIER
FOREIGN KEY(SUPPLIER_ID) REFERENCES SUPPLIER(SUPPLIER_ID) ON DELETE CASCADE);

CREATE TABLE PARTS_LOG(
PART_ID VARCHAR(10),
PART_NAME VARCHAR(20),
PLANT_ID VARCHAR(10),
SUPPLIER_ID VARCHAR(10),
VEHICLE_ID VARCHAR(10));

CREATE TABLE ORDERS(
ORDER_ID VARCHAR(10),
MODEL_NAME VARCHAR(10) NOT NULL,
EXTERIOR_COLOR VARCHAR(20) NOT NULL,
INTERIOR_COLOR VARCHAR(20) NOT NULL,
WHEELS VARCHAR(20) NOT NULL,
AUTOPILOT_KIT VARCHAR(20) NOT NULL,
PAYMENT_DETAILS VARCHAR(50) NOT NULL,
STATUS VARCHAR(20),
EMPLOYEE_ID VARCHAR(10),
PLANT_ID VARCHAR(10),
VEHICLE_ID VARCHAR(10),
CUSTOMER_ID VARCHAR(10),
CONSTRAINT PK_ORDER
PRIMARY KEY(ORDER_ID),
CONSTRAINT FK_ORDER_EMPLOYEE1
FOREIGN KEY(EMPLOYEE_ID) REFERENCES EMPLOYEE1(EMPLOYEE_ID) ON DELETE SET NULL,
CONSTRAINT FK_ORDER_PLANT1
FOREIGN KEY(PLANT_ID) REFERENCES PLANT1(PLANT_ID) ON DELETE SET NULL,
CONSTRAINT FK_ORDER_CUSTOMER
FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE);

CREATE TABLE VEHICLE_TYPE1(
MODEL_NAME VARCHAR(10),
EXTERIOR_COLOR VARCHAR(20),
INTERIOR_COLOR VARCHAR(20),
WHEELS VARCHAR(20),
AUTOPILOT_KIT VARCHAR(20),
CONSTRAINT K_VEHICLE_TYPE1
PRIMARY KEY(MODEL_NAME,EXTERIOR_COLOR,INTERIOR_COLOR,WHEELS,AUTOPILOT_KIT));

CREATE TABLE CONTAINS(
PLANT_ID VARCHAR(10),
MODEL_NAME VARCHAR(10) ,
EXTERIOR_COLOR VARCHAR(20),
INTERIOR_COLOR VARCHAR(20),
WHEELS VARCHAR(20),
AUTOPILOT_KIT VARCHAR(20),
CONSTRAINT PK_CONTAINS
PRIMARY KEY(PLANT_ID, MODEL_NAME, EXTERIOR_COLOR, INTERIOR_COLOR, WHEELS,
AUTOPILOT_KIT),
CONSTRAINT FK_CONTAINS_PLANT1
FOREIGN KEY(PLANT_ID) REFERENCES PLANT1(PLANT_ID) ON DELETE CASCADE,
CONSTRAINT FK_CONTAINS_VEHICLE_TYPE1
FOREIGN KEY(MODEL_NAME,EXTERIOR_COLOR, INTERIOR_COLOR, WHEELS, AUTOPILOT_KIT)
REFERENCES VEHICLE_TYPE1(MODEL_NAME,EXTERIOR_COLOR,INTERIOR_COLOR,WHEELS,
AUTOPILOT_KIT) ON DELETE CASCADE);

INSERT :-
INSERT INTO SUPPLIER VALUES('S1','JOHN','DALLAS',4698765531);
INSERT INTO SUPPLIER VALUES('S2','SHERLOCK','RICHARDSON',4698765876);
INSERT INTO SUPPLIER VALUES('S3','HOLMES','PLANO',4698765432);
INSERT INTO SUPPLIER VALUES('S4','GOKUL','IRVING',4691455543);
INSERT INTO SUPPLIER VALUES('S5','PRAVEEN','FRISCO',4698769543);

INSERT INTO EMPLOYEE1(EMPLOYEE_ID,DESIGNATION,RATING,FIRST_NAME,LAST_NAME,ADDRESS,
PHONE_NUMBER,GENDER,SALARY) VALUES('E1','SUPERVISOR',0,'PRAVEEN','TANGARAJAN','DALLAS',4698765432,'MALE',60000);
INSERT INTO EMPLOYEE1 VALUES('E2','MANAGER',0,'E1','SHANMUGA','PRIYAN','RICHARDSON',4698765886,'MALE',70000);
INSERT INTO EMPLOYEE1(EMPLOYEE_ID,DESIGNATION,RATING,FIRST_NAME,LAST_NAME,ADDRESS,
PHONE_NUMBER,GENDER,SALARY) VALUES('E3','SUPERVISOR',0,'THIAGARAJAN','RAVICHANDRAN','PLANO',4698765878,'MALE',80000);
INSERT INTO EMPLOYEE1 VALUES('E4','MANAGER',0,'E2','NAVEEN','JAKUVA','FRISCO',4698764536,'MALE',80000);
INSERT INTO EMPLOYEE1
VALUES('E5','TECH SUPPORT',0,'E1','SARAVANA','PRABAKAR','DALLAS',4698844536,'MALE',90000);
INSERT INTO EMPLOYEE1
VALUES('E6','SUPPORT SPECIALIST',0,'E2','VIGNESH','RAVI','PLANO',4699064536,'MALE',80000);
INSERT INTO EMPLOYEE1
VALUES('E7','SUPPORT ENGINEER',0,'E1','ROHIT','ADITHYA','DALLAS',4698064536,'MALE',80000);

INSERT INTO EMPLOYEE2 VALUES('MANAGER',1,3000);
INSERT INTO EMPLOYEE2 VALUES('MANAGER',2,4000);
INSERT INTO EMPLOYEE2 VALUES('MANAGER',3,5000);
INSERT INTO EMPLOYEE2 VALUES('MANAGER',4,6000);
INSERT INTO EMPLOYEE2 VALUES('MANAGER',5,7000);
INSERT INTO EMPLOYEE2 VALUES('SUPERVISOR',1,1000);
INSERT INTO EMPLOYEE2 VALUES('SUPERVISOR',2,2000);
INSERT INTO EMPLOYEE2 VALUES('SUPERVISOR',3,3000);
INSERT INTO EMPLOYEE2 VALUES('SUPERVISOR',4,4000);
INSERT INTO EMPLOYEE2 VALUES('SUPERVISOR',5,5000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT ENGINEER',1,2000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT ENGINEER',2,3000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT ENGINEER',3,4000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT ENGINEER',4,5000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT ENGINEER',5,6000);
INSERT INTO EMPLOYEE2 VALUES('TECH SUPPORT',1,4000);
INSERT INTO EMPLOYEE2 VALUES('TECH SUPPORT',2,5000);
INSERT INTO EMPLOYEE2 VALUES('TECH SUPPORT',3,6000);
INSERT INTO EMPLOYEE2 VALUES('TECH SUPPORT',4,7000);
INSERT INTO EMPLOYEE2 VALUES('TECH SUPPORT',5,8000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT SPECIALIST',1,2000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT SPECIALIST',2,4000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT SPECIALIST',3,6000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT SPECIALIST',4,8000);
INSERT INTO EMPLOYEE2 VALUES('SUPPORT SPECIALIST',5,10000);

INSERT INTO CUSTOMER VALUES('C1','SHANMUGA@GMAIL.COM','SHANMUGA','SUNDARAM','PLANO',4698765432,'MALE');
INSERT INTO CUSTOMER VALUES('C2','PRIYA@GMAIL.COM','PRIYA','SANKAR','RICHARDSON',4698707432,'FEMALE');
INSERT INTO CUSTOMER VALUES('C3','SANKAR@GMAIL.COM','SANKAR','RAVI','DALLAS',4698105432,'MALE');
INSERT INTO CUSTOMER VALUES('C4','SANKARI@GMAIL.COM','SANKARI','SUNDARAM','FRISCO',4698701432,'FEMALE');
INSERT INTO CUSTOMER VALUES('C5','SHRUTI@GMAIL.COM','SHRUTI','SHANMUGA','PLANO',4698791432,'FEMALE');
INSERT INTO CUSTOMER VALUES('C6','PARKAVI@GMAIL.COM','PARKAVI','PRIYAN','PLANO',4698791156,'FEMALE');
INSERT INTO CUSTOMER VALUES('C7','NITHYA@GMAIL.COM','NITHYA','KRISHNAN','RICHARDSON',4698791891,'FEMALE');
INSERT INTO CUSTOMER VALUES('C8','RAM@GMAIL.COM','RAM','SHANMUGA','FRISCO',4698791516,'MALE');

INSERT INTO VEHICLE_TYPE1 VALUES('MODEL X','BLUE','VIOLET','STEEL WHEELS','AUTOPILOT_YES');
INSERT INTO VEHICLE_TYPE1
VALUES('MODEL 3','BLACK','CYAN','ALLOYS WHEELS','AUTOPILOT_NO');
INSERT INTO VEHICLE_TYPE1 VALUES('MODEL S','WHITE','GREY','MULTI PIECE','AUTOPILOT_YES');
INSERT INTO VEHICLE_TYPE1 VALUES('MODEL X','BLUE','GREY','FORGED WHEELS','AUTOPILOT_NO');
INSERT INTO VEHICLE_TYPE1
VALUES('MODEL S','BLACK','VIOLET','STEEL WHEELS','AUTOPILOT_NO');

INSERT INTO VEHICLE_TYPE2 VALUES('MODEL X','INLINE ENGINE','ELECTROMAGNETIC');
INSERT INTO VEHICLE_TYPE2 VALUES('MODEL 3','ROTARY ENGINE','SERVO BRAKE');
INSERT INTO VEHICLE_TYPE2 VALUES('MODEL S','VR AND W ENGINE','MECHANICAL BRAKE');

INSERT INTO VEHICLE_TYPE3 VALUES('INLINE ENGINE','HELICAL GEAR');
INSERT INTO VEHICLE_TYPE3 VALUES('ROTARY ENGINE','MITER GEAR');
INSERT INTO VEHICLE_TYPE3 VALUES('VR AND W ENGINE','BEVEL GEAR');

INSERT INTO PLANT1 VALUES('P1','FRISCO','E2');
INSERT INTO PLANT1 VALUES('P2','PLANO','E1');
INSERT INTO PLANT1 VALUES('P3','RICHARDSON','E2');
INSERT INTO PLANT1 VALUES('P4','DALLAS','E1');
INSERT INTO PLANT1 VALUES('P5','FORT WORTH','E2');

INSERT INTO PLANT2 VALUES('DALLAS','DALLAS PLANT');
INSERT INTO PLANT2 VALUES('PLANO','PLANO PLANT');
INSERT INTO PLANT2 VALUES('FRISCO','FRISCO PLANT');
INSERT INTO PLANT2 VALUES('RICHARDSON','RICHARDSON PLANT');
INSERT INTO PLANT2 VALUES('FORT WORTH','FORT WORTH PLANT');

INSERT INTO VEHICLE
VALUES('V1','MODEL X','WHITE','VIOLET','ALLOY WHEELS','AUTOPILOT_YES','P1');
INSERT INTO VEHICLE
VALUES('V2','MODEL 3','BLACK','CYAN','FORGED WHEELS','AUTOPILOT_NO','P2');
INSERT INTO VEHICLE VALUES('V3','MODEL S','BLUE','GREY','MULTI PIECE','AUTOPILOT_YES','P1');
INSERT INTO VEHICLE VALUES('V4','MODEL 3','WHITE','VIOLET','STEEL WHEELS','AUTOPILOT_NO','P4');
INSERT INTO VEHICLE VALUES('V5','MODEL S','BLUE','CYAN','ALLOY WHEELS','AUTOPILOT_YES','P5');
INSERT INTO VEHICLE VALUES('V8','MODEL S','BLUE','GREY','MULTI PIECE','AUTOPILOT_YES','P3');
INSERT INTO VEHICLE VALUES('V9','MODEL 3','WHITE','VIOLET','STEEL WHEELS','AUTOPILOT_NO','P4');

INSERT INTO PLANT_ORDER
VALUES('PO1','MODEL X','WHITE','VIOLET','ALLOY WHEELS','AUTOPILOT_YES','IN-PROGRESS','P1');
INSERT INTO PLANT_ORDER
VALUES('PO2','MODEL 3','BLACK','CYAN','FORGED WHEELS','AUTOPILOT_NO','IN-PROGRESS','P2');
INSERT INTO PLANT_ORDER
VALUES('PO3','MODEL S','BLUE','GREY','MULTI PIECE','AUTOPILOT_YES','DELIVERED','P3');
INSERT INTO PLANT_ORDER
VALUES('PO4','MODEL 3','WHITE','VIOLET','STEEL WHEELS','AUTOPILOT_NO','DELIVERED','P4');
INSERT INTO PLANT_ORDER
VALUES('PO5','MODEL X','WHITE','CYAN','FORGED WHEELS','AUTOPILOT_YES','','P5');
INSERT INTO PLANT_ORDER
VALUES('PO6','MODEL S','BLUE','GREY','STEEL WHEELS','AUTOPILOT_NO','IN-PROGRESS','P2');
INSERT INTO PLANT_ORDER
VALUES('PO7','MODEL X','BLUE','GREY','OEM-STYLE','AUTOPILOT_NO','IN-PROGRESS','P4');

INSERT INTO ORDERS
VALUES('O1','MODEL 3','WHITE','VIOLET','STEEL WHEELS','AUTOPILOT_NO','PAID','IN-PROGRESS',
'E6','P4','','C2');
INSERT INTO ORDERS
VALUES('O2','MODEL S','BLUE','CYAN','ALLOY WHEELS','AUTOPILOT_YES','HALF PAID','IN-PROGRESS',
'E6','P5','','C5');
INSERT INTO ORDERS
VALUES('O3','MODEL X','BLACK','GREY','STEEL WHEELS','AUTOPILOT_YES','PAID','DELIVERED',
'E7','P1','V7','C3');
INSERT INTO ORDERS
VALUES('O4','MODEL 3','WHITE','CYAN','FORGED WHEELS','AUTOPILOT_NO','PAID','DELIVERED',
'E6','P2','V6','C4');
INSERT INTO ORDERS
VALUES('O5','MODEL 3','WHITE','GREY','MULTI PIECE','AUTOPILOT_NO','HALF PAID','IN PROGRESS',
'E6','P4','','C8');
INSERT INTO ORDERS
VALUES('O6','MODEL X','BLUE','CYAN','MULTI PIECE','AUTOPILOT_NO','PAID','IN PROGRESS',
'E7','P3','','C6');
INSERT INTO ORDERS
VALUES('O7','MODEL S','BLACK','GREY','FORGED WHEELS','AUTOPILOT_NO','HALF PAID','','E6','P2','','C7');

INSERT INTO PLANT_PART_ORDER VALUES('PPO1','GREY','P4');
INSERT INTO PLANT_PART_ORDER VALUES('PPO2','BLACK','P2');
INSERT INTO PLANT_PART_ORDER VALUES('PPO3','FORGED WHEELS','P4');
INSERT INTO PLANT_PART_ORDER VALUES('PPO4','STEEL WHEELS','P4');
INSERT INTO PLANT_PART_ORDER VALUES('PPO5','INLINE ENGINE','P2');
INSERT INTO PLANT_PART_ORDER VALUES('PPO6','SERVO BRAKE','P1');
INSERT INTO PLANT_PART_ORDER VALUES('PPO7','ROTARY ENGINE','P2');

INSERT INTO PARTS VALUES('PART1','WHITE','P4','S1','');
INSERT INTO PARTS VALUES('PART2','VIOLET','P4','S2','');
INSERT INTO PARTS VALUES('PART3','STEEL WHEELS','P4','S5','');
INSERT INTO PARTS VALUES('PART4','AUTOPILOT_NO','P4','S3','');
INSERT INTO PARTS VALUES('PART5','BLUE','P5','S4','');
INSERT INTO PARTS VALUES('PART6','CYAN','P5','S1','');
INSERT INTO PARTS VALUES('PART7','ALLOY WHEELS','P5','S2','');
INSERT INTO PARTS VALUES('PART8','AUTOPILOT_YES','P5','S5','');
INSERT INTO PARTS VALUES('PART9','VR AND W ENGINE','P1','S4','');
INSERT INTO PARTS VALUES('PART10','MECHANICAL BRAKE','P2','S1','');
INSERT INTO PARTS VALUES('PART11','BEVEL GEAR','P3','S3','');

INSERT INTO PARTS_LOG VALUES('PART1','BLACK','P1','S2','V7');
INSERT INTO PARTS_LOG VALUES('PART2','GREY','P1','S4','V7');
INSERT INTO PARTS_LOG VALUES('PART3','STEEL WHEELS','P1','S5','V7');
INSERT INTO PARTS_LOG VALUES('PART4','AUTOPILOT_YES','P1','S1','V7');
INSERT INTO PARTS_LOG VALUES('PART5','WHITE','P2','S1','V6');
INSERT INTO PARTS_LOG VALUES('PART6','CYAN','P2','S3','V6');
INSERT INTO PARTS_LOG VALUES('PART7','FORGED WHEELS','P2','S5','V6');
INSERT INTO PARTS_LOG VALUES('PART8','AUTOPILOT_NO','P2','S1','V6');
INSERT INTO PARTS_LOG VALUES('PART9','BLUE','P3','S4','V8');
INSERT INTO PARTS_LOG VALUES('PART10','GREY','P3','S3','V8');
INSERT INTO PARTS_LOG VALUES('PART11','MULTI PIECE','P3','S1','V8');
INSERT INTO PARTS_LOG VALUES('PART12','AUTOPILOT_YES','P3','S2','V8');
INSERT INTO PARTS_LOG VALUES('PART13','WHITE','P4','S3','V9');
INSERT INTO PARTS_LOG VALUES('PART14','VIOLET','P4','S5','V9');
INSERT INTO PARTS_LOG VALUES('PART15','STEEL WHEELS','P4','S1','V9');
INSERT INTO PARTS_LOG VALUES('PART16','AUTOPILOT_NO','P4','S2','V9');

INSERT INTO CONTAINS VALUES('P1','MODEL X','BLUE','VIOLET','STEEL WHEELS','AUTOPILOT_YES');
INSERT INTO CONTAINS VALUES('P2','MODEL 3','BLACK','CYAN','ALLOYS WHEELS','AUTOPILOT_NO');
INSERT INTO CONTAINS VALUES('P5','MODEL S','WHITE','GREY','MULTI PIECE','AUTOPILOT_YES');
INSERT INTO CONTAINS VALUES('P2','MODEL X','BLUE','GREY','FORGED WHEELS','AUTOPILOT_NO');
INSERT INTO CONTAINS VALUES('P3','MODEL S','BLACK','VIOLET','STEEL WHEELS','AUTOPILOT_NO');

INSERT INTO PROCESSED_BY VALUES('PPO1','S2','DELIVERED');
INSERT INTO PROCESSED_BY VALUES('PPO2','S4','IN-PROGRESS');
INSERT INTO PROCESSED_BY VALUES('PPO3','S3','IN-PROGRESS');
INSERT INTO PROCESSED_BY VALUES('PPO4','S2','');
INSERT INTO PROCESSED_BY VALUES('PPO5','S1','');

SELECT TABLE :-
SELECT * FROM VEHICLE_TYPE1;
SELECT * FROM VEHICLE_TYPE2;
SELECT * FROM VEHICLE_TYPE3;
SELECT * FROM EMPLOYEE1;
SELECT * FROM EMPLOYEE2;
SELECT * FROM PLANT1;
SELECT * FROM PLANT2;
SELECT * FROM PLANT_ORDER;
SELECT * FROM PARTS;
SELECT * FROM PROCESSED_BY;
SELECT * FROM CONTAINS;
SELECT * FROM PARTS_LOG;
SELECT * FROM SUPPLIER;
SELECT * FROM VEHICLE;
SELECT * FROM PLANT_PART_ORDER;
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER;