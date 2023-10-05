// ignore_for_file: non_constant_identifier_names

import 'package:b2b_ecommerce/app/modules/home/data/mutation/product_query_mutation.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../Services/graphql_conf.dart';
import '../../../../constant/reusable_widget.dart';
import '../../../../constant/shimmer_loading.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../data/models/catagories_model.dart';
import '../data/models/product_model.dart';
import '../data/mutation/catagories_query_mutation.dart';

class HomeController extends GetxController {
  WalletController walletController = Get.put(WalletController());
  final count = 0.obs;

  final shimmerLoading = ShimmerLoading();
  final reusableWidget = ReusableWidget();

  var loading = false.obs;
  var loadingProdact = false.obs;

  var catagoriData = <CategoriesModel>[].obs;
  var ProdactData = <ProdactModel>[].obs;

  @override
  void onInit() {
    walletController.gwtwalletammount();
    getCategories();
    getProdact();
    super.onInit();
  }

  Future<void> getCategories() async {
    loading(true);

    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    CatagoriesQueryMutation drugCatagoriesQueryMutation =
        CatagoriesQueryMutation();
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.query(
      QueryOptions(
        document: gql(drugCatagoriesQueryMutation.getMyCatagories(
            int.parse("10"), int.parse("1"))),
      ),
    );

    if (!result.hasException) {
      for (var i = 0; i < result.data!["categories"]["data"].length; i++) {
        catagoriData.add(CategoriesModel(
          id: result.data!["categories"]["data"][i]["id"],
          name: result.data!["categories"]["data"][i]["name"],
          iamgelink: result.data!["categories"]["data"][i]["image"],
          children_count: result.data!["categories"]["data"][i]
              ["children_count"],
        ));

        loading(false);
      }
    } else {
      print("object");
      print("haha ${catagoriData.length}");
      print(result.exception);
    }
  }

  Future<void> getProdact() async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    ProdactQueryMutation prodactQueryMutation = ProdactQueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(
            prodactQueryMutation.getMyProdact(int.parse("10"), int.parse("1"))),
      ),
    );

    if (!result.hasException) {
      loadingProdact(true);

      for (var i = 0; i < result.data!["products"]["data"].length; i++) {
        for (var j = 0;
            j < result.data!["products"]["data"][i]["images"].length;
            j++) {
          ProdactData.add(ProdactModel(
            id: result.data!["products"]["data"][i]["id"],
            name: result.data!["products"]["data"][i]["name"],
            iamgelink: result.data!["products"]["data"][i]["images"][j]
                ["original_url"],
            description: result.data!["products"]["data"][i]["description"],
          ));

          loadingProdact(false);
        }
      }
    } else {
      print("object");
      print(result.exception);
    }
  }



  void increment() => count.value++;
}
