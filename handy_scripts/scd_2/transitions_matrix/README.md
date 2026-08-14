# Transitions Matrices

A transitions matrix is a tabular snapshot that lists every distinct combination of a dimension’s “previous” and “current” attribute values between two consecutive time periods (e.g., month → month). Each row shows how an entity moved from one state to another, often with counts or ratios that quantify the magnitude of the change. By aggregating these rows you can identify when an attribute changed, determine the effective start/end dates, and then collapse the data into a Type 2 slowly changing dimension.

SQL’s set‑based operations let you generate the entire transitions matrix in a single query, without explicit loops. This makes the process more efficient and easier to maintain than the row‑by‑row Python approach.

## Step 1 – Build the transitions matrix
Creates workday_transitions_matrix to capture month‑to‑month changes in employee account, group, and domain attributes.
Includes calculations of user ratios, ranking, and filtering to keep only significant transitions.

- SQL code: [Workday Transitions Matrix >> ](./workday_transitions_matrix.sql)

## Step 2 – Collapse the matrix into an SCD‑Type 2 table
Uses workday_map to aggregate the matrix, determine start/end dates for each attribute version, and flag the current record (is_current).

Produces a final SCD view with columns such as account_this, group_this, domain_this, date_start, date_end, account_next, group_next, domain_next, and is_current.

- SQL code: [Workday Map >> ](./workday_map.sql)