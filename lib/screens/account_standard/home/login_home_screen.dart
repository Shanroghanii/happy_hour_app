import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/global_widgets/custom_appbar.dart';
import 'package:happy_hour_app/global_widgets/custom_card.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

import 'widgets/drawer.dart';

class LoginHomeScreen extends StatelessWidget {
  const LoginHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Get.find<GlobalGeneralController>().onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: bgColor,
        drawer: const LoginDrawerWidget(),
        appBar: const CustomAppbar(title: ""),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: H * 0.009,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                "Welcome To",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: H * 0.01,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                "Happy Hour Tap",
                style: TextStyle(
                  fontSize: 32,
                  color: primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                "Explore the app with these options",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            CustomCard(
              onPressed: () {
                Get.toNamed(Routes.standardFindYourHappyHourScreen);
              },
              height: H * 0.1,
              title: "Find Your Happy Hour",
              image: "assets/icons/Group 11398.svg",
            ),
            SizedBox(
              height: H * 0.02,
            ),
            CustomCard(
                onPressed: () {
                  Get.toNamed(Routes.addHappyhourScreen);
                },
                height: H * 0.1,
                title: "Add happy hour",
                image: "assets/icons/Group 11429.svg"),
          ]),
        ),
      ),
    );
  }
}
