import 'dart:io';

import 'package:b2b_ecommerce/app/common/widgets/custom_button_feedback.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/config/utils/pages_util.dart';
import 'package:b2b_ecommerce/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/theme/custom_colors.dart';
import '../../../../constant/cache_image_network.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: PagesUtil.getAppBarLightStyle(),
          leading: Padding(
            padding: EdgeInsets.all(CustomSizes.mp_w_2),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(CustomSizes.radius_6),
              child: CustomButtonFeedBack(
                onTap: () {
                  Get.back();
                  KeyboardUtil.hideKeyboard(context);
                },
                child: Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: CustomColors.blue,
                  size: CustomSizes.icon_size_4,
                ),
              ),
            ),
          ),
          title: Text(
            'Edit Detail',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: controller.editprofilekey2,
          autovalidateMode: AutovalidateMode.disabled,
          child: Obx(() => controller.loadingUserID.isTrue
              ? Container(
                  padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Obx(
                            () => controller.selectedImagePath.value != ''
                                ? Stack(
                                    fit: StackFit.passthrough,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    children: [
                                        CircleAvatar(
                                          backgroundColor: CustomColors.blue,
                                          radius: 20.w,
                                          child: ClipOval(
                                              child: Image.file(
                                            File(
                                              controller
                                                  .selectedImagePath.value,
                                            ),
                                            width: 300,
                                          )),
                                        ),
                                        Positioned(
                                          left: 20.w,
                                          top: 30.w,
                                          child: MaterialButton(
                                            color: Colors.white,
                                            shape: const CircleBorder(),
                                            elevation: 2,
                                            child: const Icon(
                                              Icons.edit,
                                              color: CustomColors.blue,
                                            ),
                                            onPressed: () {
                                              _showPicker(context);
                                            },
                                          ),
                                        )
                                      ])
                                : Stack(
                                    fit: StackFit.passthrough,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: Get.width / 6.5,
                                          child: buildCacheNetworkImage(
                                              url: controller.profilepic.value,
                                              width: 300),
                                        ),
                                        Positioned(
                                          left: 15.w,
                                          top: 20.w,
                                          child: MaterialButton(
                                            color: Colors.white,
                                            shape: const CircleBorder(),
                                            elevation: 2,
                                            child: const Icon(
                                              Icons.edit,
                                              color: CustomColors.blue,
                                            ),
                                            onPressed: () {
                                              _showPicker(context);
                                            },
                                          ),
                                        )
                                      ]),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.8.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.name,
                                      validator: (value) {
                                        return controller.validateName(value!);
                                      },
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: controller.getUser[0].name,
                                        hintStyle: TextStyle(
                                          color: const Color(0xff757A80),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        alignLabelWithHint: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(6.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: CustomColors.blue
                                                .withOpacity(0.4),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(6.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: CustomColors.blue,
                                          ),
                                        ),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.w,
                                          horizontal: 2.7.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.8.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Phone",
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: controller.phone,
                                      validator: (value) {
                                        return controller.validatePhone(value!);
                                      },
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        hintText:
                                            controller.getUser[0].contact_phone,
                                        hintStyle: TextStyle(
                                          color: const Color(0xff757A80),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        alignLabelWithHint: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(6.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: CustomColors.blue
                                                .withOpacity(0.4),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(6.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: CustomColors.blue,
                                          ),
                                        ),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.w,
                                          horizontal: 2.7.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.8.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.address,
                                      validator: (value) {
                                        return controller
                                            .validateaddeaa(value!);
                                      },
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: controller.getUser[0].address,
                                        hintStyle: TextStyle(
                                          color: const Color(0xff757A80),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        alignLabelWithHint: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(6.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: CustomColors.blue
                                                .withOpacity(0.4),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(6.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: CustomColors.blue,
                                          ),
                                        ),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.w,
                                          horizontal: 2.7.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                controller.checka();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: CustomColors.blue,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              child: const Text(
                                "SAVE",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
        ));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: CustomColors.blue,
                    ),
                    title: Text(
                      'Photo Library',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: CustomColors.grey),
                    ),
                    onTap: () {
                      controller.getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                      _showAlertDialog(context);
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: CustomColors.blue,
                  ),
                  title: Text(
                    'Camera',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: CustomColors.grey),
                  ),
                  onTap: () {
                    controller.getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('No',
            style: TextStyle(
              color: CustomColors.blue,
            )));
    Widget continueButton = TextButton(
        onPressed: () {
          //  controller.updateonlyprofilepic();
          Navigator.pop(context);
        },
        child: const Text('Yes',
            style: TextStyle(
              color: CustomColors.blue,
            )));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        'Change Profile Picture ?',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: CustomColors.grey),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
