// ignore_for_file: prefer_typing_uninitialized_variables, unrelated_type_equality_checks

import 'dart:io';

import 'package:b2b_ecommerce/config/theme/custom_colors.dart';
import 'package:b2b_ecommerce/config/theme/custom_sizes.dart';
import 'package:b2b_ecommerce/helper/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/utils/pages_util.dart';
import '../../../common/widgets/custom_button_feedback.dart';
import '../../../common/widgets/custom_normal_button.dart';
import '../controllers/wallet_controller.dart';

class TopUpPage extends GetView<WalletController> {
  const TopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          'Top Up',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.depositeform,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildComposer(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      constraints:
                          const BoxConstraints(minHeight: 80, maxHeight: 160),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 0),
                        child: TextFormField(
                          controller: controller.transaction,
                          maxLines: null,
                          onChanged: (String txt) {},
                          style: const TextStyle(
                            fontSize: 16,
                            color: CustomColors.blue,
                          ),
                          cursorColor: CustomColors.blue,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  'Enter your transaction reference number'),
                          validator: (value) {
                            return controller.validateName(value!);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      constraints:
                          const BoxConstraints(minHeight: 80, maxHeight: 160),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 0),
                        child: TextFormField(
                          controller: controller.amount,
                          maxLines: null,
                          onChanged: (String txt) {},
                          style: const TextStyle(
                            fontSize: 16,
                            color: CustomColors.blue,
                          ),
                          cursorColor: CustomColors.blue,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter the amount'),
                          validator: (value) {
                            return controller.validatamount(value!);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                ///Submit Button BUTTON
                buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IntrinsicWidth buildSubmitButton(BuildContext context) {
    return IntrinsicWidth(
        child: Obx(
      () => controller.updatepro.value != false
          ? const Center(
              child: CircularProgressIndicator(color: CustomColors.blue),
            )
          : CustomNormalButton(
              text: "Sumbit",
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CustomColors.white,
                    fontWeight: FontWeight.w600,
                  ),
              padding: EdgeInsets.symmetric(
                horizontal: CustomSizes.mp_w_12,
                vertical: CustomSizes.mp_v_4 * 0.7,
              ),
              onPressed: () {
                KeyboardUtil.hideKeyboard(context);

                final isValid =
                    controller.depositeform.currentState!.validate();
                if (!isValid) {
                  return;
                }

                controller.depositeform.currentState!.save();

                controller.deposite();
              },
            ),
    ));
  }

  Widget _buildComposer(BuildContext context) {
    return Obx(() => controller.loadingnew.value != true
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showPicker(context);
                    },
                    child: controller.selectedImagePath != ""
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.file(
                                File(controller.selectedImagePath.value),
                                width: 200,
                                height: 205,
                                fit: BoxFit.contain),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 200,
                            height: 220,
                            child: Icon(
                              Icons.file_upload_sharp,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showPicker(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Upload your bank slip",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: CustomColors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    iconColor: CustomColors.blue,
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
                      // _showAlertDialog(context);
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  iconColor: CustomColors.blue,
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
}
