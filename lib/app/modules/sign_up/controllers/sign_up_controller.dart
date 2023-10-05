import 'package:b2b_ecommerce/app/routes/app_pages.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Services/graphql_conf.dart';
import '../../../../constant/reusable_widget.dart';
import '../data/mutation/signup_mutuation.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignupController

  final GlobalKey<FormState> regFormKey = GlobalKey<FormState>();

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  final reusableWidget = ReusableWidget();
  late TextEditingController nameController,
      phoneController,
      emailController,
      passwordController,
      passwordConfirmController;

  var name = "".obs;
  var phone = "".obs;
  var email = "".obs;
  var password = "".obs;
  var passwordConfirm = "".obs;

  var loading = false.obs;
  var remember = false.obs;

  var errors = <String>[].obs;
  void addError({String? error}) {
    if (!errors.contains(error)) errors.add(error!);
  }

  void removeError({String? error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  void checkReg() {
    final isValid = regFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    regFormKey.currentState!.save();

    signUp();

    print(password);
    print(password);
  }

  void signUp() async {
    openAndCloseLoadingDialog();
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        passwordConfirm.isNotEmpty) {
      GraphQLClient client = graphQLConfiguration.clientToQuery();

      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(SignupQueryMutation.register),
          variables: <String, dynamic>{
            'name': name.value,
            'email': email.value,
            'password': password.value,
            'password_confirmation': passwordConfirm.value,
          },
        ),
      );

      if (!result.hasException) {
        print(result.data!);
        Navigator.of(Get.context!).pop();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'access_token', result.data!["register"]["token"]);

        Get.snackbar("success", "Successfully registered");
        Get.offAllNamed(Routes.SIGN_IN);
      } else {
        Navigator.of(Get.context!).pop();
        Get.snackbar("error", "email or phone number already used",
            backgroundColor: Colors.red, duration: const Duration(seconds: 2));
      }
    }
  }

  Future<void> openAndCloseLoadingDialog() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: CustomColors.blue,
              strokeWidth: 8,
            ),
          ),
        ),
      ),
    );
  }

  final count = 0.obs;
  @override
  void onInit() {
    loading(true);
    super.onInit();

    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }

  void increment() => count.value++;
}
