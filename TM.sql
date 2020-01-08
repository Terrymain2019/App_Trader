SELECT COUNT(*) FROM app_store_apps;
--7197 rows
SELECT COUNT(*) FROM play_store_apps;
--10840 rows
/*select apps by genres which belong to Art & Design category*/
SELECT COUNT (genres)
FROM play_store_apps
WHERE genres ilike '%Art & Design%';
SELECT * FROM app_store_apps;

/*select apps by avg_price*/
SELECT name, AVG(price) AS avg_price
FROM app_store_apps
GROUP BY name
ORDER BY avg_price DESC
LIMIT 10;

/*categorize by rating and avg_price*/ 
SELECT rating, AVG(price) AS avg_price
FROM app_store_apps
GROUP BY rating
ORDER BY rating DESC;

SELECT primary_genre, AVG(price) As avg_price  
FROM app_store_apps
GROUP BY primary_genre
ORDER BY avg_price;

SELECT primary_genre, AVG(price) As avg_price, AVG(rating) AS avg_rating,
COUNT(primary_genre)
FROM app_store_apps
GROUP BY primary_genre
ORDER BY avg_rating DESC;


SELECT content_rating, AVG(CAST(review_count AS numeric)), 
COUNT(regexp_replace(content_rating::text, '[,+]', '', 'g')::numeric), 
AVG(price) As avg_price, AVG(rating) AS avg_rating 
FROM app_store_apps
GROUP BY content_rating
ORDER BY avg_price, avg_rating DESC;

SELECT primary_genre, AVG(CAST(review_count AS numeric)) AS avg_review, 
COUNT(regexp_replace(content_rating::text, '[,+]', '', 'g')::numeric), 
AVG(price) As avg_price, AVG(rating) AS avg_rating 
FROM app_store_apps
GROUP BY primary_genre
ORDER BY avg_price;

/*Calculating profit/loss margin of the top ten apps on the app_store table*/
SELECT
	 name, 
	 rating,
	 price,
	primary_genre,										  
	cast(review_count as numeric),									  
	 ROUND((rating/0.5+1),0)*60000 AS earnings,
	ROUND((rating/0.5+1),0)*12000 AS marketing,
	CASE WHEN price <=1 THEN 10000
	 ELSE price*10000 END AS purchase_price,										  
	 ROUND((rating/0.5+1),0)*60000 -(CASE WHEN price <=1 THEN 10000
	 ELSE price*10000 END) - (ROUND((rating/0.5+1),0)*12000) AS Profit_n_loss									  
	 FROM app_store_apps
	 --ORDER BY profit_n_loss DESC;
		ORDER BY profit_n_loss DESC, cast(review_count as numeric)DESC, rating DESC
		LIMIT 1000;

SELECT * FROM play_store_apps;

/*Calculating profit/loss margin of the top ten apps on the play_store table*/		
SELECT
	 name, 
	 rating,
	 price,
	 genres,										  
	--cast(review_count as numeric),									  
	 ROUND((rating/0.5+1),0)*60000 AS earnings,
	ROUND((rating/0.5+1),0)*12000 AS marketing,
	CASE WHEN cast(trim('$' from price) AS numeric) <=1 THEN 10000
	 ELSE cast(trim('$' from price) AS numeric)*10000 END AS purchase_price,										  
	 ROUND((rating/0.5+1),0)*60000 -(CASE WHEN cast(trim('$' from price) AS numeric) <=1 THEN 10000
	 ELSE cast(trim('$' from price) AS numeric)*10000 END) - (ROUND((rating/0.5+1),0)*12000) AS Profit_n_loss									  
	 FROM play_store_apps
	 --ORDER BY profit_n_loss DESC;
		ORDER BY profit_n_loss DESC, review_count DESC, rating DESC
		LIMIT 1000;
		

SELECT
	 DISTINCT(pls.name), 
	 pls.rating,
	 pls.price,
	 aps.name, 
	 aps.rating,
	 aps.price,
	 pls.review_count,									  
	 ROUND((((pls.rating + aps.rating)/2)/0.5+1),0)*60000 AS earnings,
	 ROUND((((pls.rating + aps.rating)/2)/0.5+1),0)*6000 AS marketing,									  
	 CASE WHEN AVG(cast(pls.price as numeric) + aps.price) <=1 THEN 10000
	 ELSE ROUND(((cast(pls.price as numeric) + aps.price)/2),0) * 10000 END AS purchase_price,
	 ROUND((((pls.rating + aps.rating)/2)/0.5+1),0)*60000 -(CASE WHEN AVG(cast(pls.price as numeric) + aps.price) <=1 THEN 10000
	 ELSE ((cast(pls.price as numeric)+ aps.price)/2)*10000 END) - (ROUND((((pls.rating + aps.rating)/2)/0.5+1),0)*6000) AS profit_n_loss
	 FROM play_store_apps AS pls
	 WHERE (ROUND(AVG((pls.rating+aps.rating)/0.5+1),0)*60000 -(CASE WHEN AVG(cast(pls.price as numeric) + aps.price) <=1 THEN 10000
	 ELSE AVG(cast(pls.price as numeric) + aps.price) * 10000 END) - (ROUND(AVG((pls.rating+aps.rating)/0.5+1),0)*12000) >0
	 INNER JOIN app_store_apps AS aps
	ON pls.name = aps.name
	