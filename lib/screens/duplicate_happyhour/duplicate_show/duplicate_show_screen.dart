import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/global_widgets/circular_indicator.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';

import '../../../core/constants.dart';
import '../../../routes/app_routes.dart';
import '../duplicate_happyhour_controller.dart';

class DuplicateShowScreen extends GetView<DuplicateController> {
  const DuplicateShowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomCircleIndicator(
        opacity: 0.5,
        isEnabled: controller.isLoading,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Group 9108.svg",
                    height: 25,
                    width: 25,
                  )),
              // title: const Text(
              //   "Lorem Ipsum Store",
              // ),
              title: Text(controller.hour.businessName.toString()),
              centerTitle: true,
            ),
            extendBodyBehindAppBar: false,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: GetBuilder<DuplicateController>(builder: (_) {
                  return Column(
                    children: [
                      Obx(() => Stack(
                            children: [
                              SizedBox(
                                  height: H * 0.25,
                                  width: W * 1.2,
                                  child: controller.happyHourMenuImage != ""
                                      ? controller.happyHourMenuImage
                                              .contains("image_picker")
                                          ? Image.file(
                                              File(controller
                                                  .happyHourMenuImage),
                                              width: W * 0.95,
                                              height: H * 0.2,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              controller.hour.menuImage
                                                  .toString(),
                                              fit: BoxFit.fitWidth,
                                            )
                                      : Image.network(
                                          controller.happyHourMenuImage,
                                          fit: BoxFit.cover,
                                        )
                                  // : Image.file(
                                  //     File(controller.image),
                                  //     width: W * 0.95,
                                  //     height: H * 0.2,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  ),
                              Positioned(
                                top: 10,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        Routes.duplicateBusinessAccountScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.05,
                                    // width: W * 0.05,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: H * 0.031,
                      ),
                      NewCard(
                        title: controller.businessNameController.text,
                        subtitle:
                            controller.businessAddressController.text == ""
                                ? controller.hour.businessAddress.toString()
                                : controller.businessAddressController.text,
                        image: "assets/icons/Group 11550.png",
                        timeIcon: "assets/icons/Group 11609@2x.png",
                        time:
                            controller.hour.countList?.length.toString() ?? "",
                        rating: Container(),
                        rateCount: "",
                      ),
                      SizedBox(height: H * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        Routes.duplicateDescriptionScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Text(
                              controller.descriptionController.text == ""
                                  ? controller.hour.description.toString()
                                  : controller.descriptionController.text,
                              textAlign: TextAlign.left,
                              // overflow: TextOverflow.ellipsis,
                              //softWrap: false,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Business Hour",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        Routes.duplicateBusinessHourScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                //  mainAxisExtent: 1,
                                childAspectRatio: 32 / 2,
                                crossAxisCount: 1,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.selecteddays.isEmpty
                                  ? controller.hour.fromTimeToTime?.length
                                  : controller.selecteddays.length,
                              itemBuilder: (context, index) {
                                return controller.selecteddays.isEmpty
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                                "•  ${controller.hour.fromTimeToTime?[index]['bDay']}"),
                                          ),
                                          Text(
                                              "    ${controller.hour.fromTimeToTime?[index]['bFtime']} -"
                                              "    ${controller.hour.fromTimeToTime?[index]['bTtime']}"),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                                "•  ${controller.selecteddays[index]['bDay']}"),
                                          ),
                                          Text(
                                              "    ${controller.selecteddays[index]['bFtime']} -"
                                              "    ${controller.selecteddays[index]['bTtime']}"),
                                        ],
                                      );
                              },
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Happy Hour Times",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.duplicateDayTimeScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "Early Happy Hour time",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                //  mainAxisExtent: 1,
                                childAspectRatio: 32 / 2,
                                crossAxisCount: 1,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.hDayTimeList.isEmpty
                                  ? controller.hour.day?.length
                                  : controller.hDayTimeList.length,
                              itemBuilder: (context, index) {
                                return controller.hDayTimeList.isEmpty
                                    ? Row(
                                        children: [
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                                "•  ${controller.hour.day?[index]['Hday']}"),
                                          ),
                                          Text(
                                              "    ${controller.hour.day?[index]['HfromTime']} -"
                                              "    ${controller.hour.day?[index]['HtoTime']}"),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                                "•  ${controller.hDayTimeList[index]['Hday']}"),
                                          ),
                                          Text(
                                              "    ${controller.hDayTimeList[index]['HfromTime']} -"
                                              "    ${controller.hDayTimeList[index]['HtoTime']}"),
                                        ],
                                      );
                              },
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            controller.hour.dayLate!.isNotEmpty
                                ? const Text(
                                    "Late Happy Hour time",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            controller.hour.dayLate!.isNotEmpty
                                ? GridView.builder(
                                    physics: const ScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 30 / 2,
                                      crossAxisCount: 1,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: controller
                                            .hDayTimeLateList.isEmpty
                                        ? controller.hour.dayLate?.length
                                        : controller.hDayTimeLateList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          controller.hDayTimeLateList.isEmpty
                                              ? Row(
                                                  children: [
                                                    SizedBox(
                                                      width: W * 0.25,
                                                      child: Text(
                                                          "•  ${controller.hour.dayLate?[index]['Hday2'].toString()}"),
                                                    ),
                                                    Text(
                                                        "    ${controller.hour.dayLate?[index]['HfromTime2'].toString()} -"
                                                        "    ${controller.hour.dayLate?[index]['HtoTime2'].toString()}"),
                                                  ],
                                                )
                                              : controller.hDayTimeLateList
                                                      .isNotEmpty
                                                  ? Row(
                                                      children: [
                                                        SizedBox(
                                                          width: W * 0.25,
                                                          child: Text(
                                                              "•  ${controller.hDayTimeLateList[index]['Hday2']}"),
                                                        ),
                                                        Text(
                                                            "    ${controller.hDayTimeLateList[index]['HfromTime2']} -"
                                                            "    ${controller.hDayTimeLateList[index]['HtoTime2']}"),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                        ],
                                      );
                                    },
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Food Items",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.duplicateFoodItemScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Quantity",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(""),
                                ]),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                //  mainAxisExtent: 1,
                                childAspectRatio: 24 / 2,
                                crossAxisCount: 1,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.foodList.isEmpty
                                  ? controller.hour.foodName?.length
                                  : controller.foodList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: W * 0.4,
                                      child: Text(controller.foodList.isEmpty
                                          ? "•  ${controller.hour.foodName?[index]['foodname']}"
                                          : "•  ${controller.foodList[index].name}"),
                                    ),
                                    SizedBox(
                                      width: W * 0.24,
                                      child: Text(controller.foodList.isEmpty
                                          ? "•  ${controller.hour.foodName?[index]['foodcount']}"
                                          : "•  ${controller.foodList[index].quantity}"),
                                    ),
                                    SizedBox(
                                      width: W * 0.2,
                                      child: Text(controller.foodList.isEmpty
                                          ? "•  ${controller.hour.foodName?[index]['foodprice']}"
                                          : "•  ${controller.foodList[index].price}"),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Drink Items",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.duplicateDrinksScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Size",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(""),
                                ]),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 24 / 2,
                                crossAxisCount: 1,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.localdrinkList.isEmpty
                                  ? controller.hour.drinkitemName?.length
                                  : controller.localdrinkList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: W * 0.4,
                                      child: Text(controller
                                              .localdrinkList.isEmpty
                                          ? "•  ${controller.hour.drinkitemName?[index]['drinkname']}"
                                          : "•  ${controller.localdrinkList[index].name}"),
                                    ),
                                    SizedBox(
                                      width: W * 0.24,
                                      child: Text(controller
                                              .localdrinkList.isEmpty
                                          ? "•  ${controller.hour.drinkitemName?[index]['drinksize']}"
                                          : "•  ${controller.localdrinkList[index].size}"),
                                    ),
                                    SizedBox(
                                      width: W * 0.2,
                                      child: Text(controller
                                              .localdrinkList.isEmpty
                                          ? "•  ${controller.hour.drinkitemName?[index]['drinkprice']}"
                                          : "•  ${controller.localdrinkList[index].price.toString()}"),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Daily Special",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        Routes.duplicateDailySpecialScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Day",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Size/Quantity",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 24 / 2,
                                crossAxisCount: 1,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.alldailySpecialList.isEmpty
                                  ? controller.hour.dailySpecils?.length
                                  : controller.alldailySpecialList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: W * 0.2,
                                      child: Text(controller
                                              .alldailySpecialList.isEmpty
                                          ? "  •${controller.hour.dailySpecils?[index]['day']}"
                                          : "   •${controller.alldailySpecialList[index]['day']}"),
                                    ),
                                    SizedBox(
                                      width: W * 0.3,
                                      child: Text(controller
                                              .alldailySpecialList.isEmpty
                                          ? "•  ${controller.hour.dailySpecils?[index]['name']}"
                                          : "•  ${controller.alldailySpecialList[index]['name']}"),
                                    ),
                                    SizedBox(
                                      width: W * 0.24,
                                      child: Text(controller
                                              .alldailySpecialList.isEmpty
                                          ? "•  ${controller.hour.dailySpecils?[index]['price']}"
                                          : "•  ${controller.alldailySpecialList[index]['price']}"),
                                    ),
                                    SizedBox(
                                      width: W * 0.1,
                                      child: Text(controller
                                              .alldailySpecialList.isEmpty
                                          ? "•  ${controller.hour.dailySpecils?[index]['quantity']}"
                                          : "•  ${controller.alldailySpecialList[index]['quantity']}"),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Amenities",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.duplicateAmenitiesScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                //  mainAxisExtent: 1,
                                childAspectRatio: 16 / 2,
                                crossAxisCount: 2,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.amentyAddList.isEmpty
                                  ? controller.hour.amenities?.length
                                  : controller.amentyAddList.length,
                              itemBuilder: (context, index) {
                                return Text(controller.amentyAddList.isEmpty
                                    ? "•  ${controller.hour.amenities?[index]}"
                                    : "•  ${controller.amentyAddList[index]}");
                              },
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Bar Type",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.duplicateBarTypeScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                //  mainAxisExtent: 1,
                                childAspectRatio: 16 / 2,
                                crossAxisCount: 2,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.barTypeAddList.isEmpty
                                  ? controller.hour.barType?.length
                                  : controller.barTypeAddList.length,
                              itemBuilder: (context, index) {
                                return Text(controller.barTypeAddList.isEmpty
                                    ? "•  ${controller.hour.barType?[index]}"
                                    : "•  ${controller.barTypeAddList[index]}");
                              },
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Events",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.duplicateEventsScreen,
                                        arguments: controller.hour);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Day",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "From",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "To",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                            GridView.builder(
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                //  mainAxisExtent: 1,
                                childAspectRatio: 16 / 2,
                                crossAxisCount: 1,
                              ),
                              shrinkWrap: true,
                              itemCount: controller.selectedEvent.isEmpty
                                  ? controller.hour.event?.length
                                  : controller.selectedEvent.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: W * 0.2,
                                      child: Text(controller
                                              .selectedEvent.isEmpty
                                          ? "•  ${controller.hour.event?[index]['name']}"
                                          : "•  ${controller.selectedEvent[index]['name']}"),
                                    ),
                                    Text(controller.selectedEvent.isEmpty
                                        ? "•  ${controller.hour.event?[index]['day']}"
                                        : "•  ${controller.selectedEvent[index]['day']}"),
                                    Text(controller.selectedEvent.isEmpty
                                        ? "•  ${controller.hour.event?[index]['fromtime']}"
                                        : "•  ${controller.selectedEvent[index]['fromtime']}"),
                                    Text(controller.selectedEvent.isEmpty
                                        ? "•  ${controller.hour.event?[index]['totime']}"
                                        : "•  ${controller.selectedEvent[index]['totime']}"),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: H * 0.01,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: H * 0.09,
                        width: W,
                        child: CustomElevatedButtonWidget(
                          onPressed: () {
                            // controller.updateBusinessHourToFireStore();
                            //Get.back();
                            controller.duplicateHappyHour();
                          },
                          text: "Done",
                          textColor: blackColor,
                          fontSize: 24,
                          verticalPadding: 0,
                          borderRadius: 45,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
