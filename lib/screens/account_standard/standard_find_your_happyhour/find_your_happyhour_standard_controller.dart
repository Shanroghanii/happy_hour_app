import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/providers/add_review_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/happyhour_model.dart';
import '../../../data/providers/add_happyhour_provider.dart';
import '../../../global_controller/global_general_controller.dart';

class FindYourHappyHourStandardController extends GetxController {
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();

  final RxList<HappyHourModel> _hoursList = <HappyHourModel>[].obs;
  List<HappyHourModel> get hoursInRadiusList => _hoursList;
  fetchHours() {
    _addHappyHourProvider
        .fetchHourInradius(
      lat: Get.find<GlobalGeneralController>().lat!,
      long: Get.find<GlobalGeneralController>().long!,
      rad: 20,
    )
        .listen((hours) {
      List<HappyHourModel> _temp = [];
      for (var hour in hours) {
        _temp.add(
          HappyHourModel.fromDocument(
            hour as DocumentSnapshot<Map<String, dynamic>>,
            hour.id.toString(),
          ),
        );
      }
      _hoursList.value = _temp;
      print(_temp.length);
    });
  }

  @override
  void onInit() {
    fetchHours();
    super.onInit();
  }

  void _launchURL(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Error",
        description: 'Could not launch $url',
      );
    }
  }

  int count = 500;

  int? countNew;

  Future<void> viewCount(hourId) async {
    countNew = Random().nextInt(count);

    update();
    await _addReviewProvider.addCountOnHappyHour(
        hourId: hourId, count: countNew!);
  }

  onDirectionTap(uri) {
    _launchURL(Uri.parse(uri));
  }
}
