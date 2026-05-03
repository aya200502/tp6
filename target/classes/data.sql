-- Insert default users for testing
INSERT IGNORE INTO users (login, password, role) VALUES 
    ('jalal', '1234', 'admin'),
    ('test', '1234', 'user');

-- Insert sample products for testing
INSERT IGNORE INTO produits (nom, description, prix) VALUES 
    ('Laptop Dell XPS', 'Ultra-thin laptop with 15.6 inch display', 1299.99),
    ('iPhone 15', 'Latest Apple smartphone with advanced features', 999.99),
    ('Samsung 4K TV', '55 inch Samsung Smart TV with 4K resolution', 599.99),
    ('PlayStation 5', 'Next-gen gaming console', 499.99),
    ('AirPods Pro', 'Wireless earbuds with noise cancellation', 249.99);
