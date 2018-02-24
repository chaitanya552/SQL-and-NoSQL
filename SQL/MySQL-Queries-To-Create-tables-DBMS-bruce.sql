CREATE TABLE EMPLOYEE (
    Fname VARCHAR(50) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(50) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(100),
    Sex VARCHAR(1),
    salary DECIMAL(10 , 2 ),
    Super_ssn CHAR(9),
    Dno INT NOT NULL,
    PRIMARY KEY (Ssn)
);

insert into EMPLOYEE values('John','B','Smith','123456789',STR_TO_DATE('1965-01-09', '%Y-%m-%d'),'731 Fondren, Houston, TX' ,'M',30000,'333445555',5);

insert into EMPLOYEE values('Franklin','T','Wong','333445555',STR_TO_DATE('1955-12-08','%Y-%m-%d'),'638 Voss, Houston, TX' ,'M',40000,'888665555',5);
insert into EMPLOYEE values('Alicia','J','Zelaya','999887777',STR_TO_DATE('1968-01-19','%Y-%m-%d'),'3321 Castle, Spring, TX' ,'F',25000,'987654321',4);
insert into EMPLOYEE values('Jennifer','S','Wallace','987654321',STR_TO_DATE('1941-06-20','%Y-%m-%d'),'291 Berry, Bellaire ,TX' ,'F',43000,'888665555',4);
insert into EMPLOYEE values('Ramesh','K','Narayan','666884444',STR_TO_DATE('1962-09-15','%Y-%m-%d'),'975 Fire Oak, Humble,TX' ,'M',38000,'333445555',5);
insert into EMPLOYEE values('Joyce','A','English','453453453',STR_TO_DATE('1972-07-31','%Y-%m-%d'),'5631 Rice, Houston ,TX' ,'F',25000,'333445555',5);
insert into EMPLOYEE values('Ahmad','V','Jabbar','987987987',STR_TO_DATE('1969-03-29','%Y-%m-%d'),'980 Dallas, Houston ,TX' ,'M',25000,'987654321',4);
insert into EMPLOYEE values('James','E','Borg','888665555',STR_TO_DATE('1937-11-10','%Y-%m-%d'),'450 Stone, Houston ,TX' ,'M',55000,NULL,1);





CREATE TABLE DEPARTMENT (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    PRIMARY KEY (Dnumber),
    UNIQUE (Dname),
    FOREIGN KEY (Mgr_ssn)
        REFERENCES EMPLOYEE (Ssn)
);

insert into DEPARTMENT values('Research',5,'333445555',STR_TO_DATE('1988-05-22','%Y-%m-%d'));
insert into DEPARTMENT values('Administration',4,'987654321',STR_TO_DATE('1995-01-01','%Y-%m-%d'));
insert into DEPARTMENT values('Headquarters',1,'888665555',STR_TO_DATE('1981-06-19','%Y-%m-%d'));

SELECT * FROM EMPLOYEE;


CREATE TABLE DEPT_LOCATIONS
( Dnumber INT NOT NULL,
Dlocation VARCHAR(15) NOT NULL,
PRIMARY KEY (Dnumber, Dlocation),
FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber) );

#Insert:

insert into DEPT_LOCATIONS values(1,'Houston');
insert into DEPT_LOCATIONS values(4,'Stafford');
insert into DEPT_LOCATIONS values(5,'Bellaire');
insert into DEPT_LOCATIONS values(5,'Sugarland');
insert into DEPT_LOCATIONS values(5,'Houston');

#PROJECT
#Create:

CREATE TABLE PROJECT
( Pname    VARCHAR(15)  NOT NULL,
Pnumber    INT          NOT NULL,
Plocation  VARCHAR(15), 
Dnum       INT			NOT NULL,
PRIMARY KEY (Pnumber),
UNIQUE (Pname),
FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber));

#Insert:

insert into PROJECT values('ProductX',1,'Bellaire',5);
insert into PROJECT values('ProductY',2,'Sugarland',5);
insert into PROJECT values('ProductZ',3,'Houston',5);
insert into PROJECT values('Computerization',10,'Stafford',4);
insert into PROJECT values('Reorganization',20,'Houston',1);
insert into PROJECT values('Newbenefits',30,'Stafford',4);

#WORKS_ON
#Create:

CREATE TABLE WORKS_ON
( Essn  CHAR(9)       NOT NULL,
Pno     INT           NOT NULL,
Hours   DECIMAL(3,1)  ,
PRIMARY KEY (Essn, Pno),
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber) );

#Insert:

insert into WORKS_ON values('123456789',1,32.5);
insert into WORKS_ON values('123456789',2,7.5);
insert into WORKS_ON values('666884444',3,40.0);
insert into WORKS_ON values('453453453',1,20.0);
insert into WORKS_ON values('453453453',2,20.0);
insert into WORKS_ON values('333445555',2,10.0);
insert into WORKS_ON values('333445555',3,10.0);
insert into WORKS_ON values('333445555',10,10.0);
insert into WORKS_ON values('333445555',20,10.0);
insert into WORKS_ON values('999887777',30,30.0);
insert into WORKS_ON values('999887777',10,10.0);
insert into WORKS_ON values('987987987',10,35.0);
insert into WORKS_ON values('987987987',30,5.0);
insert into WORKS_ON values('987654321',30,20.0);
insert into WORKS_ON values('987654321',20,15.0);
insert into WORKS_ON values('888665555',20,null);


#DEPENDENT
#Create:

CREATE TABLE DEPENDENT
( Essn			CHAR(9)       NOT NULL,
Dependent_name  VARCHAR(15)   NOT NULL,
Sex             CHAR,
Bdate           DATE,
Relationship    VARCHAR(8),
PRIMARY KEY (Essn, Dependent_name),
FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn) );




insert into DEPENDENT values('333445555','Alice','F',STR_TO_DATE('1986-04-05','%Y-%m-%d'),'Daughter');
insert into DEPENDENT values('333445555','Theodore','M',STR_TO_DATE('1983-10-25','%Y-%m-%d'),'Son');
insert into DEPENDENT values('333445555','Joy','F',STR_TO_DATE('1958-05-03','%Y-%m-%d'),'Spouse');
insert into DEPENDENT values('987654321','Abner','M',STR_TO_DATE('1942-02-28','%Y-%m-%d'),'Spouse');
insert into DEPENDENT values('123456789','Michael','M',STR_TO_DATE('1988-01-04','%Y-%m-%d'),'Son');

insert into DEPENDENT values('123456789','Alice','F',STR_TO_DATE('1988-12-30','%Y-%m-%d'),'Daughter');
insert into DEPENDENT values('123456789','Elizabeth','F',STR_TO_DATE('1967-05-05','%Y-%m-%d'),'Spouse');

SELECT * FROM DEPENDENT
