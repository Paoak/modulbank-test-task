import os

import pytest

# Фикстура нужна, чтобы параметры лежали в одном месте. Благодаря переменным окружения тест можно запустить с неверным паролем, не правя код.
@pytest.fixture
def db_params():
    """Параметры подключения: из переменных окружения, иначе значения по умолчанию."""
    return {
        "host": os.getenv("DB_HOST", "localhost"),
        "port": int(os.getenv("DB_PORT", "5432")),
        "dbname": os.getenv("DB_NAME", "testdb"),
        "user": os.getenv("DB_USER", "tester"),
        "password": os.getenv("DB_PASSWORD", "tester_pass"),
    }