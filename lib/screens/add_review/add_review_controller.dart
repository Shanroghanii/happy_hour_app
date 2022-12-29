import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

import '../../data/providers/add_review_provider.dart';
import '../../global_controller/global_general_controller.dart';

class AddReviewController extends GetxController {
  final hourid = Get.arguments;
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final reviewController = TextEditingController();

  double star = 3;

  rating(double rating) {
    star = rating;
    // update();
  }

  void addReviewOnHour() {
    if (reviewController.text.isNotEmpty) {
      _addReviewProvider.addReviewOnHappyHour(
          hourId: hourid,
          userId: Get.find<AuthController>().user.uid,
          reviewText: reviewController.text,
          stars: star);
      reviewController.clear();
      star = 0;
      Get.back();
      Get.back();
    } else {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Review", description: "Please Write The Review");
    }
  }
}
