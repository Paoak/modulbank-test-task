-- Топ-3 клиентов по сумме исходящих транзакций в каждом месяце.
WITH monthly AS (
    -- 1) сумма исходящих по клиенту в каждом месяце
    SELECT c.client_id,
           c.full_name,
           SUM(t.amount) as total_out,
           date_trunc('month', t.tx_date) as tx_month
    FROM clients c
    JOIN accounts a ON a.client_id  = c.client_id
    JOIN transactions t ON t.account_id = a.account_id
    WHERE t.tx_type = 'out'
    GROUP BY c.client_id, c.full_name, date_trunc('month', t.tx_date)
),
ranked AS (
    -- 2) нумерация клиентов внутри месяца
    SELECT client_id,
           full_name,
           tx_month,
           total_out,
           ROW_NUMBER() OVER (PARTITION BY tx_month ORDER BY total_out DESC, client_id) AS rn
    FROM monthly
)
-- 3) оставляем первых трёх в каждом месяце
SELECT tx_month,
       client_id,
       full_name,
       total_out,
       rn
FROM ranked
WHERE rn <= 3
ORDER BY tx_month, rn;