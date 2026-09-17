-- EXPLORATORY DATA ANALYSIS


SELECT *
FROM layoff_staging_2;

SELECT MAX(total_laid_off) , MAX(percentage_laid_off)
FROM layoff_staging_2;


SELECT *
FROM layoff_staging_2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


SELECT company , SUM(total_laid_off)
FROM layoff_staging_2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC ;


SELECT MIN(`date`),MAX(`date`)
FROM layoff_staging_2;


SELECT industry , SUM(total_laid_off)
FROM layoff_staging_2
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC ;


SELECT *
FROM layoff_staging_2;


SELECT country , SUM(total_laid_off)
FROM layoff_staging_2
GROUP BY country
ORDER BY SUM(total_laid_off) DESC ;


SELECT YEAR(`date`) , SUM(total_laid_off)
FROM layoff_staging_2
GROUP BY YEAR(`date`)
ORDER BY YEAR(`date`) DESC ;


SELECT STAGE , SUM(total_laid_off)
FROM layoff_staging_2
GROUP BY STAGE
ORDER BY 2 DESC ;


SELECT *
FROM layoff_staging_2;


SELECT company , AVG(percentage_laid_off)
FROM layoff_staging_2
GROUP BY company
ORDER BY 2 DESC ;

SELECT SUBSTRING(`date` , 1 , 7 ) as `MONTH` , SUM(total_laid_off)
FROM layoff_staging_2
WHERE SUBSTRING(`date` , 1 , 7 ) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `MONTH` ASC;

WITH ROLLING_TOTAL AS
(SELECT SUBSTRING(`date` , 1 , 7 ) as `MONTH` , SUM(total_laid_off) AS TOTAL_LAYOFF
FROM layoff_staging_2
WHERE SUBSTRING(`date` , 1 , 7 ) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `MONTH` ASC
)

SELECT `MONTH` , TOTAL_LAYOFF,
SUM(TOTAL_LAYOFF) OVER(ORDER BY `MONTH`) AS ROLLINGTOTAL
FROM ROLLING_TOTAL;


SELECT *
FROM layoff_staging_2;


SELECT company , YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging_2
GROUP BY company , YEAR(`date`)
ORDER BY  SUM(total_laid_off) DESC ;



WITH COMPANY_YEARS ( COMPANY , YEARS , TOTAL_LAYOFFF) AS 
(
SELECT company , YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging_2
GROUP BY company , YEAR(`date`)
) , COMPANY_YEAR_RANK AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY YEARS ORDER BY TOTAL_LAYOFFF DESC ) AS RANKS
FROM COMPANY_YEARS
WHERE YEARS IS NOT NULL
)

SELECT *
FROM COMPANY_YEAR_RANK
WHERE RANKS <= 5;


