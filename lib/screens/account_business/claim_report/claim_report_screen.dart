import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/account_business/claim_report/report_done_screen.dart';

import '../../../core/colors.dart';
import '../../../global_controller/global_general_controller.dart';
import '../../../global_widgets/main_button.dart';

class ClaimReportScreen extends StatelessWidget {
  const ClaimReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportController = TextEditingController();
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
        title: const Text("Send Report"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: H * 0.009,
              ),
              const Text(
                "write your report and send us",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: H * 0.02,
              ),
              SizedBox(
                height: H * 0.2,
                child: CustomTextFieldWidget(
                  textEditingController: reportController,
                  borderRadius: 12,
                  maxLines: 8,
                  hintText: "Write Something",
                  elevation: 0,
                  blurRadius: 2,
                ),
              ),
              SizedBox(
                height: H * 0.05,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30.0),
        child: SizedBox(
          height: H * 0.09,
          width: W,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              if (reportController.text.isNotEmpty) {
                reportController.clear();
                Get.to(() => const ClaimReportDone());
              } else {
                Get.find<GlobalGeneralController>().errorSnackbar(
                    title: "Error", description: "Add Report Then Submit");
              }
            },
            text: "Submit",
            textColor: blackColor,
            fontSize: 24,
            verticalPadding: 0,
            borderRadius: 45,
          ),
        ),
      ),
    );
  }
}
