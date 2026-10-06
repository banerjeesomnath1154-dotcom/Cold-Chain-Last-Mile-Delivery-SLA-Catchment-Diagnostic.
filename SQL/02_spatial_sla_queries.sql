-- =====================================================================
-- PROJECT 3: COLD-CHAIN & LAST-MILE DELIVERY SLA CATCHMENT DIAGNOSTIC
-- SQLite Analytics & Window Functions for Dark Store Fleet Performance
-- =====================================================================

-- Query 1: Zone-Wise SLA Compliance & Spoilage Loss Summary
SELECT 
    city,
    zone,
    store_id,
    fleet_type,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(order_value_inr), 2) AS gross_revenue_inr,
    ROUND(SUM(spoilage_loss_inr), 2) AS total_spoilage_loss_inr,
    ROUND(AVG(actual_delivery_mins), 1) AS avg_delivery_time_mins,
    ROUND((1.0 - (SUM(sla_breached) * 1.0 / COUNT(order_id))) * 100, 2) AS sla_compliance_pct
FROM orders_sla
GROUP BY city, zone, store_id, fleet_type
ORDER BY total_spoilage_loss_inr DESC;

-- Query 2: Ranking Dark Stores by Perishable Thermal Spoilage Rate Using Window Functions
WITH PerishableStats AS (
    SELECT 
        city,
        zone,
        store_id,
        fleet_type,
        COUNT(order_id) as perishable_orders,
        SUM(thermal_spoilage_flag) as spoilage_incidents,
        ROUND(SUM(spoilage_loss_inr), 2) as spoilage_loss
    FROM orders_sla
    WHERE category IN ('Dairy & Ice Cream', 'Frozen Meat', 'Fresh Produce')
    GROUP BY city, zone, store_id, fleet_type
)
SELECT 
    RANK() OVER (ORDER BY spoilage_loss DESC) as spoilage_rank,
    city,
    zone,
    store_id,
    fleet_type,
    perishable_orders,
    spoilage_incidents,
    ROUND((spoilage_incidents * 100.0 / perishable_orders), 2) as spoilage_rate_pct,
    spoilage_loss
FROM PerishableStats;

-- Query 3: Distance Band Analysis for 10-Min vs 15-Min Catchment SLA Breaches
SELECT 
    CASE 
        WHEN distance_km <= 1.5 THEN '0.0 - 1.5 km (Core 10-Min SLA)'
        WHEN distance_km <= 3.0 THEN '1.5 - 3.0 km (Extended 10-Min SLA)'
        WHEN distance_km <= 4.5 THEN '3.0 - 4.5 km (Standard 15-Min SLA)'
        ELSE '4.5+ km (Outer SLA Risk Zone)'
    END AS distance_catchment_band,
    COUNT(order_id) AS total_orders,
    SUM(sla_breached) AS sla_breaches,
    ROUND((SUM(sla_breached) * 100.0 / COUNT(order_id)), 2) AS breach_rate_pct,
    ROUND(AVG(actual_delivery_mins), 1) AS avg_delivery_mins
FROM orders_sla
GROUP BY distance_catchment_band
ORDER BY avg_delivery_mins ASC;
