import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/app/modules/categories_detail/data/mutation/catagories_detail_query_mutation.dart';
import 'package:b2b_ecommerce/app/modules/home/data/models/catagories_model.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:b2b_ecommerce/constant/shimmer_loading.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CategoriesDetailController extends GetxController {
  final reusableWidget = ReusableWidget();
  final shimmerLoading = ShimmerLoading();

  var loading = false.obs;
  final count = 0.obs;
  var catagoriDetailData = <CategoriesModel>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(CatagoriesDeatilQueryMutation.getMyDrugCatagoriesDetail),
        variables: <String, dynamic>{
          'id': int.parse(Get.arguments),
        },
      ),
    );

    if (!result.hasException) {
      loading(true);

      for (var i = 0; i < result.data!["category"]["children"].length; i++) {
        for (var j = 0;
            j < result.data!["category"]["children"][i]["products"].length;
            j++) {
          catagoriDetailData.add(CategoriesModel(
              id: result.data!["category"]["children"][i]["products"][j]["id"],
              name: result.data!["category"]["children"][i]["products"][j]
                  ["name"],
              iamgelink: result.data!["category"]["image"],
              children_count: 0,
              description: result.data!["category"]["children"][i]["products"]
                  [j]["description"]));
        }

        //   print(id);

        loading(false);
      }
    } else {
      //  print(result.exception);
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
