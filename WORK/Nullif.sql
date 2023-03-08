CASE WHEN month_profit_1 IS NULL
                        THEN ((s.month_price_1 - fdp.breakeven_price) * 0.85 * s.month_items_1) / NULLIF(lc.latest_cogs,0)
                        ELSE (
                          CASE WHEN fdp.profit_date BETWEEN '12/01/2022' AND '12/31/2022'
                            THEN (((s.profit_month_price - fdp.breakeven_price) * 0.85 * s.profit_month_items) + dp.month_profit_1) / NULLIF(lc.total_month_cogs_1,0)
                            ELSE dp.month_profit_1 / NULLIF(lc.total_month_cogs_1,0)
                          END

