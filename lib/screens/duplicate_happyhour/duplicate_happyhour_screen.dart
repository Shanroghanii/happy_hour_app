import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_widgets/upload_Image_card.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_happyhour_controller.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_show/duplicate_show_screen.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../global_widgets/main_button.dart';
import '../../../global_widgets/text_field.dart';

class DuplicateBusinessAccountScreen extends GetView<DuplicateController> {
  const DuplicateBusinessAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            )),
        title: const Text("New Business Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: H * 0.009,
              ),
              const Text(
                "Please fill out this form",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: H * 0.02,
              ),
              //topText("Business Information"),
              Row(
                children: [
                  topText("Business Information"),
                  SizedBox(
                    width: W * 0.02,
                  ),
                  Image.asset(
                    "assets/icons/Group 11537.png",
                    height: H * 0.025,
                  ),
                ],
              ),
              SizedBox(
                height: H * 0.02,
              ),
              CustomTextFieldWidget(
                hintText: "Business name",
                textEditingController: controller.businessNameController,
                keyboardType: TextInputType.text,
                validator: controller.businessNameValidator,
              ),

              SizedBox(
                height: H * 0.02,
              ),
              CustomTextFieldWidget(
                onTap: () => controller.onBusinessAddressClick(),
                hintText: "Full Address",
                textEditingController: controller.businessAddressController,
                keyboardType: TextInputType.text,
                validator: controller.businessAddressValidator,
              ),
              SizedBox(
                height: H * 0.02,
              ),
              CustomTextFieldWidget(
                hintText: "Phone number",
                keyboardType: TextInputType.number,
                textEditingController: controller.phonenumberController,
                //validator: controller.validatePhoneNumber,
              ),
              SizedBox(
                height: H * 0.02,
              ),

              topText("Business Card"),
              SizedBox(
                height: H * 0.02,
              ),
              Obx(
                () => controller.businessCard == ""
                    ? UploadImageCard(
                        title:
                            "Upload Business Card or Proof of Ownership/Managemant",
                        onpressed: () {
                          controller.uploadBusinessCard();
                        },
                      )
                    : controller.businessCard != ""
                        ? controller.businessCard
                                .toString()
                                .contains("image_picker")
                            ? GestureDetector(
                                onTap: () => controller.uploadBusinessCard(),
                                child: Image.file(
                                  File(controller.businessCard),
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : GestureDetector(
                                onTap: () => controller.uploadBusinessCard(),
                                child: Image.network(
                                  controller.businessCard,
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ))
                        : controller.businessCard.contains("assets")
                            ? Image.file(
                                File(controller.businessCard),
                                width: W,
                                height: H * 0.2,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.uploadBusinessCard();
                                  },
                                  child: Image.file(
                                    File(controller.businessCard),
                                    width: W * 0.86,
                                    height: H * 0.2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
              ),
              SizedBox(
                height: H * 0.02,
              ),
              topText("Business Logo"),
              SizedBox(
                height: H * 0.02,
              ),
              Obx(
                () => controller.businessLogo == ""
                    ? UploadImageCard(
                        title: "Upload Business Logo",
                        onpressed: () {
                          controller.uploadBusinessLogo();
                        },
                      )
                    : controller.businessLogo != ""
                        ? controller.businessLogo
                                .toString()
                                .contains("image_picker")
                            ? GestureDetector(
                                onTap: () => controller.uploadBusinessLogo(),
                                child: Image.file(
                                  File(controller.businessLogo),
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : GestureDetector(
                                onTap: () => controller.uploadBusinessLogo(),
                                child: Image.network(
                                  controller.businessLogo,
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ))
                        : Center(
                            child: GestureDetector(
                                onTap: () {
                                  controller.uploadBusinessLogo();
                                },
                                child: Image.network(
                                  controller.hour.businessLogo.toString(),
                                  height: H * 0.26,
                                  width: W,
                                )),
                          ),
              ),
              SizedBox(
                height: H * 0.02,
              ),
              topText("Business Image"),
              SizedBox(
                height: H * 0.02,
              ),
              Obx(
                () => controller.businessImage == ""
                    ? UploadImageCard(
                        title: "Upload Business Image",
                        onpressed: () {
                          controller.uploadBusinessImage();
                        },
                      )
                    : controller.businessImage != ""
                        ? controller.businessImage
                                .toString()
                                .contains("image_picker")
                            ? GestureDetector(
                                onTap: () => controller.uploadBusinessImage(),
                                child: Image.file(
                                  File(controller.businessImage),
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : GestureDetector(
                                onTap: () => controller.uploadBusinessImage(),
                                child: Image.network(
                                  controller.businessImage,
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ))
                        : Center(
                            child: GestureDetector(
                              onTap: () {
                                controller.uploadBusinessImage();
                              },
                              child: Image.file(
                                File(controller.businessImage),
                                width: W * 0.86,
                                height: H * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
              ),
              SizedBox(
                height: H * 0.02,
              ),
              topText("Happy Hour Menu"),
              SizedBox(
                height: H * 0.02,
              ),
              Obx(
                () => controller.happyHourMenuImage == ""
                    ? UploadImageCard(
                        title: "Upload Menu Image",
                        onpressed: () {
                          controller.uploadHappyHourMenuImage();
                        },
                      )
                    : controller.happyHourMenuImage != ""
                        ? controller.happyHourMenuImage
                                .toString()
                                .contains("image_picker")
                            ? GestureDetector(
                                onTap: () =>
                                    controller.uploadHappyHourMenuImage(),
                                child: Image.file(
                                  File(controller.happyHourMenuImage),
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : GestureDetector(
                                onTap: () =>
                                    controller.uploadHappyHourMenuImage(),
                                child: Image.network(
                                  controller.happyHourMenuImage,
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ))
                        : Center(
                            child: GestureDetector(
                              onTap: () {
                                controller.uploadHappyHourMenuImage();
                              },
                              child: Image.file(
                                File(controller.happyHourMenuImage),
                                width: W * 0.86,
                                height: H * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
              ),
              // SizedBox(
              //   height: H * 0.02,
              // ),
              // topText("Happy Hour Menu"),
              // SizedBox(
              //   height: H * 0.02,
              // ),
              // Obx(
              //   () => controller.happyHourMenuImage == ""
              //       ? UploadImageCard(
              //           title: "Upload Menu Image",
              //           onpressed: () {
              //             controller.uploadHappyHourMenuImage();
              //           },
              //         )
              //       : Center(
              //           child: GestureDetector(
              //             onTap: () {
              //               controller.uploadHappyHourMenuImage();
              //             },
              //             child: Image.file(
              //               File(controller.happyHourMenuImage),
              //               width: W * 0.86,
              //               height: H * 0.2,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              // ),
              SizedBox(
                height: H * 0.05,
              ),
              SizedBox(
                height: H * 0.09,
                width: W,
                child: CustomElevatedButtonWidget(
                  onPressed: () {
                    Get.to(() => const DuplicateShowScreen());
                  },
                  verticalPadding: 0,
                  text: "Next",
                  textColor: blackColor,
                  fontSize: 24,
                  borderRadius: 45,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Text topText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}
