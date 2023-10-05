
import 'package:b2b_ecommerce/app/modules/my_orders/data/model/shipment_model.dart';


class OrderDetailModel {
  late String iid;

  late var price;
  late var quantity;
  late String pname;
  late String pimage;
  late List<ShipModel> shipModel;

  OrderDetailModel({
    required this.iid,
    required this.price,
    required this.quantity,
    required this.pname,
    required this.pimage,
    required this.shipModel,
  });
}
