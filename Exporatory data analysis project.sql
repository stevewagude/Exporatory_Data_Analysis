 -- EPLORATORY DATA ANALYSIS
 
 SELECT *
 FROM layoffs_staging3;
 
 
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
 FROM layoffs_staging3;

SELECT *
 FROM layoffs_staging3
 WHERE Percentage_laid_off = 1
 ORDER BY funds_raised_millions DESC;

SELECT Company, SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY company
ORDER BY 2 DESC;

SELECT Country, SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY country
ORDER BY 2 DESC;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY industry
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging3;

SELECT YEAR (`date`), SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY YEAR (`date`)
ORDER BY 1 DESC;


SELECT STAGE, SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY STAGE
ORDER BY 2 DESC;


SELECT substring(`date`,1,7) AS `Month`, SUM(total_laid_off)
FROM layoffs_staging3
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC
;

WITH Rolling_Total AS
(
SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off 
FROM layoffs_staging3
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off, SUM(total_off) OVER(ORDER BY `month`) AS rolling_total 
FROM ROLLING_Total;

SELECT Company, SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY company
ORDER BY 2 DESC;

SELECT Company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY company, YEAR(`date`)
order by 3 DESC
;

WITH Company_year (company, years, total_laid_off) AS
(
SELECT Company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY company, YEAR(`date`)
), Company_year_rank AS
(SELECT*, dense_rank() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_year_rank
WHERE RANKING <= 5















