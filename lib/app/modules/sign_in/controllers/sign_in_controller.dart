import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/constants.dart';
import '../../../routes/app_pages.dart';
import '../data/mutation/signin_mutation.dart';

class SignInController extends GetxController {

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, passwordController;

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  final reusableWidget = ReusableWidget();
  String? email;
  String? password;
  var error = "".obs;
  var signingIn = false.obs;
  var loading = false.obs;
  var remember = false.obs;
  var haserror = false.obs;

  var errors = <String>[].obs;
  void addError({String? error}) {
    if (!errors.contains(error)) errors.add(error!);
  }

  void removeError({String? error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  final count = 0.obs;
  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loading(true);
    super.onInit();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Please Provide valid Email!";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "password must be 6 character minimum";
    }

    return null;
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
    signIn();
  }

  void signIn() async {
    openAndCloseLoadingDialog();
    if (email!.isNotEmpty && password!.isNotEmpty) {
      signingIn(true);
      // print(int.parse(txtAge.text));
      GraphQLClient client = graphQLConfiguration.clientToQuery();

      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(SigninQueryMutation.signin),
          variables: <String, dynamic>{'email': email, 'password': password},
        ),
      );

      if (!result.hasException) {
        final prefs = await SharedPreferences.getInstance();

        // print(result.data!["AccessToken"]);

        await prefs.setString('access_token', result.data!["login"]["token"]);
        Navigator.of(Get.context!).pop();
        Get.offNamed(Routes.MAIN_PAGE);
      } else {
        Navigator.of(Get.context!).pop();
        print(result.exception);
        addError(error: valid);
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
