class CatagoriesQueryMutation {
  dynamic getMyCatagories(int first, int page) {
    return """
query {
    categories(first: $first, page: $page, parentOnly: true) {
        data {
             id
            name
            isParent 
            image
            children_count
            
        
        }
    }
}
    """;
  }
}
