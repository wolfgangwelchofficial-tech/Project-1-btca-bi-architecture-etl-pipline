# Data Dictionary (Legacy POS → Standardized Staging)

This dictionary documents how fields from the **legacy POS export** are mapped into a normalized staging dataset that supports the star schema and governed KPI views.

## Source File (Legacy Export)
**File:** `data/raw_pos_export.csv`

This file represents a typical legacy export: inconsistent naming, mixed casing, and limited governance.

## Staging Output (Normalized)
**File:** `data/stg_sales.csv`

This file represents the output after normalization and cleaning.

---

## Field Mapping: Raw → Staging

| Raw Field (raw_pos_export.csv) | Staging Field (stg_sales.csv) | Type | Transformation Rule |
|---|---|---|---|
| `TXN_ID` | `sale_id` | INTEGER | Direct map |
| `TXN_DATE` | `full_date` | DATE | Parse to ISO date (YYYY-MM-DD) |
| `STORE` | `location_name` | TEXT | Trim whitespace; standardize casing |
| `ITEM` | `product_name` | TEXT | Trim whitespace; preserve name |
| `ITEM_CATEGORY` | `category` | TEXT | Standardize category labels |
| `QTY` | `quantity` | INTEGER | Cast to integer; null → 0 (flag in QA if present) |
| `UNIT_PRICE` | `unit_price` | DECIMAL(10,2) | Cast numeric; enforce 2 decimals |
| `DISC` | `discount` | DECIMAL(10,2) | Cast numeric; null → 0.00 |
| `NET_TOTAL` | `total_amount` | DECIMAL(10,2) | Cast numeric; must equal (QTY*UNIT_PRICE - DISC) where applicable |

---

## Quality Rules (Minimum)
Before loading into the star schema:
- `sale_id` must be unique
- `full_date` must be present and valid
- `location_name`, `product_name`, `category` must be non-null
- `quantity` must be >= 0
- `total_amount` must be >= 0
- Outliers (e.g., unusually large totals) should be reviewed

---

## How Staging Maps to the Star Schema (Conceptual)

Staging columns populate the star schema as follows:

- **fact_sales**
  - `sale_id` ← `stg_sales.sale_id`
  - `quantity` ← `stg_sales.quantity`
  - `unit_price` ← `stg_sales.unit_price`
  - `discount` ← `stg_sales.discount`
  - `total_amount` ← `stg_sales.total_amount`

- **dim_date**
  - `full_date` ← `stg_sales.full_date` (date_id generated from date table)

- **dim_location**
  - `location_name` ← `stg_sales.location_name` (location_id generated)

- **dim_product**
  - `product_name`, `category` ← `stg_sales.product_name`, `stg_sales.category` (product_id generated)
