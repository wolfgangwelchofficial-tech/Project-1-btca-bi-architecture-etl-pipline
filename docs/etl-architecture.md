# ETL Architecture Overview

> **Goal:** Convert inconsistent legacy POS exports into a governed, executive-ready reporting layer.

## Architecture at a Glance

```mermaid
flowchart LR
  A[Legacy POS Export<br/>CSV / XLS] --> B[Staging: Raw Landing<br/>data/raw_pos_export.csv]
  B --> C[Normalization<br/>field mapping + cleaning]
  C --> D[Star Schema Load<br/>fact + dimension tables]
  D --> E[Executive Views<br/>KPI-ready SQL views]
  E --> F[BI Layer<br/>Tableau / Power BI]
  E --> G[Metric Governance<br/>Metric Dictionary]
