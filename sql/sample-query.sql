-- sample queries for the experiment database

USE experiment;

-- show all users
SELECT id, name, email, created_at
FROM users
ORDER BY id;

-- show order totals per user
SELECT u.name, COUNT(o.id) AS order_count, SUM(o.amount) AS total_spent
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name
ORDER BY total_spent DESC;

-- simple transaction example
START TRANSACTION;
UPDATE users SET email = 'delta.changed@example.com' WHERE id = 1;
UPDATE orders SET amount = amount * 1.05 WHERE user_id = 1;
COMMIT;
