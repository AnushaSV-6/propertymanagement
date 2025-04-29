-- name: validateUser
SELECT * FROM users WHERE email = ? AND password = ?;

-- name: existsByEmail
SELECT COUNT(*) FROM users WHERE email = ?;

-- name: existsByPhone
SELECT COUNT(*) FROM users WHERE phone = ?;

-- name: insertUser
INSERT INTO users (user_id, email, password, name, phone, role, status, created_at)
VALUES (?, ?, ?, ?, ?, ?, ?, ?);

-- name: getAllUsers
SELECT * FROM users;

-- name: getUserById
SELECT * FROM users WHERE user_id = ?;

-- name: updateUser
UPDATE users
SET email = ?, password = ?, name = ?, phone = ?, role = ?, status = ?
WHERE user_id = ?;

-- name: updateStatusActive
UPDATE users SET status = 'ACTIVE' WHERE user_id = ?;

-- name: updateStatusInactive
UPDATE users SET status = 'INACTIVE' WHERE user_id = ?;

-- name: findByEmail
SELECT * FROM users WHERE email = ?;
