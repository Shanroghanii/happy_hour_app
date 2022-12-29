import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/screens/started_screen/started_screen_controller.dart';

class StartedScreen extends GetView<StartedScreenController> {
  const StartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.only(top: H * 0.18, right: 16.0, left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/images/Group 11393.svg",
                height: MediaQuery.of(context).size.height / 4,
              ),
            ),
            SizedBox(
              height: H * 0.05,
            ),
            const Text(
              " A Little About",
              style: TextStyle(
                fontSize: 32,
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: H * 0.01,
            ),
            const Text("Happy Hour Tap",
                style: TextStyle(
                  fontSize: 32,
                  color: primary,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(
              height: H * 0.03,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                "Lorem ipsum Dolor sit amet der lorem ipsum dolor sit amit amet der lorem ipsum dolor sit amit",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.2),
            SizedBox(
              height: H * 0.075,
              width: W * 0.6,
              child: CustomWhiteButtonWidget(
                verticalPadding: 0,
                color: whiteColor,
                text: "Get Started",
                borderRadius: 45,
                onPressed: () {
                  controller.onGetStartedTap();
                },
              ),
            )

            // CustomElevatedButtonWidget(
            //     text: "Get Started", onPressed: controller.onGetStartedTap())
          ],
        ),
      ),
    );
  }
}
