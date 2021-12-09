
--Adding constraints
--customer number is a mix of 8 alphabets, digits, or hyphen
ALTER TABLE CUST
ADD
	CONSTRAINT CHK_CustomerNumber
	CHECK(
		([customer number] NOT LIKE '%[^A-Z0-9-]%') AND (LEN([customer number]) = 8)
	);
--b.First name and last name cannot have any characters other than alphabets space or – (hyphen)
ALTER TABLE CUST
ADD
	CONSTRAINT CHK_FLname
	CHECK(
	([first name] NOT LIKE '%[^A-Z-]%') AND ([last name] NOT LIKE '%[^A-Z-]%')
	)
--c.Street line 2 can have value only if street line 1 has value
ALTER TABLE CUST
ADD 
	CONSTRAINT CHK_StrLine2
	CHECK(NOT([street line 1] IS NULL AND [street line 2] IS NOT NULL));

--d.City name can only have alphabets and spaces, but can never have two spaces together.
ALTER TABLE CUST
ADD 
	CONSTRAINT CHK_city
	CHECK(
		[city] NOT LIKE '%[^A-Z ]%' AND [city] NOT LIKE '%  %'
	)

--e. State allowed are only VA MD WV DC DE PA
ALTER TABLE CUST
ADD
	CONSTRAINT CHK_State
	CHECK (
		[state] IN ('VA','MD','WV','DC','DE','PA')
	);

--f. Both driver’s license and date of birth are null, or both are not null. Only one of the two having a null value is not allowed.
 ALTER TABLE CUST
ADD CONSTRAINT CHK_driverlicense
	CHECK (
		 (NOT ([drivers license] IS NOT NULL AND [date of birth] IS NULL))
		 AND (NOT ([drivers license] IS  NULL AND [date of birth] IS NOT NULL))
		)
	
	
--g. Customer should be at least 18 years old at the time of insert.
ALTER TABLE CUST
ADD CONSTRAINT CHK_AGE18
	CHECK(
		[date of birth] <= DATEFROMPARTS(YEAR(GETDATE())-18, MONTH(GETDATE()), DAY(GETDATE()))
	)

--h.Customer’s zip code should be exactly 5 digits
ALTER TABLE CUST
ADD CONSTRAINT CHK_ZIPCODE
	CHECK(
		[zip code] LIKE '[0-9][0-9][0-9][0-9][0-9]'
	)
-- CHK DEALER
--a.Dealer number is always 4 long, begins with a digit and ends with an alphabet. In between it is a mix of alphabets and digits
ALTER TABLE DEALER
ADD CONSTRAINT CHK_DealerNumber
	CHECK(
		[dealer number] LIKE '[0-9][A-Z0-9][A-Z0-9][A-Z]'
	);

--b. Dealer’s name must end with letters LLC, and only contain alphabets and spaces (never two spaces together) 
ALTER TABLE DEALER
ADD CONSTRAINT CHK_DealerName
	CHECK(
		[dealer name] LIKE '%LLC' AND [dealer name] NOT LIKE '%[^A-Z ]%' AND [dealer name] NOT LIKE '%  %'	
	)

	--c. Dealer’s zip code should be exactly 5 digits
ALTER TABLE DEALER
ADD CONSTRAINT CHK_DEALER_ZipCode
	CHECK(
		([zip code] NOT LIKE '%[^0-9]%') 
	)

--d. The open date cannot be more than 1 year in future or end of fiscal year (which happens on July 31st of every year), whichever comes first.
ALTER TABLE DEALER
ADD CONSTRAINT CHK_OpenDate
	CHECK (
		(MONTH(GETDATE()) <= 7 AND [open date] <= DATEFROMPARTS(YEAR(GETDATE()), 7, 31))
		OR (MONTH(GETDATE()) > 7 AND [open date] <= DATEFROMPARTS(YEAR(GETDATE())+1, 7, 31))
	) 

--CHK VEHICLE
--a. Year (declared as char(4)) is always 4 digits and cannot be more than one year in future
ALTER TABLE VEHICLE
ADD CONSTRAINT CHK_Year
	CHECK(
		[year] NOT LIKE '%[^0-9]%' AND CAST([year] AS INT) <= YEAR(GETDATE())+1
	);

--b. Date model introduced cannot be more than 3 months in future
ALTER TABLE VEHICLE
ADD CONSTRAINT CHK_DateModel
	CHECK(
		[date model introduced] <= DATEADD(MONTH,3, GETDATE())
	);
--CHECK CONSTRAINT INVENTORY
--a.Inventory code must always begin with an alphabet other than E, X, Z
ALTER TABLE INVENTORY
ADD CONSTRAINT CHK_InventoryCode
	CHECK (
		[Inventory code] LIKE '[^EXZ]%'
	);

--b.New or used can only have values n, N, u, U
ALTER TABLE INVENTORY
ADD CONSTRAINT CHK_NeworUsed
	CHECK(
		[new or used] LIKE '[nNuU]'-- [new or used] IN ('N','n','u','U')
	);

