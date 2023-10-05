class CartMutation {
  static const String addToCart = r'''
    mutation  createCart($quantity: Int!,$product_sku: ID!){
      action: createCart(input: { quantity: $quantity , product_sku: {connect: $product_sku}}){
        id
        quantity
      }
    }
 ''';
}
