import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/providers/add_review_provider.dart';
import '../../global_controller/auth_controller.dart';

class ReportController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final hourid = Get.arguments;
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final reportController = TextEditingController();

  final _happyHourMultiMenuImage = [].obs;
  List get happyHourMultiImages => _happyHourMultiMenuImage;
  set happyHourMultiImages(value) => _happyHourMultiMenuImage.value = value;

  Future uploadMultiMenuImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      happyHourMultiImages = images;
    }
    update();
  }

  Future uploadHappyHourMenuImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (imageFile != null) {
      happyHourMenuImage = imageFile.path;
      happyHourMultiImages.add(imageFile);
    }
  }

  final _happyHourMenuImage = "".obs;
  String get happyHourMenuImage => _happyHourMenuImage.value;
  set happyHourMenuImage(value) => _happyHourMenuImage.value = value;

  void addReportOnHour() {
    if (reportController.text.isNotEmpty) {
      _addReviewProvider.reportHappyHour(
        hourId: Get.arguments,
        userId: Get.find<AuthController>().user.uid,
        reportText: reportController.text,
      );
      reportController.clear();
      Get.back();
    } else {
      Get.find<GlobalGeneralController>()
          .errorSnackbar(title: "Error", description: "Add Report Then Submit");
    }
  }
}
