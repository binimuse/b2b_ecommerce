class UpdatedropoffMutation {
  static const String updateDropoff = r'''
mutation($id: ID!, $order_received: Boolean!, $order_recived_id: ID!) {
  updateDropoff(id: $id, input: {
    orders: {
      received: $order_received
      id: $order_recived_id
    }
  }) {
    id
    dropoff_order {
        id
        received
    }
  }
}
 ''';
}

// ignore_for_file: file_names