--c. Date arrived at dealership cannot be more than 1 month in future or earlier than 7 days in the past. Date available in stock cannot be earlier than date arrived at dealership. Date sold cannot be earlier than data available in stock
ALTER TABLE INVENTORY
ADD CONSTRAINT CHK_DateArrived
	CHECK(
		[date arrived at dealership] BETWEEN DATEADD(DAY, -7, GETDATE())
		AND DATEADD(MONTH, 1, GETDATE())
		AND [date available in stock] >= [date arrived at dealership]
		AND [date sold] >= [date available in stock]
	);

--d.If date sold is null, the available in stock should be 1. If date sold is not null, the available in stock value should be 0
ALTER TABLE INVENTORY
ADD CONSTRAINT CHK_DateSold
	CHECK(
		([date sold] IS NULL AND [available for sale] = 1)
		OR ([date sold] IS NOT NULL AND [available for sale] = 0)
	)
--CHECK CONSTRAINT USEDVEH
--a. Purchase date cannot be in future
ALTER TABLE USEDVEH
ADD CONSTRAINT CHK_PurchaseDate
	CHECK(
		[purchase date] <= GETDATE()
	);

--b. If trade in flag is 1, purchase price cannot be more than 120% of blue book price; or if trade in flag is 0, purchase price cannot be more than 90% of blue book price.
ALTER TABLE USEDVEH
ADD CONSTRAINT CHK_PurchasePrice
	CHECK(
		([trade in flag] = 1 AND [purchase price] <= 1.2 * [blue book value])
		OR ( [trade in flag] = 0 AND [purchase price] <= 0.9 * [blue book value])
	);

--c. Mileage is greater than 0
ALTER TABLE USEDVEH
ADD CONSTRAINT CHK_Mileage
	CHECK(
		[mileage] > 0
	);

--d. Blue book value is greater than 0
ALTER TABLE USEDVEH
ADD CONSTRAINT CHK_BlueBookValue
	CHECK(
		[blue book value] > 0
	);

--CHECK CONSTRAINT TESTDRIVE 
--a. Date of test drive cannot be in future
ALTER TABLE TESTDRIVE
ADD CONSTRAINT CHK_DateOfTestDrive
	CHECK(
		[Date of test drive] <= GETDATE()
	),

--b. Duration of test drive is greater than 0
CONSTRAINT CHK_DurationOfTestDrive
	CHECK(
		[Duration of test drive] > 0
	);

--CHECK CONSTRAINT SALES
--a. Sales price is greater than 0
ALTER TABLE SALES
ADD CONSTRAINT CHK_SalesPrice
	CHECK(
		[Sales price] > 0
	),

--b. Tax amount is not be negative, and can not be more than 10% of sales price
CONSTRAINT CHK_TaxAmount
	CHECK(
		[Tax amount] BETWEEN 0 AND 0.1 * [Sales price]
	),

--c. Payment method value is one of C, L, F, O
CONSTRAINT CHK_PaymentMethod
	CHECK(
		[Payment method] LIKE '[CLFO]'
	);

--CHECK CONSTRAINT AVAILOPTIONS
--a. Option cost is not negative
ALTER TABLE AVAILOPTIONS
ADD CONSTRAINT CHK_OptionCost
	CHECK(
		[Option cost] >= 0
	),

--b. Option msrp is not negative, and is greater than option cost
CONSTRAINT CHK_OptionMsrp
	CHECK(
		[Option msrp] > [Option cost]
	);

--CHECK CONSTRAINT SERVREC
--a. Type of service is either RO or REP
ALTER TABLE SERVREC
ADD CONSTRAINT CHK_TypeOfService
	CHECK(
		[service type code] IN ('RO', 'REP')
	),
--b. Date brought in is not in future
CONSTRAINT CHK_DateBroughtIn
	CHECK(
		[date brought in] <= GETDATE()
	),
--c. Date service completed is not be later than today, and cannot be earlier than date brought in.
CONSTRAINT CHK_DateServiceCompleted
	CHECK(
		[date service completed] BETWEEN [date brought in] AND GETDATE()
	),
--d. Date billed is on or after date service completed.
CONSTRAINT CHK_DateBilled
	CHECK(
		[date billed] >= [date service completed]
	),

--e. Total service cost cannot be negative.
CONSTRAINT CHK_TotalServiceCost
	CHECK(
		[total service cost] >= 0
	);

--CHECK CONSTRAINT ROUTSERV
--a. Service type code is always RO, List price is never less than 1, Discount cannot be more than 50% of list price
ALTER TABLE ROUTSERV
ADD CONSTRAINT CHK_ROUTSERV_ServiceType
	CHECK(
		([service type code] = 'RO') AND ([list price] >=1) AND ([discount] <= 0.5 * [list price])
	);


--CHECK CONSTRAINT REPSERV
--a. Service type code is always REP, Parts cost and Labor Cost is never less than 1
ALTER TABLE REPSERV
ADD CONSTRAINT CHK_REPSERV_ServiceType
	CHECK(
		([service type code] = 'REP') AND ([parts cost] >=1)  AND ([labor cost] >=1)
	);



