/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

--짧은 글자수 구하기
SELECT 
	*
FROM
    (
    	SELECT 
    		city, 
    		LENGTH(city)
    	FROM 
    		station
    	ORDER BY 
    		LENGTH(city), 
    		city
    )
WHERE 
	rownum = 1;

	
--긴 글자수 구하기
SELECT 
	*
FROM
    (
    	SELECT 
    		city, 
    		LENGTH(city)
    	FROM 
    		station
    	ORDER BY 
    		LENGTH(city) DESC, 
    		city
    )
WHERE 
	rownum = 1;