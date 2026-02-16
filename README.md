# BT-California — BI Architecture: Legacy POS → Executive Source of Truth (Case Study)

> **Note:** This repository uses a **synthetic dataset** modeled after real operational patterns to demonstrate methodology.  
> No proprietary data is included.

## Executive Summary
I designed a lightweight BI architecture to convert **unstructured legacy POS exports** into a governed reporting layer that supports executive decision-making.  
The result was a repeatable pipeline and KPI governance model that reduced manual reporting effort and enabled faster performance “deep dives.”

### Outcomes (from role experience)
- Reclaimed **~20+ hours/week** by replacing manual reporting with automated ingestion + standardized metrics
- Enabled real-time executive visibility through a single metric definition layer (“source of truth”)
- Established a scalable foundation for KPI cadence, drill-downs, and operational sprints

## Business Impact (How Leadership Uses This)

This architecture enables leadership to operate with a consistent, governed KPI system:

- **Weekly Executive Deep Dive:** Revenue trend, product mix, and transaction performance reviewed on a fixed cadence
- **Drill-Down Clarity:** KPI views allow fast pivoting by week and category without metric redefinition
- **Decision Velocity:** Shifts energy from “arguing about numbers” to choosing actions (pricing, promos, staffing, product mix)

### Weekly Operating Cadence (Example)
1. **Monday:** Review last week’s results (vw_weekly_revenue, vw_revenue_per_transaction)  
2. **Tuesday:** Identify category opportunities (vw_category_product_mix)  
3. **Wednesday:** Decide interventions (pricing/promo/menu/ops changes)  
4. **Friday:** Validate outcomes and prepare next deep dive

> This cadence is intentionally lightweight so it scales with minimal overhead.

## Quantified Executive Impact

See:
- [Executive KPI Impact Simulation](analysis/executive_kpi_impact_simulation.md)

This models how KPI governance and architectural standardization translate into measurable revenue leverage through improved executive decision velocity.

## Problem
Legacy POS systems produced exports that were:
- inconsistent across time/fields
- difficult to normalize for analytics
- heavily dependent on manual spreadsheet manipulation for weekly reporting

This created slow feedback loops and prevented reliable KPI governance.

## Approach (High Level)
1. **Ingest** legacy exports into a consistent staging format  
2. **Transform** into a star schema aligned to executive KPIs  
3. **Govern** metrics through a documented dictionary (single definitions + owners)  
4. **Publish** executive-ready views suitable for Tableau/Power BI

## Architecture Overview

![ETL Architecture](visuals/IMG_1420.png)

This diagram illustrates the flow from legacy POS export → staging → dimensional model → governed executive KPI views → BI layer.

## Repository Structure

This case study is organized into five executive-facing layers:

### 1️⃣ Architecture & Data Modeling
- [ETL Architecture Overview](docs/etl-architecture.md)  
- [Star Schema Definition](sql/00_schema.sql)  
- [Governed KPI Views](sql/01_views.sql)

### 2️⃣ Governance Framework
- [Executive Source of Truth Model](docs/executive-source-of-truth.md)  
- [KPI Metric Dictionary](governance/metric_dictionary.md)

### 3️⃣ Data Standardization
- [Raw-to-Staging Field Mapping](docs/data-dictionary.md)  
- [Synthetic POS Dataset](data/raw_pos_export.csv)

### 4️⃣ Analytical Validation
- [Sample Executive Queries](analysis/sample_queries.sql)

### 5️⃣ Business Impact Modeling
- [Executive KPI Impact Simulation](analysis/executive_kpi_impact_simulation.md)

## Data Model (Star Schema)
This repo models reporting around:
- **Fact tables:** sales, labor, promos (extensible)
- **Dimension tables:** date, location, product, employee/role (as needed)

See: `sql/00_schema.sql`

## Governance: Executive Source of Truth
This project emphasizes that dashboards are only as good as their definitions.
- Each KPI has an owner, formula, refresh cadence, and intended decision use.
- “One metric, one definition” enforced through the dictionary + views.

See: `governance/metric_dictionary.md` and `docs/executive-source-of-truth.md`

## How to Navigate This Case Study

For executive review:

1. Read the Executive Summary.
2. Review the Architecture Overview to understand data flow.
3. Examine the Governance Framework to see how KPIs are standardized.
4. Review the Executive KPI Impact Simulation to understand quantified business leverage.

For technical review:

1. Inspect the Star Schema (`sql/00_schema.sql`).
2. Review Governed KPI Views (`sql/01_views.sql`).
3. Validate calculations using Sample Queries (`analysis/sample_queries.sql`).

This repository is structured to support both executive-level and technical evaluation.

## What I’d Improve Next
- Automate quality checks (schema validation, null thresholds, outlier flags)
- Add incremental refresh logic and audit logs
- Expand to forecasting (labor elasticity + product mix optimization)

---
**Author:** Wolfgang Welch  
**Focus:** BI Architecture • Program Delivery • Operational Analytics
