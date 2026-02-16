# Executive Source of Truth

## Purpose
This document defines how executive metrics are standardized so that:
- dashboards cannot “redefine” KPIs
- weekly reporting is consistent across time
- leadership decisions are driven by governed definitions

> Principle: **One metric, one definition.**

## What This Solves
Legacy reporting commonly breaks when:
- different teams calculate the same KPI differently
- filters/logic change inside dashboards without documentation
- exports contain inconsistent fields and naming

This governance layer prevents metric drift.

## Governance Model

### 1) Metric Dictionary (Single Source of Definitions)
All KPIs are defined in:
- `governance/metric_dictionary.md`

Each KPI includes:
- **Metric name**
- **Definition**
- **Formula**
- **Owner**
- **Refresh cadence**
- **Decision use** (what the metric is used to decide)

### 2) Executive Views (Enforcement Layer)
KPIs are calculated in SQL views so BI tools do not re-implement logic:
- `sql/01_views.sql`

Dashboards should reference these views directly.

### 3) Change Control (How Metrics Get Updated)
If a KPI definition changes:
1. Update the metric definition in the dictionary
2. Update the SQL view that produces it
3. Record the change (date + reason) in the dictionary entry

## KPI Cadence (Operating Rhythm)
Recommended cadence:
- **Daily:** operational pulse checks (optional)
- **Weekly:** executive deep dive (primary cadence)
- **Monthly:** trend analysis + strategy adjustments

## Quality Checks (Minimum Standards)
Before publishing metrics:
- required fields are present (date, location, product, total_amount)
- null rates are within acceptable thresholds
- outliers are reviewed (spikes/drops)
- definitions match the metric dictionary

## Outcome
This creates an executive reporting system where:
- KPIs are stable
- drill-downs are trusted
- leaders spend time deciding, not debating data
