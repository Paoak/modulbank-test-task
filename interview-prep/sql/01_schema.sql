-- Схема из тестового задания (PostgreSQL)

DROP TABLE IF EXISTS transactions, accounts, clients;  -- пересоздаём таблицы(для перезапускаемости)

CREATE TABLE clients (
    client_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    city TEXT,
    registered_at DATE NOT NULL
);

CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients (client_id),
    currency VARCHAR(3) NOT NULL,
    opened_at DATE NOT NULL,
    closed_at DATE  -- NULL = счёт открыт
);

CREATE TABLE transactions (
    tx_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL REFERENCES accounts (account_id),
    tx_date TIMESTAMP NOT NULL,
    amount NUMERIC(14,2) NOT NULL,
    tx_type VARCHAR(3) NOT NULL CHECK (tx_type IN ('in', 'out'))
);

-- Индексы по внешним ключам: ускоряют JOIN и проверку ссылочной целостности.
CREATE INDEX idx_accounts_client_id ON accounts (client_id);
CREATE INDEX idx_transactions_account ON transactions (account_id);
