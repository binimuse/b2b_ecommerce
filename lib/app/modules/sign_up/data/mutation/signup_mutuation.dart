class SignupQueryMutation {
  static const String register = r'''
mutation($name: String!, $email: String!, $password: String!, $password_confirmation: String!) {
    register(input: {
        name: $name
        email: $email
        password: $password
        password_confirmation: $password_confirmation
    }) {
        token
        status
    }
}
 ''';
}
