# E-commerce Database Task 2

This task uses the [PostgreSQL schema from Task 1](../Task%201/schema_postgresql.sql).

## 1. Search for Products by Keyword

Find all products with `camera` in their name or description, ignoring letter case.

```sql
SELECT *
FROM Product
WHERE LOWER(name) LIKE '%camera%'
   OR LOWER(description) LIKE '%camera%';
```

The pattern matches `camera` anywhere in either field, including within a longer word such as `cameras`.

2. Recommend Popular Products
   
Question: Design a query to suggest popular products in the same category for the same author, excluding the purchased product from the recommendations.

Note on the Schema
The current schema (Task 1) has no author/seller column in the Product table, so the solution below relies on same category only, while excluding purchased products.

```sql
SELECT rec.*
FROM Product rec
WHERE rec.category_id IN (
        SELECT p.category_id
        FROM Order_details od
        JOIN Orders o      ON od.order_id = o.order_id
        JOIN Customer c    ON o.customer_id = c.customer_id
        JOIN Product p     ON od.product_id = p.product_id
        WHERE c.customer_id = 10
      )
  AND rec.product_id NOT IN (
        SELECT od.product_id
        FROM Order_details od
        JOIN Orders o ON od.order_id = o.order_id
        WHERE o.customer_id = 10
      );
```
