-- experiment SQL schema and seed data

CREATE DATABASE IF NOT EXISTS experiment;
USE experiment;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  product VARCHAR(120) NOT NULL,
  amount DECIMAL(8,2) NOT NULL,
  order_date DATE NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name, email) VALUES
  ('delta', 'delta@example.com'),
  ('echo', 'echo@example.com');

INSERT INTO orders (user_id, product, amount, order_date) VALUES
  (1, 'headset', 49.99, '2026-04-01'),
  (1, 'keyboard', 79.95, '2026-04-02'),
  (2, 'mouse', 25.50, '2026-04-03');

/* sample output query */
SELECT u.name, u.email, o.product, o.amount
FROM users u
JOIN orders o ON u.id = o.user_id
ORDER BY u.id, o.id;
