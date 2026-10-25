-- Клиенты из Новосибирска, зарегистрированные в 2025 году, по дате регистрации.
SELECT client_id,
       full_name,
       city,
       registered_at
FROM clients
WHERE city = 'Новосибирск'
  AND registered_at >= DATE '2025-01-01'
  AND registered_at <  DATE '2026-01-01'
ORDER BY registered_at, client_id;