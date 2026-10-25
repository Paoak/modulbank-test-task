-- Клиенты без единого счёта
SELECT c.client_id,
	   c.full_name
FROM clients c
LEFT JOIN accounts a on c.client_id = a.client_id
WHERE a.account_id IS NULL
ORDER BY c.client_id;