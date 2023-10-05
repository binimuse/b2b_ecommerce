class ProdactDeatilQueryMutation {
  static const String getMyProdactDetail = r'''
query($id: ID!) {
    product(id: $id) {
        id
        name
        description
        images
        {
          original_url
        }
          skus {
            id
            price
            sku
            
            variants {
                attribute {
                    name
                }
                attributeValue {
                    value
                }
            }
        }
        }
}
 ''';
}
