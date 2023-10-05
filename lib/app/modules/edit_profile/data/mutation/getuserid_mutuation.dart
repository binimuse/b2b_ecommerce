class UserIdMutation {
  dynamic getMyUserId() {
    return """
      query 
         {
            auth{
          retailer{
          name
         id
         address
         city
         contact_phone
         contact_email
         }
      }
      }
    """;
  }
}
