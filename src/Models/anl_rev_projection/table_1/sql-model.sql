WITH mrt_orders_1 AS 
  (
        SELECT 
        *
        ,CONCAT(EXTRACT(year from order_created_at_date),'-',EXTRACT(month from order_created_at_date)) as month
    FROM @mrt_orders.mrt_orders.c3JjL01vZGVscy9tcnRfb3JkZXJzL21ydF9vcmRlcnM=
    )

, aggregated AS
    (
        SELECT 
        month
        ,SUM(net_sales) as mtd_sales
        ,MAX(order_created_at_date) as mtd_date
        FROM mrt_orders_1
        GROUP BY month
    )

SELECT 
month
,mtd_sales
,mtd_date
,(mtd_sales/EXTRACT(day from mtd_date)) * EXTRACT(day from (LAST_DAY(mtd_date))) as projected_rev
FROM aggregated 
