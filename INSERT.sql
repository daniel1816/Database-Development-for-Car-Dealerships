--adding data into tables
INSERT INTO CUST VALUES
	('ABC-0001','Bryant','Kobe','41234','Fairfax Street',NULL,'Fairfax','VA', 20101, '987654321', '05-06-1988'),
	('ABC-0002','James','Lebron','12345','Sterling Street',NULL,'Sterling','VA', 20102, '456123789', '05-04-1989'),
	('ABC-0003','Nash','Steve','15932','Maryland Street',NULL,'Gaithersburg','MD', 20103, '456321987', '05-03-1980'),
	('ABC-0004','Kidd','Jason','71462','Washington Street',NULL,'Washington','DC', 20001, '123654789', '05-02-1995'),
	('ABC-0005','Wang','Emma','45632','Tysons Street',NULL,'Tysons Corner','VA', 20005, '321456987', '05-01-1970');


INSERT INTO DEALER VALUES
	('001A','Daniel LLC','41816','New York Steet',NULL,'Fairfax','VA',20165,'02-20-2021'),
	('002A','Jackons LLC','12356','New Jersey Steet',NULL,'Sterling','VA',20164,'07-20-2021'),
	('003A','Micheal and sons LLC','51816','Lindsay Steet',NULL,'Gaithersbury','MD',20103,'03-20-2018'),
	('004A','SuperCar LLC','21816','Lucky Steet',NULL,'Fairfax','VA',20145,'04-20-2021'),
	('005A','CarCash LLC','31816','Arlington Steet',NULL,'Arlington','VA',20185,'08-20-2017');

INSERT INTO VEHICLE VALUES
	('001ABCD','2018','Honda','Civic','LX','03-14-2018','$20,000'),
	('002ABCD','2019','Volkswagen','Jetta','GLX','2019-3-31','$19,000'),
	('003ABCD','2017','Toyota','RAV4','LX','2017-03-14','$30,000'),
	('004ABCD','2021','Tesla','Model Y','LX','2021-03-14','$50,000'),
	('005ABCD','2018','Ford','Mustang','LX','2018-05-01','$35,000');

INSERT INTO INVENTORY VALUES
	('A100001','001A','XYZ00001','U','2-14-2021','2-20-2021','2-21-2021','$21,000','Black','White','001ABCD','0'),
	('B100002','002A','XYZ00002','U','2-14-2021','2-20-2021', NULL,'$20,000','White','White','002ABCD','1'),
	('C100003','003A','XYZ00003','U','2-14-2021','2-20-2021', NULL,'$31,000','Red','White','003ABCD','1'),
	('D100004','004A','XYZ00004','N','2-14-2021','2-20-2021', NULL,'$50,000','Blue','White','004ABCD','1'),
	('F100005','005A','XYZ00005','U','2-20-2021','2-20-2021', NULL,'$30,000','Black','White','005ABCD','1');

INSERT INTO NEWVEH VALUES
	('D100004','$50,000','$49,000','2021-03-14');

INSERT INTO USEDVEH VALUES
	('A100001','1-10-2020','$15,000','1258','$14,000','1'),
	('B100002','11-08-2020','$13,000','3336','$12,000','1'),
	('C100003','12-1-2020','$25,000','48580','$29,000','0'),
	('F100005','2-1-2021','$25,000','15000','$28000','0')

INSERT INTO TESTDRIVE VALUES
	('T060620','ABC-0005','06-06-2020','21','A100001'),
	('T050520','ABC-0004','05-05-2020','22','D100004'),
	('T041220','ABC-0003','04-12-2020','23','D100004'),
	('T060520','ABC-0002','06-05-2020','24','C100003'),
	('T010520','ABC-0001','01-05-2020','25','A100001')

INSERT INTO SALES VALUES
	('A100001','ABC-0001','$21,000','05-05-2020','$1,260','C'),
	('B100002','ABC-0005','$20,000','05-06-2020','$1,200','L'),
	('C100003','ABC-0004','$19,500','05-07-2020','$1,170','F'),
	('D100004','ABC-0003','$37,000','05-15-2020','$2,220','F'),
	('F100005','ABC-0002','$33,000','05-25-2020','$1,980','O')

INSERT INTO AVAILOPTIONS VALUES
	('O001','$100','$110','Package1','001ABCD'),
	('O002','$200','$220','Package2','002ABCD'),
	('O003','$300','$330','Package3','003ABCD'),
	('O004','$400','$440','Package4','004ABCD'),
	('O005','$500','$550','Package5','005ABCD')

INSERT INTO SERVREC VALUES
	('SVC0001','ABC-0002','','','','','','','',''),
	('SVC0002','ABC-0003','','','','','','','',''),
	('SVC0003','ABC-0004','','','','','','','',''),
	('SVC0004','ABC-0001','','','','','','','',''),
	('SVC0005','ABC-0005','','','','','','','',''),