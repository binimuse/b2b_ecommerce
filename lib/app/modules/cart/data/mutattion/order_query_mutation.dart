class OrderQueryMutation {
  static const String createOrder = r'''
    mutation createOrder(){
    action: createOrder {
       id
      total_price
      items{
                id

      }
      }
    }
    ''';
}
