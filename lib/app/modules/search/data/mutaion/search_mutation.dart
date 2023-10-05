class SearchQueryMutation {
  dynamic getMysearch(String search) {
    return """
query {
    searchProduct(search: "$search") {
     id
    name
    category{
        products
        {
            id
            name
            images
            {
                original_url

            }
            description
        }
    }
    }
}
    """;
  }
}
