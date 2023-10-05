class CatagoriesDeatilQueryMutation {
  static const String getMyDrugCatagoriesDetail = r'''
query($id: ID!) {
    category(id: $id) {
    name
    image
    children_count
    children{
        products {
            id
            name
            description
      
            
        }
        }
    }
}
 ''';
}
