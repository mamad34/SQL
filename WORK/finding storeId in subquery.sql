
export const findAmazonOrderIdSql = `SELECT id
                                      FROM orders_summary
                                      WHERE $1 = ANY(list)
                                      AND store_id = (
                                        SELECT store_id
                                        FROM free_gift_store
                                        WHERE id = $2
                                      );`;

export const findFreeGiftUserOrderIdSql = `SELECT order_id 
                                            FROM free_gift_user
                                            WHERE order_id = $1
                                            AND store_id = $2;`;

export const findWalmartOrderIdSql = `SELECT id
                                      FROM walmart_orders_summary
                                      WHERE $1 = ANY(list)
                                      AND store_id = (
                                        SELECT store_id
                                        FROM free_gift_store
                                        WHERE id = $2
                                      );`;
