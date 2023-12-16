


/-- Inspecting data

SELECT TOP (1000) [status]
      ,[bed]
      ,[bath]
      ,[city]
      ,[state]
      ,[zip_code]
      ,[house_size]
      ,[prev_sold_date]
      ,[price]
  FROM [Housing].[dbo].[realtor_data]

 
 SELECT state, ROUND(SUM(price),0) AS total_home_value
FROM [Housing].[dbo].[realtor_data]
GROUP BY state  /-- total on-sale home value


 SELECT state, ROUND(AVG(price),0) AS average_home_value
FROM [Housing].[dbo].[realtor_data]
GROUP BY state  /-- average home value



/-- DRopping unessary column
ALTER TABLE [Housing].[dbo].[realtor_data]
DROP COLUMN acre_lot 


/ -- South Carolina, West Virgina, Tennnessee, Louisiana and Wyoming have incomplete data Since Total Asset is very low
/-- Droping those rows

DELETE FROM realtor_data WHERE state = 'Tennessee'
DELETE FROM realtor_data WHERE state = 'South Carolina'
DELETE FROM realtor_data WHERE state = 'Wyoming'
DELETE FROM realtor_data WHERE state = 'Louisiana'
DELETE FROM realtor_data WHERE state = 'West Virginia'

/-- The income and population data
SELECT TOP (1000) [state]
      ,[densityMi]
      ,[pop2023]
      ,[pop2022]
      ,[pop2020]
      ,[pop2019]
      ,[pop2010]
      ,[growthRate]
      ,[growth]
      ,[growthSince2010]
      ,[med_income]
  FROM [Housing].[dbo].[median_income]


/-- clean up the median_income table and add Peurto RIco data to the table


DELETE FROM median_income
  WHERE state = 'true'
ALTER TABLE median_income
  DROP COLUMN fips




INSERT INTO median_income 
VALUES ('Puerto Rico', 11.063, 3180885, 3221789, 3281557, 3325980, 3725789, -0.0127, -40904, -0.14625, 24002 )

SELECT * 
FROM median_income

/-- Analyzing Data 
		

SELECT realtor_data.state, 
	ROUND(SUM(price),0) AS total_asset,
	median_income.med_income, 
	pop2023,
	pop2023-pop2010 AS population_growth_in_10_years,
	ROUND(AVG(price),0) AS average_home_value,
	med_income/ROUND(AVG(price),0) AS income_to_home_price_ratio
FROM realtor_data
JOIN median_income ON realtor_data.state = median_income.state
GROUP BY realtor_data.state, med_income, pop2023, pop2023-pop2010
