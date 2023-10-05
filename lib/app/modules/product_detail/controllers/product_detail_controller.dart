import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/app/modules/product_detail/data/model/skul_model.dart';
import 'package:b2b_ecommerce/app/modules/product_detail/data/model/vari_model.dart';
import 'package:b2b_ecommerce/app/modules/product_detail/data/mutation/cart_mutation.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:b2b_ecommerce/constant/shimmer_loading.dart';
import 'package:b2b_ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/mutation/prodact_detail_query_mutation.dart';

class ProductDetailController extends GetxController {
  final reusableWidget = ReusableWidget();
  var shimmerLoading = ShimmerLoading();
  var loadingimage = false.obs;
  var loading = false.obs;

  final count = 0.obs;

  var sku = <SkuModel>[].obs;
  var variants = <VariModel>[].obs;

  var idsku = ''.obs;
  var idprodact = ''.obs;
  var name = ''.obs;
  late double price;
  var cartnumber = 1.obs;
  List<String> imagelink = [];
  var description = "".obs;
  var attributes_name = "".obs;
  var values = "".obs;

  @override
  void onInit() {
    getData();

    super.onInit();
  }

  void addToCart(invId) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(CartMutation.addToCart),
        variables: <String, dynamic>{
          'quantity': cartnumber.toInt(),
          'product_sku': invId,
        },
      ),
    );
    if (!result.hasException) {
      Get.snackbar(
        "Success",
        "Item added to cart",
        icon: const Icon(Icons.shop_2_outlined, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[300],
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } else {
      Get.snackbar(
        "Error",
        "Item is already in cart",
        icon: const Icon(Icons.shop_2_outlined, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[300],
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );

      print(result.exception);
    }
  }

  Future<void> getData() async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(ProdactDeatilQueryMutation.getMyProdactDetail),
        variables: <String, dynamic>{
          'id': int.parse(Get.arguments['product'].toString()),
        },
      ),
    );

    if (!result.hasException) {
      loadingimage(true);
      idprodact.value = result.data!["product"]["id"];
      name.value = result.data!["product"]["name"];

      description.value = result.data!["product"]["description"];

      for (var j = 0; j < result.data!["product"]["images"].length; j++) {
        imagelink.add(result.data!["product"]["images"][j]["original_url"]);
      }

      for (var i = 0; i < result.data!["product"]["skus"].length; i++) {
        List<VariModel> variModels = [];
        for (var k = 0;
            k < result.data!["product"]["skus"][i]["variants"].length;
            k++) {
          variModels.add(VariModel(
            attributename: result.data!["product"]["skus"][i]["variants"][k]
                ["attribute"]["name"],
            attributeValues: result.data!["product"]["skus"][i]["variants"][k]
                ["attributeValue"]["value"],
          ));
        }

        sku.add(SkuModel(
          id: result.data!["product"]["skus"][i]["id"],
          sku: result.data!["product"]["skus"][i]["sku"],
          price: result.data!["product"]["skus"][i]["price"],
          variModels: variModels,
        ));
      }
      loading(true);
    } else {
      loading(false);
      loadingimage(false);
      print(result.exception);
      print("result.exception");
    }
  }
}
