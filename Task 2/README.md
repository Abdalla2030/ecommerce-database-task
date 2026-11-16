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

## 2. Recommend Popular Products

<!-- Add the solution here. -->
