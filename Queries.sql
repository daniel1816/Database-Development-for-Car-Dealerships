--answer business questions

--a.Display customer records who live in Fairfax
SELECT *
FROM CUST
WHERE city = 'Fairfax';

--b. Display dealer records with open date in year 2018
SELECT * FROM DEALER
WHERE YEAR([open date]) = 2018

--c. Display Inventory records for all vehicles that have not been sold
SELECT * FROM INVENTORY
WHERE [available for sale] = 1

--d.Display Inventory records for listed price of under $25000 and both interior color and exterior color is black, or both interior color and exterior color is gray
SELECT *
FROM INVENTORY
WHERE [listed price] <= 25000
AND (
	([exterior color] = 'black' and [interior color] = 'black')
	OR ([exterior color] = 'gray' and [interior color] = 'gray')
)

--e. Display Inventory records for all new vehicles
SELECT *
FROM INVENTORY
WHERE [new or used] IN ('N', 'n')

--f. Display records for customers who have not purchased any vehicles
SELECT * 
FROM CUST
WHERE [customer number] NOT IN (SELECT [customer number] FROM SALES)

--option#2

SELECT * 
FROM CUST C 
LEFT JOIN SALES S
ON C.[customer number] = S.[Customer number]
WHERE S.[Customer number] IS NULL

--g. Display records for customers who have both tested and purchased a vehicle

SELECT C.[Customer number]
FROM TESTDRIVE T 
JOIN SALES S
ON T.[Customer number] = S.[Customer number]
JOIN CUST C
ON C.[customer number] = S.[Customer number]

--h. Display results which show by Dealer and Vehicle, the number of cars sold, number of customers who have purchased, and total of sales price
SELECT D.[dealer name], 
	I.[vehicle code], 
	COUNT(DISTINCT S.[Inventory code]), 
	COUNT(DISTINCT S.[Customer number]), 
	SUM(S.[Sales price])
FROM DEALER D LEFT JOIN INVENTORY I
ON D.[dealer number] = I.[dealer number]
LEFT JOIN SALES S ON S.[Inventory code] = I.[Inventory code]
GROUP BY D.[dealer number], I.[vehicle code]

--i. Display results which show vehicles and numbers sold in year 2018. Only include vehicles that were sold.
SELECT I.[vehicle code], 
	COUNT(DISTINCT I.[Inventory code])
FROM SALES S JOIN INVENTORY I
ON S.[Inventory code] = I.[Inventory code]
WHERE YEAR(S.[Sales date]) = 2018
GROUP BY I.[vehicle code]

--j. Display by dealer the number of services performed, the total service billed (sum of total service cost), number of customers serviced, and number of cars serviced.
SELECT D.[dealer name], 
	COUNT(DISTINCT S.[Service record number]) AS NumOfServices, 
	SUM(S.[total service cost]) AS TotalBilled, 
	COUNT(DISTINCT S.[Customer number]), 
	COUNT(DISTINCT S.[Vin number])
FROM DEALER D LEFT JOIN SERVREC S 
ON D.[dealer number] = S.[dealer number]
GROUP BY D.[dealer number]


