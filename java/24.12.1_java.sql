WITH aggregated_bids AS (
    SELECT 
        b.contract_id,
        SUM(b.amount) FILTER (WHERE b.action = 'long') AS long_amount,
        SUM(b.amount) FILTER (WHERE b.action = 'short') AS short_amount
    FROM 
        bids b
    GROUP BY 
        b.contract_id
)
SELECT 
    c.*, 
    a.long_amount, 
    a.short_amount
FROM 
    contracts c
LEFT JOIN 
    aggregated_bids a 
ON 
    a.contract_id = c.id;