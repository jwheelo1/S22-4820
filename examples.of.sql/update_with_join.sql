UPDATE purchaseOrder p LEFT JOIN itemsOrdered i
    ON p.purchaseOrder_ID = i.purchaseOrder_ID
   AND i.status = 'PENDING'
SET    p.purchaseOrder_status = 'COMPLETED'
WHERE  p.purchaseOrder_ID = '@purchaseOrder_ID'
   AND i.purchaseOrder_ID IS NULL
