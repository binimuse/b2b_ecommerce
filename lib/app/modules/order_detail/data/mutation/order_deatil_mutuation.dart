class GetOrderDetailQueryMutation {
  static const String getMyOrdersDeatil = r'''
query($id: ID!) {
  
    order(id: $id) {
        id
        total_price
       
        items
        {
          id
          quantity
                product_sku {
                    price
                    product{
                        name
                        images{
                            original_url
                        }
                    }
                    
                }
        
                shipment_items {
                id
                shipment {
                id
                departure_time
                arrival_time
                status
                from {
                    __typename
                    ... on Warehouse {
                    name
                    
                    }
                }
                to {
                    __typename
                    ... on Distributor {
                    id
                    name
                    }
                }
                }
              }
            }
  }
}
 ''';
}
