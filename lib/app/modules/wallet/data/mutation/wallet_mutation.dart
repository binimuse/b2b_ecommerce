class DepositeQueryMutation {
  static const String deposite = r'''
    mutation ($amount: Float!, $reference_number: String!,$slip:Upload!){
    action: createDepositSlip(input: {
      amount: $amount,
      reference_number: $reference_number,   
      slip: $slip,   
     
    }) {
        reference_number
      }
    }
    ''';
}

class AppDataMutation {
  dynamic getWalletHistory() {
    return """
              query {
        depositSlipHistory {
    id
    reference_number
    amount
    confirmed_at
    confirmed_at_human
  }
              }
    """;
  }
}

class WalletMutation {
  dynamic getwalletAmmount() {
    return """
              query {
        walletBalance 
              }
    """;
  }
}
