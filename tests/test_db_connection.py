from datetime import datetime

import psycopg
import pytest


def test_db_connection_and_simple_query(db_params):
    """Положительный тест"""
    with psycopg.connect(**db_params) as conn:
        with conn.cursor() as cur:
            cur.execute("select now()")
            row = cur.fetchone()

    assert row is not None, "Запрос не вернул ни одной строки"
    assert isinstance(row[0], datetime), f"Ожидали дату и время, получили {type(row[0])}"


def test_connection_fails_with_wrong_password(db_params):
    """Отрицательный тест: подставляем неверный пароль и проверяем, что подключение отклоняется"""
    bad_params = {**db_params, "password": "definitely-wrong"}
    with pytest.raises(psycopg.OperationalError):
        psycopg.connect(**bad_params)