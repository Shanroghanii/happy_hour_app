import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/providers/add_happyhour_provider.dart';
import 'package:happy_hour_app/data/providers/add_review_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/happyhour_model.dart';
import '../../../global_controller/global_general_controller.dart';

class BusinessFindYourHappyHourScreenController extends GetxController {
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();
  void _launchURL(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Error",
        description: 'Could not Find Location $url',
      );
    }
  }

  onehourAhead() {
    // hoursInRadiusList.sort(
    //   (a, b) => a.day?[index]['Hday'].compare(b.day?[index]['Hday']),
    // );

    for (var e in hoursInRadiusList) {
      e.day?[0]['HfromTime'].split(' ')[0];
      //print(e.day?[0]['HfromTime'].split(' ')[0]);
    }

    // var date = DateTime.parse("2202-11-01 " +
    //     hoursInRadiusList[index].day?[0]['HfromTime'].split(' ')[0]);
    // print(date);
  }

  final RxList<HappyHourModel> _hoursList = <HappyHourModel>[].obs;
  List<HappyHourModel> get hoursInRadiusList => _hoursList;
  fetchHours() {
    _addHappyHourProvider
        .fetchHourInradius(
      lat: Get.find<GlobalGeneralController>().lat ?? 37.785834,
      long: Get.find<GlobalGeneralController>().long ?? -122.406417,
      // lat: _locationData?.latitude ?? 33.704526937198345,
      // long: _locationData?.longitude ?? 73.07165924459696,
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

  // //Location getting
  // Location location = Location();
  // // * Lat long will be save in it, if user give the permission.
  // LocationData? _locationData;

  @override
  Future<void> onInit() async {
    fetchHours();

    // // * location service

    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;

    // // * check if the location service enabled.
    // _serviceEnabled = await location.serviceEnabled();
    // // * if not then request it.
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }

    // // * check permission granted
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }
    // _locationData = await location.getLocation();

    super.onInit();
  }

  int count = 500;

  int? _count;

  viewCount(hourId) async {
    _count = Random().nextInt(count);

    await _addReviewProvider.addCountOnHappyHour(
        hourId: hourId, count: _count ?? 1);
    update();
  }

  onDirectionTap(uri) {
    _launchURL(Uri.parse(uri));
  }
}
