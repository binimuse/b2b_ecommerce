class CartQueryMutation {
  dynamic getMyCarts() {
    return """
      query 
         {
          auth{
          retailer{
          carts{
          
            id
            quantity
            product_sku {
                    variants
                {
                    attribute
                    {
                        name
                    }
                    attributeValue
                    {
                        value
                    }
                }
              price
              product{
                 name 
                 description
                  images{
                        original_url
                    }         
              }
              }
            
            
          }
           }
         }
      }
    """;
  }

  static const String updateCart = r'''
    mutation updateCart($id: ID!, $quantity: Int!){
    action: updateCart(
      id: $id,
      input: {
        quantity: $quantity
      }) {
        id
        quantity
      }
    }
    ''';

  static const String deleteCart = r''' 
    mutation DeleteCart($id: ID!){
      action : deleteCart(id: $id){
          id
        }
    }
    ''';
}
