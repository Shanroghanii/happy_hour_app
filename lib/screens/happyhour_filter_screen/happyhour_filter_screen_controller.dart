import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/filter_model.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/data/providers/add_happyhour_provider.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

class HappyHourFilterScreenController extends GetxController {
  final searchController = TextEditingController();
  final AddHappyHourProvider addHappyHourProvider = AddHappyHourProvider();

  FilterModel filter = FilterModel();
  List<HappyHourModel> searchList = [];
  String days = "Sunday";
  String time = "01:00 PM";
  String distance = "mi";
  String drink = "Drinks";
  String food = "Foods";
  String amenities = "Amenities";
  String events = "Events";
  String barType = "BarType";

  List<String> searchListItem = [];

  var daysList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  var timesList = [
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
    "08:00 PM",
    "09:00 PM",
    "10:00 PM",
    "11:00 PM",
    "12:00 PM",
    "01:00 AM",
    "02:00 AM",
    "03:00 AM",
    "04:00 AM",
    "05:00 AM",
    "06:00 AM",
    "07:00 AM",
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 AM",
  ];

  var distanceList = [
    'Mi',
    'Km',
  ];

  var drinkList = [
    "Domestic",
    "Bottle",
    "Domestic Can",
    "Domestic Draft",
    "Domestic Pitcher",
    "Craft Bottle",
    "Craft Can",
    "Craft Draft",
    "Craft Pitcher",
    "Import Bottle",
    "Import Can",
    "Import Draft",
    "Import Pitcher",
  ];

  var foodsList = [
    " Bone in Wings",
    "Boneless Wings",
    "Pizza",
    "Flat Bread",
    "Burger",
    "Burger- Sliders",
    "Nachos",
    "Nachos Chicken/Steak",
    "Nachos- Ahi",
  ];

  var amenitiesList = [
    " Pool Table",
    "Dart Boards",
    "Juke Box",
    "Arcade",
    "Shuffle Board",
    "Board Games",
  ];
  var eventsList = [
    "Pool Tournament",
    "Free Pool",
    "Dart Tournament",
    "Beer Pong Tournament",
    "Cornhole Tournament",
  ];
  var barList = [
    "Restaurant- Corporate",
    "Restaurant- Owner",
    "Bar- Standard",
    "Bar- Upscale",
    "Bar- Dive",
    "Sports Bar",
    "Brewery",
  ];

//============Fetch Radius List ============//
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();

  final RxList<HappyHourModel> _hoursRadiusList = <HappyHourModel>[].obs;
  List<HappyHourModel> get hoursInRadiusList => _hoursRadiusList;

  fetchHoursinRadius() {
    _addHappyHourProvider
        .fetchHourInradius(
      lat: Get.find<GlobalGeneralController>().lat,
      long: Get.find<GlobalGeneralController>().long,
      rad: range * 2,
    )
        .listen((hours) {
      List<HappyHourModel> _temp = [];
      for (var hour in hours) {
        _temp.add(HappyHourModel.fromDocument(
            hour as DocumentSnapshot<Map<String, dynamic>>,
            hour.id.toString()));
      }
      _hoursRadiusList.value = _temp;
      //  print(_temp.length);
    });
  }

  final Rx<double> _range = 10.0.obs;
  double get range => _range.value;
  set range(value) => _range.value = value;

  void setRange(double slide) {
    range = slide;
    fetchHoursinRadius();
    update();
  }

  Future<void> getAllHoursData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("happyhours").get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print("hfdsfkhdkjhskjhgfdf ghskjlfdhks");
    for (var element in allData) {
      HappyHourModel user = HappyHourModel.fromDoc(Map.from(element as Map));
      hoursModelList.add(user);
    }
  }

  @override
  void onInit() async {
    fetchHoursinRadius();
    await getAllHoursData();
    // print(hoursModelList);
    super.onInit();
  }

  // fetchAllHours() {
  //   hoursModelList = _addHappyHourProvider.happyHourModelDataList;
  // }

  final Rx<List<HappyHourModel>> _hourModelList = Rx<List<HappyHourModel>>([]);
  List<HappyHourModel> get hoursModelList => _hourModelList.value;
  set hoursModelList(value) => _hourModelList.value = value;

  //Filtered list
  final Rx<List<HappyHourModel>> _hourModelListFilter =
      Rx<List<HappyHourModel>>([]);
  List<HappyHourModel> get hoursCityListFilter => _hourModelListFilter.value;
  set hoursCityListFilter(value) => _hourModelListFilter.value = value;

  onSearch(String query) {
    // if (days.isNotEmpty) {
    //   for (var e in hoursModelList) {
    //     if (e.day?[0].containsKey("Hday")) {
    //       if (e.day![0]["Hday"].toString() == days) {
    //         if (time.isNotEmpty) {
    //           for (var e in hoursModelList) {
    //             if (e.day?[0].containsKey("HfromTime")) {
    //               if (e.day?[0]["HfromTime"].toString() == time) {
    //                 hoursCityListFilter = hoursModelList;
    //               }
    //             }
    //           }
    //         }
    //       }
    //     }
    //   }
    // }
    // if (days.isNotEmpty) {
    //   hoursCityListFilter = hoursModelList.where((e) {
    //     return e.day?.first.containsKey("Hday");
    //   }).toList();
    // }
    // if (days.isNotEmpty) {
    //   hoursCityListFilter = hoursModelList.where((e) {
    //     return e.day?.first.containsKey("HfromTime");
    //   }).toList();
    // }
    if (query.isNotEmpty) {
      hoursCityListFilter = hoursModelList.where((element) {
        return element.businessAddress!
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    } else {
      hoursCityListFilter = hoursModelList;
    }
    // print(hoursCityListFilter);
  }
}




//==============*New Search Method *================//

