import 'package:b2b_ecommerce/app/modules/product_detail/data/model/vari_model.dart';

class SkuModel {
  late String id;
  late var price;
  late String sku;
  late List<VariModel> variModels;

  SkuModel({
    required this.id,
    required this.price,
    required this.sku,
    required this.variModels,
  });
}
