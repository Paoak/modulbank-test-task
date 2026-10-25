-- Имя клиента и общая сумма входящих транзакций.
-- Группируем по client_id, а не только по имени: клиенты 1 и 7 оба «Иван Петров».
-- Клиенты без входящих сюда не попадают (внутренний JOIN).
SELECT c.client_id,
       c.full_name,
       SUM(t.amount) AS total_in
FROM clients c
JOIN accounts a ON a.client_id  = c.client_id
JOIN transactions t ON t.account_id = a.account_id
WHERE t.tx_type = 'in'
GROUP BY c.client_id, c.full_name
ORDER BY total_in DESC, c.client_id;