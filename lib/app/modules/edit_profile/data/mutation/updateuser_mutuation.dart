class UpdateProfileQueryMutation {
  static const String updateProfile = r'''
    mutation updateRetailer($id: ID!, $name:String!, $city: String!, $address: String!, $contact_phone: String!,  $contact_name: String!){
    action: updateRetailer(id: $id input: {
    
      name: $name,
      address: $address,
      city: $city,
      contact_phone: $contact_phone,   
      contact_name: $contact_name,   
      
     
    }) {
        name
      }
    }
    ''';
}
