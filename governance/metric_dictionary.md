# Metric Dictionary

> Principle: One metric, one definition.

This document defines all executive KPIs used in reporting.
Each metric includes a formula, owner, cadence, and decision purpose.

---

## 1. Weekly Revenue

**Definition:** Total revenue generated during a calendar week.

**Formula:**
SUM(total_amount)

**Source Table:**
fact_sales

**Owner:** Director of Operations

**Refresh Cadence:** Weekly

**Decision Use:**
- Performance tracking
- Revenue trend analysis
- Growth strategy adjustments

---

## 2. Product Mix %

**Definition:** Percentage contribution of a product category to total revenue.

**Formula:**
(SUM(total_amount) BY category) / (SUM(total_amount) overall)

**Source Tables:**
fact_sales
dim_product

**Owner:** Operations / Merchandising

**Refresh Cadence:** Weekly

**Decision Use:**
- Menu optimization
- SKU rationalization
- Promotional targeting

---

## 3. Revenue per Transaction

**Definition:** Average revenue generated per sale.

**Formula:**
SUM(total_amount) / COUNT(sale_id)

**Source Table:**
fact_sales

**Owner:** Operations

**Refresh Cadence:** Weekly

**Decision Use:**
- Upsell effectiveness
- Incentive evaluation
- Pricing adjustments

---

## 4. SKU Velocity

**Definition:** Average units sold per SKU within a given period.

**Formula:**
SUM(quantity) / COUNT(DISTINCT date_id)

**Source Tables:**
fact_sales
dim_product

**Owner:** Operations / Inventory

**Refresh Cadence:** Weekly

**Decision Use:**
- Inventory optimization
- Product mix refinement
- Discontinuation decisions

---

## Change Log

When a KPI definition changes:
- Update the definition above
- Update corresponding SQL views
- Record the change date and reason below

| Date | Metric | Change | Reason |
|------|--------|--------|--------|
