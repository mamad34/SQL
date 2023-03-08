   SELECT ach.sku_id,
                MAX(CASE WHEN created_on = fdp.profit_date THEN
                  (CASE WHEN cogs IS NULL THEN COALESCE(fdp.unit_sold,0) * lcp.last_unit_price
                  ELSE cogs END) END) AS latest_cogs,
                  SUM(CASE WHEN ach.created_on BETWEEN '12/01/2022' AND '12/31/2022'
                      THEN (
                        CASE WHEN cogs IS NULL
                          THEN COALESCE(fdp.unit_sold,0) * lcp.last_unit_price
                          ELSE ach.cogs
                        END
                      )
                    END)::REAL AS month_cogs_1,
                    SUM(CASE WHEN ach.created_on BETWEEN '12/01/2021' AND '12/01/2022'
                      THEN (
                        CASE WHEN cogs IS NULL
                          THEN COALESCE(fdp.unit_sold,0) * lcp.last_unit_price
                          ELSE ach.cogs
                        END
                      )
                    END)::REAL AS year_cogs_1,
                    SUM(CASE WHEN ach.created_on BETWEEN '12/01/2022' AND '12/31/2022'
                      THEN (
                        CASE WHEN cogs IS NULL
                          THEN COALESCE(fdp.unit_sold,0) * lcp.last_unit_price * COALESCE(fdp.unit_sold,0)
                          ELSE ach.cogs * ach.amount
                        END
                      )
                    END)::REAL AS total_month_cogs_1,
                    SUM(CASE WHEN ach.created_on BETWEEN '12/01/2021' AND '12/01/2022'
                      THEN (
                        CASE WHEN cogs IS NULL
                          THEN COALESCE(fdp.unit_sold,0) * lcp.last_unit_price * COALESCE(fdp.unit_sold,0)
                          ELSE ach.cogs * ach.amount
                        END
                      )
                    END)::REAL AS total_year_cogs_1,
                    SUM(CASE WHEN ach.created_on BETWEEN '12/01/2021' AND '12/31/2022'
                      THEN (
                        CASE WHEN cogs IS NULL
                          THEN COALESCE(fdp.unit_sold,0) * lcp.last_unit_price
                          ELSE ach.cogs
                        END
                      )
                    END)::REAL AS time_frame_cogs_1