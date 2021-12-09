
--creating tables
CREATE TABLE CUST(

	[customer number] char(8) not null, 
	[last name] varchar(20) not null,
	[first name] varchar(20) not null,
	[street number] char(5) not null,
	[street line 1] varchar(200) not null,
	[street line 2] varchar(200) null, 
	[city] varchar(50) not null,
	[state] char(2) not null,
	[zip code] char(5) null ,
	[drivers license] char(10) not null ,
	[date of birth] date null 
);

CREATE TABLE DEALER (
	[dealer number] char(4) not null, 
	[dealer name] varchar(30) not null, 
	[street number] char(5) not null,
	[street line 1] varchar(200) not null,
	[street line 2] varchar(200) null ,
	[city] varchar(50) not null,
	[state] char(2) not null,
	[zip code] char(5) null, 
	[open date] date not null 
);

CREATE TABLE VEHICLE (
	[vehicle code] char(7) not null,
	[year] char(4) not null,
	[make] varchar(15) not null,
	[model] varchar(15) null, 
	[trim line] varchar(4) null ,
	[date model introduced] date not null,
	[msrp] smallmoney not null
);

CREATE TABLE INVENTORY(
	[Inventory code] char(7) not null, 
	[dealer number] char(4) not null,
	[vin number] char(17) not null,
	[new or used] char(1) not null,
	[date arrived at dealership] date not null,
	[date available in stock] date null ,
	[date sold] date null ,
	[listed price] smallmoney not null,
	[exterior color] varchar(10) not null,
	[interior color] varchar(10) not null,
	[vehicle code] char(7) not null,
	[available for sale] bit not null
);

CREATE TABLE NEWVEH (
	[inventory code] char(7) not null, 
	[msrp] smallmoney not null,
	[invoice price] smallmoney not null,
	[date shipped] date not null
);

CREATE TABLE USEDVEH (
	[inventory code] char(7) not null, 
	[purchase date] date not null,
	[purchase price] smallmoney not null,
	[mileage] int not null,
	[blue book value] smallmoney not null,
	[trade in flag] bit not null,
)

CREATE TABLE TESTDRIVE(
	[Test drive code] char(7) not null, 
	[Customer number] char(8) not null,
	[Date of test drive] smalldatetime not null,
	[Duration of test drive] decimal null ,
	[Inventory code] char(7) not null,
);

CREATE TABLE SALES (
	[Inventory code] char(7) not null,
	[Customer number] char(8) not null,
	[Sales price] smallmoney not null,
	[Sales date] date not null,
	[Tax amount] smallmoney not null,
	[Payment method] char(1) not null
);


CREATE TABLE AVAILOPTIONS (
	[Option code] char(4) not null, 
	[Option cost] smallmoney not null,
	[Option msrp] smallmoney null,
	[Option description] varchar(200) null, 
	[Vehicle code] char(7) not null
);

CREATE TABLE INSTOPTIONS (
	[Inventory code] char(7) not null,
	[Option code] char(4) not null,
	[Dealer installed flag] bit not null
);

CREATE TABLE CUSTVEH (
	[Customer number] char(8) not null,
	[Vin number] char(17) not null,
	[Vehicle code] char(7) not null,
	[First seen date] date not null
);

CREATE TABLE SERVREC (
	[Service record number] char(8) not null, 
	[Customer number] char(8) not null,
	[Vin number] char(17) not null,
	[dealer number] char(4) not null,
	[service type code] char(3) not null,
	[date brought in] smalldatetime not null,
	[mileage] int not null,
	[date service completed] smalldatetime null ,
	[date billed] smalldatetime null ,
	[total service cost] smallmoney null ,
); 

CREATE TABLE ROUTSERV (
	[service record number] char(8) not null, 
	[service type code] char(3) not null,
	[list price] smallmoney not null,
	[discount] smallmoney not null,
);

CREATE TABLE REPSERV (
	[service record number] char(8) not null,
	[service type code] char(3) not null,
	[parts cost] smallmoney not null,
	[labor hours] decimal not null,
	[labor cost] smallmoney not null,
);

--Adding PK constraints
ALTER TABLE CUST
ADD
	CONSTRAINT PK_CUST
		PRIMARY KEY([customer number]);

ALTER TABLE CUSTVEH
ADD
	CONSTRAINT PK_CUSTVEH
		PRIMARY KEY([customer number],[Vin number]);

ALTER TABLE ROUTSERV
ADD
	CONSTRAINT PK_ROUTSERV
		PRIMARY KEY([Service record number]);

ALTER TABLE REPSERV
ADD
	CONSTRAINT PK_REPSERV
		PRIMARY KEY([Service record number]);

ALTER TABLE SALES
ADD
	CONSTRAINT PK_SALES
		PRIMARY KEY([Inventory code],[Customer number]);

