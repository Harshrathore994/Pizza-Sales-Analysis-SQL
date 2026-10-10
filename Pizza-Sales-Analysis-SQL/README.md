# Pizza Sales Analysis using PostgreSQL

A business-focused SQL analysis of pizza sales using PostgreSQL and pgAdmin 4. The project answers 13 questions using joins, aggregations, subqueries, date/time extraction, and window functions. It includes the four CSV source tables and one CSV output for each question.

## Project highlights

- **21,350 orders** across the supplied order dataset
- **48,620 order-detail records**
- **49,574 pizzas** sold (sum of `quantity`)
- **817,860.05 total revenue**, calculated as `quantity × pizza price`
- **358 distinct order dates** represented in the dataset

> Currency is not specified in the supplied files, so revenue is shown without a currency symbol. Revenue is calculated using the listed price per pizza and quantity; taxes, discounts, delivery fees, and refunds are not represented in these tables.

## Business questions

1. How many orders were placed?
2. What was the total revenue from pizza sales?
3. Which pizza/size has the highest listed price?
4. Which size appears in the greatest number of order-detail records?
5. Which five pizza types sold the most units?
6. How many pizzas were ordered in each category?
7. How are orders distributed by hour?
8. How many pizza types are in each category?
9. What is the average number of pizzas ordered per date with orders?
10. Which three pizza types generated the most revenue overall?
11. What percentage of revenue came from each category?
12. How did cumulative revenue change over time?
13. Which three pizza types generated the most revenue within each category?

## Key findings from the supplied CSVs

- Total orders: **21,350**.
- Total pizza quantity: **49,574**.
- Calculated revenue: **817,860.05**.
- The highest-priced listed item is **The Greek Pizza, size XXL, at 35.95**.
- The **Large (L)** size has the most order-detail records (**18,526**) and the greatest quantity (**18,956**).
- The top five pizza types by quantity are Classic Deluxe (**2,453**), Barbecue Chicken (**2,432**), Hawaiian (**2,422**), Pepperoni (**2,418**), and Thai Chicken (**2,371**).
- **Classic** is the largest category by quantity (**14,888**) and contributes **26.91%** of revenue.
- **12 PM** is the busiest hour with **2,520 orders**, followed by 1 PM with 2,455.
- Average quantity per date with orders is approximately **138.47 pizzas** (358 dates with orders).
- Top revenue-generating pizza types overall: Thai Chicken (**43,434.25**), Barbecue Chicken (**42,768.00**), and California Chicken (**41,409.50**).

These are descriptive findings from this dataset, not causal conclusions or universal industry benchmarks.

## Repository structure

```text
pizza-sales-analysis-sql/
├── README.md
├── .gitignore
├── data/
│   ├── order_details.csv
│   ├── orders.csv
│   ├── pizza_types.csv
│   └── pizzas.csv
├── sql/
│   ├── schema.sql
│   └── pizza_sales_analysis.sql
├── results/
│   ├── Q01_total_orders.csv
│   ├── Q02_total_revenue.csv
│   ├── Q03_highest_priced_pizza.csv
│   ├── Q04_most_common_pizza_size.csv
│   ├── Q05_top_5_pizza_types_by_quantity.csv
│   ├── Q06_quantity_by_category.csv
│   ├── Q07_orders_by_hour.csv
│   ├── Q08_pizza_types_by_category.csv
│   ├── Q09_average_pizzas_per_ordered_day.csv
│   ├── Q10_top_3_pizza_types_by_revenue.csv
│   ├── Q11_category_revenue_contribution.csv
│   ├── Q12_cumulative_revenue_over_time.csv
│   └── Q13_top_3_revenue_pizzas_per_category.csv
└── docs/
    └── data_dictionary.md
```

## How to run

1. Install PostgreSQL and open pgAdmin 4.
2. Create a database, for example `pizza_sales`.
3. Run `sql/schema.sql` to create the four tables.
4. Import each CSV from `data/` into its matching table using pgAdmin's Import/Export Data feature. Use the CSV format, header enabled, and comma delimiter. Import parent tables (`orders`, `pizza_types`, `pizzas`) before `order_details` to respect foreign keys.
5. Source `orders.csv` dates use `DD-MM-YYYY`. If date parsing fails, use a session configured with `SET datestyle TO 'DMY';` before import, or convert the date column to ISO `YYYY-MM-DD`.
6. Open and run `sql/pizza_sales_analysis.sql` in pgAdmin's Query Tool.
7. Compare the query outputs with the matching CSV in `results/`.

## Notes on interpretation

- Q04 intentionally reproduces the original query's measure: count of order-detail records per size. The SQL file also includes an optional commented alternative that sums `quantity`.
- Q08 counts pizza types listed in `pizza_types`, not the number of pizzas sold.
- Q11 calculates category contribution because the supplied query groups by `pt.category`, although its original comment says “pizza type.”
- Daily averages and cumulative revenue are based on dates represented in the data; days with no orders are not added as zero-sales days.
- The query output CSVs are included to make the analysis easy to inspect without a database connection.

## Skills demonstrated

PostgreSQL · SQL joins · GROUP BY · aggregate functions · subqueries · date/time extraction · window functions (`SUM() OVER`, `RANK() OVER`) · business-focused analysis · CSV data handling

## Data source

The four CSV files supplied with this project: `orders.csv`, `order_details.csv`, `pizzas.csv`, and `pizza_types.csv`.
