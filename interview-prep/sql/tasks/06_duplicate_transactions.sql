-- Найти задвоенные транзакции (одинаковые account_id, tx_date, amount)
SELECT account_id,
       tx_date,
       amount,
       COUNT(*) AS accounts_count
FROM transactions t
GROUP BY t.account_id, t.tx_date, t.amount
HAVING COUNT(*) > 1
ORDER BY t.account_id;
