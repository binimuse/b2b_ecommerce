// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:b2b_ecommerce/app/modules/product_detail/data/model/vari_model.dart';

class CartModel {
  late int id;
  late String prodactName;
  late String prodactDesc;

  late String image;

  late var price;
  late int qty;
  late List<VariModel> variModels;
  CartModel({
    required this.id,
    required this.image,
    required this.prodactName,
    required this.prodactDesc,
    required this.price,
    required this.qty,
    required this.variModels,
  });
}
