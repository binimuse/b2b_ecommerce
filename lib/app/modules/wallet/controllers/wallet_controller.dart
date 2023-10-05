import 'dart:io';

import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/app/modules/wallet/data/mutation/wallet_mutation.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:b2b_ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../data/model/depositedata_model.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class WalletController extends GetxController {
  var loadingnew = false.obs;
  final GlobalKey<FormState> depositeform = GlobalKey<FormState>();
  final reusableWidget = ReusableWidget();
  var deposietData = <DeposteModel>[].obs;
  var selectedImagePath = ''.obs;
  var images = <File>[].obs;
  var updatepro = false.obs;
  var loadingappdata = false.obs;
  var loadingWallet = false.obs;
  final count = 0.obs;
  late TextEditingController amount, transaction;
  var walletamount = '0'.obs;
  @override
  void onInit() {
    loadingnew(true);
    getDepositeHistory();
    gwtwalletammount();
    amount = TextEditingController();
    transaction = TextEditingController();
    super.onInit();
  }

  Future<void> gwtwalletammount() async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    WalletMutation walletMutation = WalletMutation();
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.query(
      QueryOptions(
        document: gql(walletMutation.getwalletAmmount()),
      ),
    );

    if (!result.hasException) {
      loadingWallet(true);
      walletamount.value = result.data!["walletBalance"].toString();

      update();
    } else {
      loadingWallet(false);
    }
  }

  Future<void> getDepositeHistory() async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
    AppDataMutation appDataMutation = AppDataMutation();
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.query(
      QueryOptions(
        document: gql(appDataMutation.getWalletHistory()),
      ),
    );

    if (!result.hasException) {
      deposietData.clear;
      loadingappdata(true);
      for (var i = 0; i < result.data!["depositSlipHistory"].length; i++) {
        deposietData.add(DeposteModel(
          id: result.data!["depositSlipHistory"][i]["id"],
          reference_number: result.data!["depositSlipHistory"][i]
              ["reference_number"],
          amount: result.data!["depositSlipHistory"][i]["amount"],
          confirmed_at: result.data!["depositSlipHistory"][i]["confirmed_at"],
        ));
      }
      loadingappdata(false);
    } else {
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide transaction refrence number";
    }
    return null;
  }

  String? validatamount(String value) {
    if (value.isEmpty) {
      return "Please provide amount";
    }
    return null;
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      images.add(File(selectedImagePath.value));
    } else {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  deposite() async {
    updatepro(true);
    var byteData = File(selectedImagePath.value).readAsBytesSync();

    var multipartFile = http.MultipartFile.fromBytes(
      'photo',
      byteData,
      filename: '${DateTime.now().second}.jpg',
      contentType: MediaType("image", "jpg"),
    );
    var onePointOne = double.parse(amount.text);
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(DepositeQueryMutation.deposite),
        variables: <String, dynamic>{
          'amount': onePointOne,
          'reference_number': transaction.text,
          'slip': multipartFile,
        },
      ),
    );

    if (!result.hasException) {
      updatepro(false);

      Get.defaultDialog(
          middleText: "Successfully deposited",
          backgroundColor: CustomColors.blue,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30);

      update();
      selectedImagePath.value = "";
      images.clear();
      amount.clear();
      transaction.clear();

      getDepositeHistory();
    } else {
      updatepro(false);

      Get.defaultDialog(
          middleText: "Not deposited",
          backgroundColor: Colors.red,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30);

      debugPrint(result.exception!.toString());
    }
  }


  @override
  void onClose() {}
  void increment() => count.value++;
}
