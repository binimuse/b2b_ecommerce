class GetOrderQueryMutation {
  dynamic getMyOrdersHistory() {
    return """
      query 
         {
           auth{
          retailer{
          orders{
          
            id
            total_price
            items {
              id
              quantity
              product_sku{
                 price 
                 product{
                  name
                  id
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
  }
  }
    """;
  }
}
