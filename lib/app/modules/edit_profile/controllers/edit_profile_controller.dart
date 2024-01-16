import 'dart:io';

import 'package:b2b_ecommerce/Services/graphql_conf.dart';
import 'package:b2b_ecommerce/app/modules/edit_profile/data/mutation/getuserid_mutuation.dart';
import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/constant/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../data/model/getuser_model.dart';
import '../data/mutation/updateuser_mutuation.dart';

class EditProfileController extends GetxController {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  final GlobalKey<FormState> editprofilekey2 = GlobalKey<FormState>();
  late TextEditingController name, email, phone, address;
  var loadingUserID = false.obs;
  var loadingImage = false.obs;
  var updatepro = false.obs;
  var getUser = <GestUserModel>[].obs;
  final count = 0.obs;

  bool showPassword = false;
  ImagePicker picker = ImagePicker();

  List<XFile>? imageFileList;
  var profilepic = ''.obs;
  var selectedImagePath = ''.obs;
  set imageFile(XFile? value) {
    imageFileList = value == null ? null : [value];
    loadingImage(true);
  }

  var images = <File>[].obs;
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

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide fullname";
    }
    return null;
  }

  String? validateaddeaa(String value) {
    if (value.isEmpty) {
      return "Please provide Address";
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return "Please provide Phonenumber";
    }
    return null;
  }

  final reusableWidget = ReusableWidget();
  @override
  void onInit() {
    getUserId();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    address = TextEditingController();
    super.onInit();
  }

  void getUserId() async {
    UserIdMutation userIdMutation = UserIdMutation();
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.query(
      QueryOptions(
        document: gql(userIdMutation.getMyUserId()),
      ),
    );

    if (!result.hasException && result.data!["auth"]["retailer"] != null) {
      getUser.add(GestUserModel(
        id: result.data!["auth"]["retailer"] != null
            ? int.parse(result.data!["auth"]["retailer"]["id"])
            : null,
        name: result.data!["auth"]["retailer"]["name"],
        address: result.data!["auth"]["retailer"]["address"],
        city: result.data!["auth"]["retailer"]["city"],
        contact_phone: result.data!["auth"]["retailer"]["contact_phone"],
        contact_email: result.data!["auth"]["retailer"]["contact_email"],
      ));
      loadingUserID(true);
    } else {
      loadingUserID(false);
    }
  }

  bool checka() {
    final isValid = editprofilekey2.currentState!.validate();
    if (!isValid) {
      return false;
    }

    editprofilekey2.currentState!.save();
    updateProfile();
    return true;
  }

  updateProfile() async {
    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(UpdateProfileQueryMutation.updateProfile),
        variables: <String, dynamic>{
          'id': getUser[0].id,
          'name': name.text,
          'address': address.text,
          'city': address.text,
          'contact_name': name.text,
          'contact_phone': phone.text,
        },
      ),
    );

    if (!result.hasException) {
      updatepro(true);
      Get.defaultDialog(
          middleText: "Successfully updated",
          backgroundColor: CustomColors.blue,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30);

      update();
      update();
      selectedImagePath.value = "";
      images.clear();
      name.clear();
      address.clear();
      name.clear();
      phone.clear();
    } else {
      updatepro(false);

      Get.defaultDialog(
          middleText: "Not updated please try again",
          backgroundColor: Colors.red,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30);
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
