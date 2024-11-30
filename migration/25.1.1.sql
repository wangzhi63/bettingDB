CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE contracts (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    assertion_text TEXT,
    start_date DATE,
    end_date DATE,
    creator_id BIGINT,
    FOREIGN KEY (creator_id) REFERENCES users(id)
);

CREATE TABLE bids (
    id BIGSERIAL PRIMARY KEY,
    amount DOUBLE PRECISION NOT NULL,
    action VARCHAR(10) CHECK (action IN ('long', 'short')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id BIGINT,
    contract_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (contract_id) REFERENCES contracts(id)
);

CREATE TABLE resolution (
    id BIGSERIAL PRIMARY KEY,
    contract_id BIGINT NOT NULL,
    decision VARCHAR(255) NOT NULL,
    resolved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_by BIGINT,
    FOREIGN KEY (contract_id) REFERENCES contracts(id),
    FOREIGN KEY (resolved_by) REFERENCES users(id)
);

CREATE TABLE wallet (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    amount DOUBLE PRECISION NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
