import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/app/modules/cart/data/model/cart_model.dart';
import 'package:b2b_ecommerce/app/modules/cart/data/mutattion/cart_mutuation.dart';
import 'package:b2b_ecommerce/app/modules/product_detail/data/model/vari_model.dart';
import 'package:b2b_ecommerce/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:b2b_ecommerce/app/routes/app_pages.dart';
import 'package:b2b_ecommerce/constant/global_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/mutattion/order_query_mutation.dart';

class CartController extends GetxController {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  var loadingCart = false.obs;
  var isLoading = false.obs;
  var totalPrice = 0.obs;
  List<String> imagelink = [];
  WalletController walletController = Get.put(WalletController());
  var cartList = <CartModel>[].obs;
  final globalFunction = GlobalFunction();
  final count = 0.obs;
  void countTotalPrice() {
    totalPrice(0);
    for (int i = 0; i < cartList.length; i++) {
      totalPrice += cartList[i].price.toInt() * cartList[i].qty.toInt();
    }
  }

  @override
  void onInit() {
    getMyCart();

    super.onInit();
  }

  void getMyCart() async {
    CartQueryMutation cartQueryMutation = CartQueryMutation();
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.query(
      QueryOptions(
        document: gql(cartQueryMutation.getMyCarts()),
      ),
    );

    if (!result.hasException) {
      loadingCart(true);
      for (var i = 0;
          i < result.data!["auth"]["retailer"]["carts"].length;
          i++) {
        List<VariModel> variModels = [];

        for (var k = 0;
            k <
                result
                    .data!["auth"]["retailer"]["carts"][i]["product_sku"]
                        ["variants"]
                    .length;
            k++) {
          variModels.add(VariModel(
            attributename: result.data!["auth"]["retailer"]["carts"][i]
                ["product_sku"]["variants"][k]["attribute"]["name"],
            attributeValues: result.data!["auth"]["retailer"]["carts"][i]
                ["product_sku"]["variants"][k]["attributeValue"]["value"],
          ));
        }

        cartList.add(CartModel(
          id: int.parse(result.data!["auth"]["retailer"]["carts"][i]["id"]),
          qty: result.data!["auth"]["retailer"]["carts"][i]["quantity"],
          prodactName: result.data!["auth"]["retailer"]["carts"][i]
              ["product_sku"]["product"]["name"],
          prodactDesc: result.data!["auth"]["retailer"]["carts"][i]
              ["product_sku"]["product"]["description"],
          price: result.data!["auth"]["retailer"]["carts"][i]["product_sku"]
              ["price"],
          image: result.data!["auth"]["retailer"]["carts"][i]["product_sku"]
              ["product"]["images"][0]["original_url"],
          variModels: variModels,
        ));
      }

      loadingCart(false);
      countTotalPrice();
    } else {}
  }

  void deleteCartItem(idx) async {
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(CartQueryMutation.deleteCart),
        variables: <String, dynamic>{
          'id': cartList[idx].id,
        },
      ),
    );

    if (!result.hasException) {
      var id = cartList[idx].id;
      cartList.removeWhere((item) => item.id == id);
      countTotalPrice();
    } else {}
  }

  void updateCartAmount(action, idx) async {
    isLoading(true);

//for demo I had use delayed method. When you integrate use your api //call here.

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    if (action == "minus" && cartList[idx].qty != 1) {
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(CartQueryMutation.updateCart),
          variables: <String, dynamic>{
            'id': cartList[idx].id,
            'quantity': cartList[idx].qty - 1,
          },
        ),
      );
      if (!result.hasException) {
        isLoading(false);
        cartList[idx].qty--;
        cartList.refresh();
        countTotalPrice();
      } else {}
    } else if (action == "plus") {
      isLoading(true);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(CartQueryMutation.updateCart),
          variables: <String, dynamic>{
            'id': cartList[idx].id,
            'quantity': cartList[idx].qty + 1,
          },
        ),
      );
      if (!result.hasException) {
        isLoading(false);
        cartList[idx].qty++;

        cartList.refresh();
        countTotalPrice();
      } else {}
    } else {}
  }

  submitOrder() async {
    var idList = [];

    for (var i = 0; i < cartList.length; i++) {
      idList.add(cartList[i].id);
    }

    if (idList.isNotEmpty) {
      GraphQLClient client = graphQLConfiguration.clientToQuery();

      QueryResult result = await client.query(
        QueryOptions(
          document: gql(OrderQueryMutation.createOrder),
        ),
      );

      if (!result.hasException) {
        cartList.clear();

        Get.snackbar(
          "Successfully Ordered",
          "The order will arrive after 3 hours please dont close your phone",
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

        Get.toNamed(Routes.MY_ORDERS);
        walletController.gwtwalletammount();
        walletController.update();
      } else {
        Get.snackbar(
          "Error",
          "Wallet is empty",
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
      }
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
