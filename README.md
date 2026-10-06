# 🚚 Cold-Chain & Last-Mile Delivery SLA Catchment Diagnostic

An end-to-end spatial logistics, SQL window analytics, Python catchment buffer diagnostic, and Excel financial reconciliation model evaluating quick-commerce dark store performance, 10-min delivery SLA breaches, and cold-chain thermal spoilage losses across Indian metros.

---

## 📌 Executive Summary & Business Problem

Quick-commerce operators face intense margin compression due to last-mile fulfillment friction and high perishable spoilage during ambient transit. 

This project analyzes **1,000 order fulfillments** across **8 dark store hubs** in **4 major metros** (*Bengaluru, Mumbai, Delhi-NCR, Hyderabad*) to evaluate SLA breach drivers, fleet thermal performance, and catchment cannibalization.

### 💡 Key Findings
* **The 3.0 km SLA Threshold:** Deliveries under 1.5 km achieve 94%+ SLA compliance. Beyond 3.0 km, breach rates reach nearly 50%.
* **Cold-Chain Thermal Degradation:** Uninsulated delivery bikes on routes exceeding 11 minutes accounted for **100% of perishable spoilage write-offs**.
* **Reconciliation Precision:** Confirmed **₹0.00 variance** between raw order logs and SQL store aggregate summaries in Excel.

---

## 🛠️ Tech Stack & Directory Layout

| Layer | Tool | Key Methods |
| :--- | :--- | :--- |
| **1. Spatial EDA & Cleaning** | Python 3.12, Pandas, NumPy | Catchment binning, distance friction modeling, thermal spoilage flag engineering. |
| **2. Relational SQL Warehouse** | SQLite 3 | Window Functions (`RANK() OVER`), distance band aggregation, spoilage rate ranking. |
| **3. Audit Reconciliation** | Microsoft Excel | Summary Dashboard, IF/ROUND verification formulas, store-level KPI breakdown. |
| **4. Executive Reporting** | Markdown / BI | Executive brief, operational recommendations, SLA buffer maps. |

```text
cold-chain-catchment-spatial-analyzer/
│
├── data/
│   ├── dark_store_orders_raw.csv         # Raw order & transit log dataset
│   ├── dark_store_orders_clean.csv        # Cleaned dataset with net revenue
│   ├── cold_chain_sla.db                 # SQLite relational spatial database
│   └── dark_store_performance_summary.csv # Store-level KPI summary export
│
├── notebooks/
│   └── 01_spatial_catchment_analysis.ipynb # Pandas/Python spatial notebook
│
├── sql/
│   └── 02_spatial_sla_queries.sql        # SQL analytics & window function queries
│
├── excel/
│   └── sla_spoilage_reconciliation.xlsx   # Audit-ready Excel reconciliation model
│
├── EXECUTIVE_REPORT_COLD_CHAIN_SLA.md    # Executive policy & operational brief
└── README.md                             # Master repository documentation
```

---

## 👤 Author & Contact
* **Author:** [Your Name]
* **Role:** Aspiring Business Analyst & Geospatial BI Specialist
* **LinkedIn:** [Insert Your LinkedIn Profile Link]
* **GitHub:** [Insert Your GitHub Profile Link]
