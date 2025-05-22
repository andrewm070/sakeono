import csv
import sqlite3
from pathlib import Path

DATA_DIR = Path(__file__).resolve().parent.parent / "data"
DB_FILE = Path(__file__).resolve().parent.parent / "sakeono.db"

ACCOUNTS_CSV = DATA_DIR / "accounts.csv"
DEP_CSV = DATA_DIR / "depletions.csv"
VISITS_CSV = DATA_DIR / "sales_visits.csv"

TABLES = {
    "accounts": """
        CREATE TABLE IF NOT EXISTS accounts (
            account_id INTEGER PRIMARY KEY,
            account_name TEXT,
            account_type TEXT,
            category TEXT
        )
    """,
    "depletions": """
        CREATE TABLE IF NOT EXISTS depletions (
            date TEXT,
            account_id INTEGER,
            cases_sold INTEGER,
            FOREIGN KEY(account_id) REFERENCES accounts(account_id)
        )
    """,
    "sales_visits": """
        CREATE TABLE IF NOT EXISTS sales_visits (
            date TEXT,
            account_id INTEGER,
            salesperson TEXT,
            notes TEXT,
            FOREIGN KEY(account_id) REFERENCES accounts(account_id)
        )
    """
}

def load_csv(conn, table, csv_path):
    with open(csv_path, newline='') as f:
        reader = csv.DictReader(f)
        cols = reader.fieldnames
        placeholders = ','.join('?' for _ in cols)
        insert_sql = f"INSERT INTO {table}({','.join(cols)}) VALUES ({placeholders})"
        cur = conn.cursor()
        cur.execute(f'DELETE FROM {table}')
        for row in reader:
            cur.execute(insert_sql, [row[c] for c in cols])
        conn.commit()


def init_db():
    conn = sqlite3.connect(DB_FILE)
    cur = conn.cursor()
    for sql in TABLES.values():
        cur.execute(sql)
    conn.commit()
    return conn


def refresh_data(conn):
    load_csv(conn, 'accounts', ACCOUNTS_CSV)
    load_csv(conn, 'depletions', DEP_CSV)
    load_csv(conn, 'sales_visits', VISITS_CSV)


def report_top_accounts(conn, limit=5):
    cur = conn.cursor()
    query = """
        SELECT a.account_name, a.account_type, SUM(d.cases_sold) as total_cases
        FROM depletions d JOIN accounts a USING(account_id)
        GROUP BY a.account_id
        ORDER BY total_cases DESC
        LIMIT ?
    """
    for row in cur.execute(query, (limit,)):
        print(f"{row[0]:25} {row[1]:7} {row[2]} cases")


def report_cases_by_type(conn):
    cur = conn.cursor()
    query = """
        SELECT account_type, SUM(cases_sold)
        FROM depletions JOIN accounts USING(account_id)
        GROUP BY account_type
        ORDER BY SUM(cases_sold) DESC
    """
    print("\nCases sold by account type:")
    for t, total in cur.execute(query):
        print(f"{t:7}: {total}")


def show_recent_visits(conn):
    cur = conn.cursor()
    query = """
        SELECT v.date, a.account_name, v.salesperson, v.notes
        FROM sales_visits v JOIN accounts a USING(account_id)
        ORDER BY v.date DESC
        LIMIT 10
    """
    print("\nRecent visits:")
    for date, name, person, notes in cur.execute(query):
        print(f"{date} - {name} ({person}): {notes}")


def main():
    conn = init_db()
    refresh_data(conn)
    print("Top accounts by cases sold:")
    report_top_accounts(conn)
    report_cases_by_type(conn)
    show_recent_visits(conn)

if __name__ == '__main__':
    main()
