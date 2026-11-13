-- PostgreSQL schema for the Finance Analytics assignment.
-- Run against an empty project database, for example: finance_analytics.

CREATE TABLE IF NOT EXISTS customers (
    customer_id   INTEGER PRIMARY KEY,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    city          TEXT NOT NULL,
    country       TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    join_date     DATE NOT NULL,
    annual_income NUMERIC(14, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS branches (
    branch_id   INTEGER PRIMARY KEY,
    branch_name TEXT NOT NULL,
    city        TEXT NOT NULL,
    manager_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS accounts (
    account_id   INTEGER PRIMARY KEY,
    customer_id  INTEGER NOT NULL REFERENCES customers(customer_id),
    branch_id    INTEGER NOT NULL REFERENCES branches(branch_id),
    account_type TEXT NOT NULL,
    balance      NUMERIC(14, 2) NOT NULL,
    open_date    DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id   INTEGER PRIMARY KEY,
    account_id       INTEGER NOT NULL REFERENCES accounts(account_id),
    transaction_date DATE NOT NULL,
    transaction_type TEXT NOT NULL,
    amount            NUMERIC(14, 2) NOT NULL,
    description       TEXT
);

CREATE TABLE IF NOT EXISTS loans (
    loan_id        INTEGER PRIMARY KEY,
    customer_id    INTEGER NOT NULL REFERENCES customers(customer_id),
    loan_type      TEXT NOT NULL,
    loan_amount    NUMERIC(14, 2) NOT NULL,
    interest_rate  NUMERIC(6, 2) NOT NULL,
    loan_start_date DATE NOT NULL,
    loan_status    TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS loan_payments (
    payment_id     INTEGER PRIMARY KEY,
    loan_id        INTEGER NOT NULL REFERENCES loans(loan_id),
    payment_date   DATE NOT NULL,
    payment_amount NUMERIC(14, 2) NOT NULL,
    payment_status TEXT NOT NULL
);

-- Helpful indexes for commonly used joins and date-based analysis.
CREATE INDEX IF NOT EXISTS idx_accounts_customer_id
    ON accounts(customer_id);
CREATE INDEX IF NOT EXISTS idx_accounts_branch_id
    ON accounts(branch_id);
CREATE INDEX IF NOT EXISTS idx_transactions_account_id
    ON transactions(account_id);
CREATE INDEX IF NOT EXISTS idx_transactions_transaction_date
    ON transactions(transaction_date);
CREATE INDEX IF NOT EXISTS idx_loans_customer_id
    ON loans(customer_id);
CREATE INDEX IF NOT EXISTS idx_loan_payments_loan_id
    ON loan_payments(loan_id);
