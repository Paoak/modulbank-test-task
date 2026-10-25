-- Клиенты, у которых больше двух счетов.
SELECT c.client_id,
       c.full_name,
       COUNT(*) AS accounts_count
FROM clients c
JOIN accounts a ON a.client_id = c.client_id
GROUP BY c.client_id, c.full_name
HAVING COUNT(*) > 2
ORDER BY c.client_id;