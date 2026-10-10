# Data Dictionary

## `orders.csv` → `orders`
- `order_id`: unique order identifier
- `order_date`: order date (source format DD-MM-YYYY)
- `order_time`: order time (HH:MM:SS)

## `order_details.csv` → `order_details`
- `order_details_id`: unique order-line identifier
- `order_id`: order identifier; joins to `orders.order_id`
- `pizza_id`: pizza variant identifier; joins to `pizzas.pizza_id`
- `quantity`: number of pizzas on that order line

## `pizzas.csv` → `pizzas`
- `pizza_id`: unique pizza variant identifier
- `pizza_type_id`: pizza type identifier; joins to `pizza_types.pizza_type_id`
- `size`: size code
- `price`: listed price for that size

## `pizza_types.csv` → `pizza_types`
- `pizza_type_id`: unique pizza type identifier
- `name`: display name
- `category`: pizza category
- `ingredients`: ingredient description
