# Slowly Changing Dimensions – Type 2

## Purpose
Type 2 SCD tracks historical changes to dimension attributes by **creating a new row** whenever a value changes.  
- Preserves the original record (past state)
- Adds a versioned row with the new value and effective dates (or a current‑flag)  
- Enables accurate “as‑of” reporting and audit trails without overwriting history.

## When to use
- When business decisions depend on the state of an attribute at a specific point in time (e.g., customer address, product category).  
- When you need to analyze trends while retaining the full change history.  

## Typical structure
| Column                | Description                                    |
|-----------------------|------------------------------------------------|
| **PrimaryKey**        | Unique identifier for each version (PK).      |
| **Attribute(s)**      | Values that may change (e.g., Address).       |
| **EffectiveFrom**     | Date the row became active.                    |
| **EffectiveTo**       | Date the row was superseded (or NULL for current). |
| **IsCurrent**         | Flag indicating the latest version.           |

## Example placeholders
- **Python implementation** – see [target_metric_map >> ](./target_metric_map.py) for a pandas‑based approach that detects changes and appends versioned rows.  

- **SQL implementation** – see [transitions_matrix >> ](./transitions_matrix/README.md) for a two‑step T‑SQL routine that first builds a transitions matrix and then collapses it into an SCD‑Type 2 table with proper date ranges and an `is_current` flag.

---  

*Type 2 SCD provides a simple, reliable way to keep a full temporal history of dimension data, supporting both reporting accuracy and compliance requirements.*  
