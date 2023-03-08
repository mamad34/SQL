SELECT wai.id, TO_CHAR( wai.receiving_date, 'mm/dd/yyyy') AS receiving_date, wai.placement, p.sku, wai.hall, wai.number_of_boxes, wai.units_per_box,
                  wai.number_of_boxes * wai.units_per_box AS total, wai.unit_price, 
                  wai.number_of_boxes * wai.units_per_box * wai.unit_price AS total_price, wai.comments, s.name,
                  wai.placement NOT IN (
                    SELECT wrip.placement
                    FROM warehouse_receiving_schedule AS wrs
                    JOIN warehouse_receiving_item AS wri
                    ON wrs.id = wri.receiving_id
                    JOIN warehouse_receiving_item_pallet AS wrip
                    ON wri.id = wrip.receiving_item_id
                    WHERE wrs.received = false 
                    AND wrs.pre_received = true 
                    UNION
                    SELECT wsip.placement
                    FROM warehouse_shipping_schedule AS wss
                    JOIN warehouse_shipping_item AS wsi
                    ON wss.id = wsi.shipping_id
                    JOIN warehouse_shipping_item_pallet AS wsip
                    ON wsi.id = wsip.shipping_item_id
                    WHERE wss.outbounded = false 
                    AND wss.pre_outbounded = true 
                  ) AS editable
                  FROM warehouse_available_inventory AS wai
                  LEFT JOIN products AS p
                  ON p.id = wai.sku_id
                  LEFT JOIN stores AS s
                  ON p.store_id = s.id
                  WHERE wai.warehouse_id = $1