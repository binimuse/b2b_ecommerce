import 'package:b2b_ecommerce/app/modules/my_orders/data/model/shipment_model.dart';

class OrderHistoryModel {
  late String oid;
  late String created_at_human;
  late var total_price;

  late List<OrderItemModel> items;

  OrderHistoryModel({
    required this.oid,
    required this.total_price,
    required this.created_at_human,
    required this.items,
  });
}

class OrderItemModel {
  late int iid;
  late String name;
  late String image;
  late var price;
  late var quantity;
  late List<ShipModel> shipModel;

  OrderItemModel({
    required this.iid,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.shipModel,
  });
}