ALTER TABLE TESTDRIVE
ADD
	CONSTRAINT PK_TESTDRIVE
		PRIMARY KEY([Test drive code]);

ALTER TABLE SERVREC
ADD
	CONSTRAINT PK_SERVREC
		PRIMARY KEY([Service record number]);

ALTER TABLE VEHICLE
ADD
	CONSTRAINT PK_SVEHICLE
		PRIMARY KEY([vehicle code]);

ALTER TABLE INVENTORY
ADD
	CONSTRAINT PK_INVENTORY
		PRIMARY KEY([Inventory code]);

ALTER TABLE DEALER
ADD
	CONSTRAINT PK_DEALER
		PRIMARY KEY([dealer number]);

ALTER TABLE AVAILOPTIONS
ADD
	CONSTRAINT PK_AVAILOPTIONS
		PRIMARY KEY([Option code]);

ALTER TABLE INSTOPTIONS
ADD
	CONSTRAINT PK_INSTOPTIONS
		PRIMARY KEY([Inventory code], [Option code]);

ALTER TABLE NEWVEH
ADD
	CONSTRAINT PK_NEWVEH
		PRIMARY KEY([Inventory code]);

ALTER TABLE USEDVEH
ADD
	CONSTRAINT PK_USEDVEH
		PRIMARY KEY([Inventory code]);


--Adding the necessary foreign keys

ALTER TABLE REPSERV
	ADD
		CONSTRAINT FK_REPSERV_SERVREC
			FOREIGN KEY ([Service record number])
				REFERENCES SERVREC([Service record number]);

ALTER TABLE ROUTSERV
	ADD
		CONSTRAINT FK_ROUTSERV_SERVREC
			FOREIGN KEY ([Service record number])
				REFERENCES SERVREC([Service record number]);



ALTER TABLE CUSTVEH
	ADD
		CONSTRAINT FK_CUSTVEH_VEHICLE
			FOREIGN KEY ([Vehicle code])
				REFERENCES VEHICLE([Vehicle code]),
		CONSTRAINT FK_CUSTVEH_CUST
			FOREIGN KEY ([Customer number])
				REFERENCES CUST([Customer number]);

ALTER TABLE TESTDRIVE
	ADD
		CONSTRAINT FK_TESTDRIVE_CUST
			FOREIGN KEY ([Customer number])
				REFERENCES CUST([Customer number]),
		CONSTRAINT FK_TESTDRIVE_INVENTORY
			FOREIGN KEY ([Inventory code])
				REFERENCES INVENTORY([Inventory code]);

ALTER TABLE SALES
	ADD
		CONSTRAINT FK_SALES_CUST
			FOREIGN KEY ([Customer number])
				REFERENCES CUST([Customer number]),
		CONSTRAINT FK_SALES_INVENTORY
			FOREIGN KEY ([Inventory code])
				REFERENCES INVENTORY([Inventory code]);

ALTER TABLE SERVREC
	ADD
		CONSTRAINT FK_SERVREC_CUSTVEH
			FOREIGN KEY ([Customer number], [Vin number])
				REFERENCES CUSTVEH([Customer number], [Vin number]),
		CONSTRAINT FK_SERVREC_DEALER
			FOREIGN KEY([dealer number])
				REFERENCES DEALER([dealer number]);

ALTER TABLE INVENTORY
	ADD
		CONSTRAINT FK_INVENTORY_VEHICLE
			FOREIGN KEY ([vehicle code])
				REFERENCES VEHICLE([vehicle code]),
		CONSTRAINT FK_INVENTORY_DEALER
			FOREIGN KEY([dealer number])
				REFERENCES DEALER([dealer number]);

ALTER TABLE AVAILOPTIONS
	ADD
		CONSTRAINT FK_AVAILOPTIONS_VEHICLE
			FOREIGN KEY ([vehicle code])
				REFERENCES VEHICLE([vehicle code]);

ALTER TABLE INSTOPTIONS
	ADD
		CONSTRAINT FK_INSTOPTIONS_AVAILOPTIONS
			FOREIGN KEY ([Option code])
				REFERENCES AVAILOPTIONS([Option code]),
		CONSTRAINT FK_INSTOPTIONS_INVENTORY
			FOREIGN KEY ([Inventory code])
				REFERENCES INVENTORY([Inventory code]);
ALTER TABLE NEWVEH
	ADD
		CONSTRAINT FK_NEWVEH_INVENTORY
			FOREIGN KEY ([Inventory code])
				REFERENCES INVENTORY([Inventory code]);

ALTER TABLE USEDVEH
	ADD
		CONSTRAINT FK_USEDVEH_INVENTORY
			FOREIGN KEY ([Inventory code])
				REFERENCES INVENTORY([Inventory code]);




				



