/* 1) ALTER statement to drop needless create_date column in customers table */

ALTER TABLE customer DROP create_date;

SELECT * FROM customer ;




/* 2) CASE statement that classifies sneakers sized 7 and under as childrens and 8 and up as adult */

SELECT sneaker.sneaker_id, sneaker.sneaker_name, sneaker.size,
CASE
    WHEN sneaker.size > 7 THEN 'Adult'
    WHEN sneaker.size < 8 THEN 'Children'
    ELSE 'N/A'
END AS Size_Classification 
FROM sneaker




/* 3) Find the manager of the NYC location */

SELECT staff.staff_id,staff.staff_name, store.store_name, store.store_location
FROM staff
INNER JOIN store ON staff.staff_id = store.manager_staff_id

WHERE store_location = 'NYC' ;





/* 4) Find the list of customers who have purchased over 2 sneakers worth over $70 ordered descending */

SELECT customer.customer_name, customer.email, customer.address_id, payment.payment_id, payment.sneaker_id, payment.payment_date,payment.quantity, payment.amount
FROM customer
INNER JOIN payment on customer.customer_id = payment.customer_id

WHERE payment.amount >= '70' AND payment.quantity >= '2'
ORDER BY payment.quantity DESC;





/* 5) Multiply the quantity and amount columns from the payments table to 
find total value and group the results by store that amount was spent in. 
then filter for store id's greater than 2*/

SELECT customer.store_id, SUM(payment.amount * payment.quantity) AS total_value
FROM payment
JOIN customer on payment.customer_id = customer.customer_id
GROUP BY customer.store_id
HAVING customer.store_id > '2';





/* 6) Create a VIEW of clients who have made purchases greater than $100 after start of 2023 */

CREATE VIEW recent_clients AS

SELECT customer.customer_name, customer.email, customer.address_id, payment.payment_id, payment.sneaker_id, payment.payment_date,payment.quantity, payment.amount
FROM customer
INNER JOIN payment on customer.customer_id = payment.customer_id

WHERE payment.payment_date >= DATE('1/1/2023') AND payment.amount >= '100';






/* 7) Sub query that totals the amount of purchases made by each client  */

SELECT 
	customer.customer_id,
	customer.customer_name,
	(
		SELECT COUNT(*) AS purchases_made
		FROM payment
		WHERE customer.customer_id = payment.customer_id
	)
FROM customer;







/* 8) Sub query that totals the amount of sales by staff_name */

SELECT 
	staff.staff_id,
	staff.staff_name,
	(
		SELECT SUM(payment.amount * payment.quantity) AS total_value
		FROM payment
		WHERE staff.staff_id  = payment.staff_id
	)
FROM staff;