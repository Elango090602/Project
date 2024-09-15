select * from layoffs;

-- Removes Duplicate
-- Standardize the data
-- Null or Blank values
-- Remove any columns



-- 1. Removes Duplicate

-- Creating a Duplicate of the Table becoz we don't want to change the original data
Create table layoffs_staging
like layoffs;
select * from layoffs_staging;

Insert into layoffs_staging 
select * from layoffs;

select * from layoffs_staging ;

-- Finding Duplicates
select *,
row_number() Over(
PARTITION BY Company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) 
AS row_no
From layoffs_staging;

-- 1.Creating a CTE
With duplicate_cte As
(select *,
row_number() Over(
PARTITION BY 
Company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) 
AS row_no From layoffs_staging 
)
select * from
duplicate_cte where row_no>1;	


-- Directly we can't Delete from a CTE,So we need to create another table with the ''row_no''

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_no` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;

Insert into layoffs_staging2 
select *,
row_number() Over(
PARTITION BY 
Company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) 
AS row_no From layoffs_staging;

Delete from layoffs_staging2 where row_no >1;

-- Standardizing Data

select * 
from layoffs_staging2;

-- First we format the company 
UPDATE layoffs_staging2
set company= trim(company);

select Distinct industry from layoffs_staging2 order by 1;

select * from layoffs_staging2 where industry like 'Crypto%';

select Distinct country from layoffs_staging2 order by 1;

Update layoffs_staging2
set industry = 'Crypto' where industry like 'Crypto%';

select Distinct country from layoffs_staging2 order by 1;

select * from layoffs_staging2 where country like 'United States%';

Update layoffs_staging2
set country = trim(Trailing '.' From country)
where country like 'United States%';

-- Formatting Date and Time
select `date`
from layoffs_staging2;

-- Updating Date(str) to Date

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');

select * from layoffs_staging2;
-- The date column's data was converted to Date but the overall column was still in Text so
alter table layoffs_staging2
modify column `date` Date;

-- Handling Null Values 
select total_laid_off,percentage_laid_off from layoffs_staging2
where total_laid_off is Null and percentage_laid_off is NUll;

-- Since these two tables are important if they contain null they are useless so we drop them 
delete  from layoffs_staging2
where total_laid_off is Null and percentage_laid_off is NUll;

select * 
from layoffs_staging2
where industry is Null or industry = '';

update layoffs_staging2
set industry = null where industry is Null or industry = '';

select * from layoffs_staging2
where company='Airbnb';

-- I fuked up and inserted values into this table 2 times so i'm gonna create another table 
-- To remove those duplicates , but im gonna do it at last after formatting and everything

select l1.industry,l2.industry 
from layoffs_staging2 l1
join layoffs_staging2 l2
on l1.company=l2.company 
where (l1.industry is Null or l1.industry='')
and l2.industry is not null;

update layoffs_staging2 l1 
join layoffs_staging2 l2
on l1.company=l2.company
set l1.industry = l2.industry  
where (l1.industry is Null or l1.industry='')
and l2.industry is not null;

alter table layoffs_staging2
drop column row_no;

select * from layoffs_staging2;

-- Removing the duplicates again by creating a new Table

CREATE TABLE `layoffs_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_no` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_staging3 
select *,row_number() over(
partition by 
Company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
as row_no from layoffs_staging2;

select * from layoffs_staging3 ;

delete from layoffs_staging3 where row_no >1;

alter table layoffs_staging3
drop column row_no;

-- Exploratory Data Analysis

Select * from layoffs_staging3;

select Year(`Date`),company,sum(total_laid_off) as SumofTotallaid  from layoffs_staging3 group by company,Year(`Date`) order by Year(`Date`) ;

select substring(`Date`,1,7) as `Month`, SUM(total_laid_off )
from layoffs_staging3 where substring(`Date`,1,7) is not null
 group by `Month` order by 1 ; 
 
 with rolling_sum as
 (
 select substring(`Date`,1,7) as `Month`, SUM(total_laid_off ) as Total
from layoffs_staging3 where substring(`Date`,1,7) is not null
 group by `Month` order by 1 
 )
 select `Month`,Total,sum(Total) over(order by `Month`) as rolling_sum
 from rolling_sum ;
 
 select year(`date`),company,sum(total_laid_off) from layoffs_staging3 
 group by company, year(`date`) order by 3 Desc ;
 
 with company_year AS
 (
 select year(`date`) as years,company,sum(total_laid_off) as laidoff from layoffs_staging3 
 group by company, year(`date`) order by 3 Desc),company_year_rank as
 (
 SELECT *,dense_rank() over(partition by  years order by laidoff desc) as ranking
 from company_year where years is not null )
 select * from company_year_rank where ranking <=5;
 
 select year(`date`) as years,country,sum(total_laid_off) as Total_laidoff 
from layoffs_staging3  group by country,year(`date`) 
having years is not null order by Total_laidoff desc;

-- Total laid off Based on Countries
select distinct(country),sum(total_laid_off)  from layoffs_staging3 group by country;

select year(`Date`) as years,country,sum(total_laid_off) as laidoff
 from layoffs_staging3 group by years,country having years is not null order by years;

with topfivecountry as
( select year(`Date`) as years,country,sum(total_laid_off) as laidoff
 from layoffs_staging3 group by years,country having years is not null order by years),countryrank as
 (
 select *, dense_rank() over(partition by years order by laidoff desc) as Ranking 
 from topfivecountry)
 select * from countryrank where ranking <=5;
 
 -- Total layoffs in India datewise
 select country,`Date`,total_laid_off 
from layoffs_staging3 where country="India" and total_laid_off is not null order by `Date`;

-- Total layoffs in india Year Wise
select year(`Date`), sum(total_laid_off) as totallayoff,country
from layoffs_staging3 group by year(`Date`),country having country like "India";

 
 