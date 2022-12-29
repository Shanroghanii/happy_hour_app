import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/screens/happyhour_map_screen.dart/happyhour_map_screen_controller.dart';

import '../../routes/app_routes.dart';

class HappyHourMapScreen extends GetView<HappyHourMapScreenController> {
  const HappyHourMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                "assets/icons/Group 9108.svg",
                height: 25,
                width: 25,
              ),
            )),
        title: const Text(
          "Happy Hour",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
            ),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.happyHourFilterScreen);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: primary,
                  child: SvgPicture.asset(
                    "assets/icons/Group 4822.svg",
                    height: 25,
                    width: 25,
                  ),
                  // backgroundImage: SvgPicture.asset(""),
                ),
              ),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: GetBuilder<HappyHourMapScreenController>(
        init: HappyHourMapScreenController(),
        builder: (controller) {
          return Stack(children: [
            Obx(
              () => GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: controller.defaultCameraPosition,
                onMapCreated: controller.onMapCreated,
                markers: controller.markers,
              ),
            ),
            // GoogleMap(
            //   padding: const EdgeInsets.all(16),
            //   initialCameraPosition: controller.kGooglePlex,
            //   tiltGesturesEnabled: true,
            //   myLocationEnabled: true,
            //   myLocationButtonEnabled: true,
            //   onMapCreated: (GoogleMapController ctn) {
            //     // ignore: null_argument_to_non_null_type
            //     controller.complete.complete();
            //   },
            // ),

            /* this is Map List View Data
            Positioned(
              top: H * 0.12,
              right: 26,
              child: GestureDetector(
                child: Chip(
                  padding: const EdgeInsets.all(12),
                  avatar: Image.asset(
                    "assets/icons/Group 11516.png",
                  ),
                  label: const Text("List View"),
                  backgroundColor: whiteColor,
                  elevation: 5,
                ),
                onTap: () {
                  Get.toNamed(Routes.happyHourSearchResultScreen,
                      arguments: [""]);
                },
              ),
            ), */
          ]);
        },
      ),
    );
  }
}
