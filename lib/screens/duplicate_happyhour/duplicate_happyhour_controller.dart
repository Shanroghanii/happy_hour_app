import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/providers/add_happyhour_provider.dart';
import '../../../global_controller/global_general_controller.dart';
import '../../../routes/app_routes.dart';

class DuplicateController extends GetxController {
  final HappyHourModel hour = Get.arguments;
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();
  final manualAddressformKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final businessNameController = TextEditingController();
  final businessAddressController = TextEditingController();
  final descriptionController = TextEditingController();
  final addDrinksManuallyController = TextEditingController();
  final addfoodManuallyController = TextEditingController();
  final phonenumberController = TextEditingController();
  final dailSpecialPrice = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final duplicateBusinessTimeformKey = GlobalKey<FormState>();

  arguments() {
    businessNameController.text = hour.businessName.toString();
    businessAddressController.text = hour.businessAddress.toString();

    descriptionController.text = hour.description.toString();
    businessCard = hour.businessCard;
    businessLogo = hour.businessLogo;
    businessImage = hour.businessImage;
    happyHourMenuImage = hour.menuImage;
    for (var amen in amenitiesList) {
      if (hour.amenities!.contains(amen.amenity)) {
        amen.isSelect.value = true;
        amentyAddList.add(amen.amenity);
      }
    }
    for (var bar in barTypeList) {
      if (hour.barType!.contains(bar.barType)) {
        bar.isSelect.value = true;
        barTypeAddList.add(bar.barType);
      }
      //print(barTypeAddList);
    }
  }

  @override
  void onInit() {
    arguments();
    //business Hour Update
    businessHourUpdate();

    //*=====Happy Hour Time =======*//
    happyHourTimeUpdate();
    happyHourTimeUpdateLate();
    //Food Update
    for (int i = 0; i < hour.foodName!.length; i++) {
      foodUpdate(i);
    }
    //Drink update
    for (int i = 0; i < hour.drinkitemName!.length; i++) {
      drinkUpdate(i);
    }

    //daily special update
    for (int i = 0; i < hour.dailySpecils!.length; i++) {
      dailySpecialUpdate(i);
    }

    //event update
    for (int i = 0; i < hour.event!.length; i++) {
      eventUpdate(i);
    }

    super.onInit();
  }

  businessHourUpdate() {
    for (int i = 0; i < hour.fromTimeToTime!.length; i++) {
      for (var bh in dayFromTimeToTimeList) {
        if (hour.fromTimeToTime?[i]['bDay'].contains(bh.day)) {
          bh.isSelect.value = true;
          bh.from = hour.fromTimeToTime?[i]['bFtime'];
          bh.to = hour.fromTimeToTime?[i]['bTtime'];
          if (bh.day.toString() == "Sunday") {
            bh.key = a;
            bh.key2 = a2;
          }
          if (bh.day.toString() == "Monday") {
            bh.key = b;
            bh.key2 = b2;
          }
          if (bh.day.toString() == "Tuesday") {
            bh.key = c;
            bh.key2 = c2;
          }
          if (bh.day.toString() == "Wednesday") {
            bh.key = d;
            bh.key2 = d2;
          }
          if (bh.day.toString() == "Thursday") {
            bh.key = e;
            bh.key2 = e2;
          }
          if (bh.day.toString() == "Friday") {
            bh.key = f;
            bh.key2 = f2;
          }
          if (bh.day.toString() == "Saturday") {
            bh.key = g;
            bh.key2 = g2;
          }

          selecteddays.add({
            "bDay": bh.day,
            "bFtime": hour.fromTimeToTime?[i]['bFtime'],
            "bTtime": hour.fromTimeToTime?[i]['bTtime'],
          });
        }
      }
    }
  }

  // businessHourUpdate() {
  //   for (int i = 0; i < hour.fromTimeToTime!.length; i++) {
  //     for (var bh in dayFromTimeToTimeList) {
  //       if (hour.fromTimeToTime?[i]['bDay'].contains(bh.day)) {
  //         bh.isSelect.value = true;
  //         selecteddays.add({
  //           "bDay": bh.day,
  //           "bFtime": hour.fromTimeToTime?[i]['bFtime'],
  //           "bTtime": hour.fromTimeToTime?[i]['bTtime'],
  //         });
  //       }
  //     }
  //   }
  // }

  happyHourTimeUpdate() {
    if (hour.day!.isNotEmpty) {
      for (int i = 0; i < hour.day!.length; i++) {
        for (var dt in dayTimeList) {
          if (hour.day![i]['Hday'].contains(dt.day)) {
            dt.isSelect.value = true;

            dt.fromTime = hour.day?[i]['HfromTime'];
            dt.toTime = hour.day?[i]['HtoTime'];
            // dt.fromTime2 = hour.fromTimeToTime?[i]['HfromTime2'];
            // dt.toTime2 = hour.fromTimeToTime?[i]['HtoTime2'];

            if (dt.day.toString() == "Sunday") {
              dt.keyfrom = aa;
              dt.keyto = aa2;
            }
            if (dt.day.toString() == "Monday") {
              dt.keyfrom = bb;
              dt.keyto = bb2;
            }
            if (dt.day.toString() == "Tuesday") {
              dt.keyfrom = cc;
              dt.keyto = cc2;
            }
            if (dt.day.toString() == "Wednesday") {
              dt.keyfrom = dd;
              dt.keyto = dd2;
            }
            if (dt.day.toString() == "Thursday") {
              dt.keyfrom = ee;
              dt.keyto = ee2;
            }
            if (dt.day.toString() == "Friday") {
              dt.keyfrom = ff;
              dt.keyto = ff2;
            }
            if (dt.day.toString() == "Saturday") {
              dt.keyfrom = gg;
              dt.keyto = gg2;
            }
            hDayTimeList.add({
              "Hday": dt.day,
              "HfromTime": hour.day?[i]['HfromTime'],
              "HtoTime": hour.day?[i]['HtoTime']
            });
          }
        }
      }
    }
  }

  happyHourTimeUpdateLate() {
    if (hour.dayLate!.isNotEmpty) {
      for (int i = 0; i < hour.dayLate!.length; i++) {
        for (var dt in dayTimeList2) {
          if (hour.dayLate![i]['Hday2'].contains(dt.day)) {
            dt.isSelect.value = true;

            dt.fromTime2 = hour.dayLate?[i]['HfromTime2'];
            dt.toTime2 = hour.dayLate?[i]['HtoTime2'];
            // dt.fromTime2 = hour.fromTimeToTime?[i]['HfromTime2'];
            // dt.toTime2 = hour.fromTimeToTime?[i]['HtoTime2'];

            if (dt.day.toString() == "Sunday") {
              dt.keyfrom2 = hh;
              dt.keyto2 = hh2;
            }
            if (dt.day.toString() == "Monday") {
              dt.keyfrom2 = ii;
              dt.keyto2 = ii2;
            }
            if (dt.day.toString() == "Tuesday") {
              dt.keyfrom2 = jj;
              dt.keyto2 = jj2;
            }
            if (dt.day.toString() == "Wednesday") {
              dt.keyfrom2 = kk;
              dt.keyto2 = kk2;
            }
            if (dt.day.toString() == "Thursday") {
              dt.keyfrom2 = ll;
              dt.keyto2 = ll2;
            }
            if (dt.day.toString() == "Friday") {
              dt.keyfrom2 = mm;
              dt.keyto2 = mm2;
            }
            if (dt.day.toString() == "Saturday") {
              dt.keyfrom2 = nn;
              dt.keyto2 = nn2;
            }
            hDayTimeLateList.add({
              "Hday2": dt.day,
              "HfromTime2": hour.dayLate?[i]['HfromTime2'],
              "HtoTime2": hour.dayLate?[i]['HtoTime2']
            });
          }
        }
      }
    }
  }

  List hDayTimeLateList = [];
  void addToHdaySecond(int i) {
    hDayTimeLateList.add({
      "Hday2": dayTimeList[i].day,
      "HfromTime2": hFromTime2,
      "HtoTime2": hToTime2,
    });
  }

  void hUpdateDaySecond(index) async {
    dayTimeList[index].isLate.isTrue
        ? bDay = dayTimeList[index].day.toString()
        : hDayTimeLateList
            .removeWhere((e) => e['Hday'] == dayTimeList[index].day);
  }

  void hDayTimeSecond(index) {
    var a = hDayTimeLateList
        .where((e) => e['Hday'].toString() == dayTimeList[index].day)
        .toList();

    if (a.isEmpty) {
      hDayTimeLateList.add({
        "Hday2": dayTimeList[index].day,
        "HfromTime2": dayTimeList[index].fromTime2,
        "HtoTime2": dayTimeList[index].toTime2
      });
    }
  }

  foodUpdate(index) {
    for (var food in foodallList) {
      if (hour.foodName?[index]['foodname'].contains(food.name)) {
        foodList.add(
          LocalFoodModel(
            name: food.name.toString(),
            quantity: hour.foodName?[index]['foodcount'],
            price: hour.foodName?[index]['foodprice'],
            discount: hour.foodName?[index]['fooddiscount'],
            dropDown: ["%", "\$"],
            priceController:
                TextEditingController(text: hour.foodName?[index]['foodprice']),
            earlyFood: true.obs,
            lateFood: true.obs,
            time: foodtime,
          ),
        );
      }
    }
    if (hour.dayLate!.isNotEmpty) {
      showDayList = true;
      showLateDayList = true;
    }
  }

  drinkUpdate(index) {
    for (var drink in drinkList) {
      if (hour.drinkitemName?[index]['drinkname'].contains(drink.name)) {
        localdrinkList.add(
          LocalDrinkModel(
            name: drink.name.toString(),
            size: hour.drinkitemName?[index]['drinksize'],
            price: hour.drinkitemName?[index]['drinkprice'],
            discount: hour.drinkitemName?[index]['drinkdiscount'],
            sizeicon: "",
            discounticon: "",
            dropDown: ["%", "\$"],
            dropDownSize: [
              'oz',
              'ml',
              'Can',
              'Tall Can',
              'Bottle',
              'Pint-Draft',
              'Large Draft',
              'Pitcher',
              'Glass',
              'Shot'
            ],
            discountController: TextEditingController(
                text: hour.drinkitemName?[index]['drinkdiscount'] == 0
                    ? ""
                    : hour.drinkitemName?[index]['drinkdiscount'].toString()),
            drinkController: TextEditingController(
                text: hour.drinkitemName?[index]['drinkprice']),
            bothTimeDrink: false.obs,
            time: drinktime,
            sizeController: TextEditingController(
                text: hour.drinkitemName?[index]['drinksize']),
            earlyDrink: true.obs,
            lateDrink: true.obs,
          ),
        );
      }
    }
  }

//======dailyspecial Update
  dailySpecialUpdate(index) {
    alldailySpecialList.clear();
    for (var ds in daysList) {
      if (hour.dailySpecils?[index]['day'].contains(ds.day)) {
        ds.isSelect.value = true;

        if (hour.dailySpecils?[index]['day'] == "Sunday") {
          sundaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'],
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in sundaydailySpecialItemList) {
            alldailySpecialList.add({
              "name": e['name'],
              "quantity": e['quantity'],
              "price": e["price"],
              "discount": e["discount"],
              "sizeIcon": e["sizeIcon"],
              "day": e['day'],
              "fromTime": e["fromTime"],
              "toTime": e["toTime"],
              "index": e["index"],
            });
          }
        }
        if (hour.dailySpecils?[index]['day'] == "Monday") {
          mondaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in mondaydailySpecialItemList) {
            alldailySpecialList.add({
              "name": e['name'],
              "quantity": e['quantity'],
              "price": e["price"],
              "discount": e["discount"],
              "sizeIcon": e["sizeIcon"],
              "day": e['day'],
              "fromTime": e["fromTime"],
              "toTime": e["toTime"],
              "index": e["index"],
            });
          }
        }
        if (hour.dailySpecils?[index]['day'] == "Tuesday") {
          tuesdaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in tuesdaydailySpecialItemList) {
            alldailySpecialList.add({
              "name": e['name'],
              "quantity": e['quantity'],
              "price": e["price"],
              "discount": e["discount"],
              "sizeIcon": e["sizeIcon"],
              "day": e['day'],
              "fromTime": e["fromTime"],
              "toTime": e["toTime"],
              "index": e["index"],
            });
          }
        }
        if (hour.dailySpecils?[index]['day'] == "Wednesday") {
          wednesdaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in wednesdaydailySpecialItemList) {
            alldailySpecialList.add({
              "name": e['name'],
              "quantity": e['quantity'],
              "price": e["price"],
              "discount": e["discount"],
              "sizeIcon": e["sizeIcon"],
              "day": e['day'],
              "fromTime": e["fromTime"],
              "toTime": e["toTime"],
              "index": e["index"],
            });
          }
        }
        if (hour.dailySpecils?[index]['day'] == "Thursday") {
          thursdaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in thursdaydailySpecialItemList) {
            alldailySpecialList.add({
              "name": e['name'],
              "quantity": e['quantity'],
              "price": e["price"],
              "discount": e["discount"],
              "sizeIcon": e["sizeIcon"],
              "day": e['day'],
              "fromTime": e["fromTime"],
              "toTime": e["toTime"],
              "index": e["index"],
            });
          }
        }
        if (hour.dailySpecils?[index]['day'] == "Friday") {
          fridaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in fridaydailySpecialItemList) {
            alldailySpecialList.add({
              "name": e['name'],
              "quantity": e['quantity'],
              "price": e["price"],
              "discount": e["discount"],
              "sizeIcon": e["sizeIcon"],
              "day": e['day'],
              "fromTime": e["fromTime"],
              "toTime": e["toTime"],
              "index": e["index"],
            });
          }
        }
        if (hour.dailySpecils?[index]['day'] == "Saturday") {
          saturdaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in saturdaydailySpecialItemList) {
            alldailySpecialList.add({
              "name": e['name'],
              "quantity": e['quantity'],
              "price": e["price"],
              "discount": e["discount"],
              "sizeIcon": e["sizeIcon"],
              "day": e['day'],
              "fromTime": e["fromTime"],
              "toTime": e["toTime"],
              "index": e["index"],
            });
          }
        }
        // alldailySpecialList.addAll(sundaydailySpecialItemList);
        // alldailySpecialList.addAll(mondaydailySpecialItemList);
        // alldailySpecialList.addAll(tuesdaydailySpecialItemList);
        // alldailySpecialList.addAll(wednesdaydailySpecialItemList);
        // alldailySpecialList.addAll(thursdaydailySpecialItemList);
        // alldailySpecialList.addAll(fridaydailySpecialItemList);
        // alldailySpecialList.addAll(saturdaydailySpecialItemList);

      }
    }
  }

  addtoEditdailypecial() {
    List alldailySpecial = [];
    for (var e in sundaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in mondaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in tuesdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in wednesdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in thursdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in fridaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in saturdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    alldailySpecialList.addAll(alldailySpecial);
  }

  void dailySpecialDoneTap() {
    var index = daysList.where((e) => e.isSelect.isTrue).length;

    bool isSunday = true;
    bool isMonday = true;
    bool isTuesday = true;
    bool isWednesday = true;
    bool isThursday = true;
    bool isFriday = true;
    bool isSaturday = true;
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Sunday") {
        isSunday = false;
        if (sundaydailySpecialItemList.isNotEmpty) {
          isSunday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Monday") {
        isMonday = false;
        if (mondaydailySpecialItemList.isNotEmpty) {
          isMonday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Tuesday") {
        isTuesday = false;
        if (tuesdaydailySpecialItemList.isNotEmpty) {
          isTuesday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Wednesday") {
        isWednesday = false;
        if (wednesdaydailySpecialItemList.isNotEmpty) {
          isWednesday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Thursday") {
        isThursday = false;
        if (thursdaydailySpecialItemList.isNotEmpty) {
          isThursday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Friday") {
        isFriday = false;
        if (fridaydailySpecialItemList.isNotEmpty) {
          isFriday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Saturday") {
        isSaturday = false;
        if (saturdaydailySpecialItemList.isNotEmpty) {
          isSaturday = true;
        }
      }
    }

    if (!dailySpecialKey.currentState!.validate()) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Error", description: "Fill All The Required Fields");
    } else if (index == 0) {
      Get.back();
    } else if (isSunday == false ||
        isMonday == false ||
        isTuesday == false ||
        isWednesday == false ||
        isThursday == false ||
        isFriday == false ||
        isSaturday == false) {
      Get.find<GlobalGeneralController>()
          .errorSnackbar(title: "Error", description: "Add Items against Day");
    } else if (dailySpecialKey.currentState!.validate()) {
      if (isSunday &&
          isMonday &&
          isTuesday &&
          isWednesday &&
          isThursday &&
          isFriday &&
          isSaturday) {
        Get.back();
      }

      addToDailyySpecial();
    }
    update();
  }

//*=========event Update ====//
  eventUpdate(index) {
    for (var e in eventList) {
      if (hour.event?[index]['name'].contains(e.event)) {
        e.isSelect.value = true;
        selectedEvent.add({
          "name": e.event,
          "day": hour.event?[index]['day'],
          "fromtime": hour.event?[index]['fromtime'],
          "totime": hour.event?[index]['totime']
        });
      }
    }
  }
//*=====observable variables=========*//

  final _busniessCard = "".obs;
  String get businessCard => _busniessCard.value;
  set businessCard(value) => _busniessCard.value = value;

  final _busniessLogo = "".obs;
  String get businessLogo => _busniessLogo.value;
  set businessLogo(value) => _busniessLogo.value = value;

  final _busniessImage = "".obs;
  String get businessImage => _busniessImage.value;
  set businessImage(value) => _busniessImage.value = value;

  final _happyHourMenuImage = "".obs;
  String get happyHourMenuImage => _happyHourMenuImage.value;
  set happyHourMenuImage(value) => _happyHourMenuImage.value = value;

  final _isFood = true.obs;
  bool get isFood => _isFood.value;
  set isFood(value) => _isFood.value = value;

//Location
  late GoogleMapController googleMapController;
  double? latitude;
  double? longitude;
  void latLong(point) {
    (() {
      googleMapController.getLatLng(
        ScreenCoordinate(
          x: point.latitude.toInt(),
          y: point.longitude.toInt(),
        ),
      );
    });
    latitude = point.latitude;
    longitude = point.longitude;
  }

  //Google Places
  double _lat = 0.0;
  double _long = 0.0;
  final _isAddressRemoved = false.obs;
  bool get isAddressRemoved => _isAddressRemoved.value;
  final _address = "".obs;
  String get address => _address.value;

  onBusinessNameClick() async {
    Get.to(
      () => PlacePicker(
        apiKey: "AIzaSyDPOY1Q8Y3hi8_mQwYBztfj4pLYQl3-J0o",
        onPlacePicked: (PickResult result) {
          if (result.formattedAddress != null) {
            _lat = result.geometry!.location.lat;
            _long = result.geometry!.location.lng;
            _isAddressRemoved.value = false;

            businessNameController.text = result.name!;
            businessAddressController.text = result.formattedAddress!;
            Get.back();
          }
        },
        initialPosition: LatLng(
            latitude ?? 37.42796133580664, longitude ?? -122.085749655962),
        useCurrentLocation: true,
      ),
    );
  }

  onBusinessAddressClick() async {
    Get.to(
      () => PlacePicker(
        apiKey: "AIzaSyDPOY1Q8Y3hi8_mQwYBztfj4pLYQl3-J0o",
        onPlacePicked: (PickResult result) {
          if (result.formattedAddress != null) {
            _lat = result.geometry!.location.lat;
            _long = result.geometry!.location.lng;
            _isAddressRemoved.value = false;

            businessAddressController.text = result.formattedAddress!;
            Get.back();
          }
        },
        initialPosition: LatLng(
            latitude ?? 33.704526937198345, longitude ?? 73.07165924459696),
        useCurrentLocation: true,
      ),
    );
  }

  // onAddressClick() async {
  //   Get.to(
  //     () => PlacePicker(
  //       apiKey: "AIzaSyDPOY1Q8Y3hi8_mQwYBztfj4pLYQl3-J0o",
  //       onPlacePicked: (PickResult result) {
  //         if (result.formattedAddress != null) {
  //           _lat = result.geometry!.location.lat;
  //           _long = result.geometry!.location.lng;
  //           businessAddressController.text = result.formattedAddress!;
  //           Get.back();
  //         }
  //       },
  //       initialPosition: const LatLng(33.704526937198345, 73.07165924459696),
  //       useCurrentLocation: true,
  //     ),
  //   );
  // }

  Future uploadBusinessCard() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      businessCard = imageFile.path;
    }
  }

  Future uploadBusinessLogo() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      businessLogo = imageFile.path;
    }
  }

  Future uploadBusinessImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      businessImage = imageFile.path;
    }
  }

  Future uploadHappyHourMenuImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      happyHourMenuImage = imageFile.path;
    }
  }

  String? businessNameValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Name is required';
    }
    if (value.trim().length < 4) {
      return 'name must be at least 4 characters in length';
    }
    // Return null if the entered Business name is valid
    return null;
  }

// Phone number Validator
  // String? validatePhoneNumber(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Phone Number is Required';
  //   } else if (value.length != 11 && !GetUtils.isPhoneNumber(value)) {
  //     return "Invalid Phone Number";
  //   }
  //   return null;
  // }

  //Business Address textfeild validator
  String? businessAddressValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Address is required';
    }
    if (value.trim().length < 4) {
      return 'address must be at least 4 characters in length';
    }
    // Return null if the entered Business Address is valid
    return null;
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  String? nameValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Name is required';
    }
    if (value.trim().length < 4) {
      return 'Username must be at least 4 characters in length';
    }
    // Return null if the entered Business name is valid
    return null;
  }

  // Address textfeild validator
  String? addressValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Address is required';
    }
    if (value.trim().length < 4) {
      return 'Username must be at least 4 characters in length';
    }
    // Return null if the entered Business Address is valid
    return null;
  }

  final _isTermChecked = false.obs;
  bool get isTermChecked => _isTermChecked.value;
  set isTermChecked(value) => _isTermChecked.value = value;

  onCheckboxChange(bool? value) {
    isTermChecked = !isTermChecked;
  }

  String eventtime = "01:00 PM";
  String dailySpecialtime = "01:00 PM";
  String time = "01:00 PM";

  String selectedday = "";

  final timesList = [
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
    "12:00 AM",
    "12:30 AM",
    "Select Time",
  ];

  String day = "Sunday";
  final dayList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  List selecteddays = [];
  List<SelectDayTime> dayFromTimeToTimeList = [
    SelectDayTime(
      isSelect: false.obs,
      day: "Sunday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Monday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Thursday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Friday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Saturday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
  ];
  List<LateDayTime> dayTimeList = [
    LateDayTime(
      isSelect: false.obs,
      day: "Sunday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Monday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Thursday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Friday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Saturday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
  ];

  List<LateDayTime> dayTimeList2 = [
    LateDayTime(
      isSelect: false.obs,
      day: "Sunday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Monday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Thursday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Friday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Saturday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
  ];
  void hUpdateDayLate(index) async {
    dayTimeList2[index].isSelect.value = !dayTimeList2[index].isSelect.value;
    for (var day in dayTimeList2) {
      if (day.isSelect.isTrue) {
        // hDay = day.day.toString();
        hDay = dayTimeList2[index].day;
        update();
      }
      hDayTimeLateList
          .removeWhere((e) => e['Hday2'] == dayTimeList2[index].day);
    }
  }

  forKeyAssignDayTimeLate(index) {
    if (dayTimeList2[index].isSelect.isFalse) {
      dayTimeList2[index].keyfrom2?.currentState?.reset();
      dayTimeList2[index].keyto2?.currentState?.reset();
      dayTimeList2[index].fromTime2 = "";
      dayTimeList2[index].toTime2 = "";
    } else {
      if (index == 0) {
        dayTimeList2[0].keyfrom = hh;
        dayTimeList2[0].keyto = hh2;
      }
      if (index == 1) {
        dayTimeList2[1].keyfrom = ii;
        dayTimeList2[1].keyto = ii2;
      }
      if (index == 2) {
        dayTimeList2[2].keyfrom = jj;
        dayTimeList2[2].keyto = jj2;
      }
      if (index == 3) {
        dayTimeList2[3].keyfrom = kk;
        dayTimeList2[3].keyto = kk2;
      }
      if (index == 4) {
        dayTimeList2[4].keyfrom = ll;
        dayTimeList2[4].keyto = ll2;
      }
      if (index == 5) {
        dayTimeList2[5].keyfrom = mm;
        dayTimeList2[5].keyto = mm2;
      }
      if (index == 6) {
        dayTimeList2[6].keyfrom = nn;
        dayTimeList2[6].keyto = nn2;
      }
    }
  }

  void hDayTimeLate(index) {
    !hDayTimeList.contains("Hday2");
    hDayTimeLateList.add({
      "Hday2": dayTimeList2[index].day,
      "HfromTime2": dayTimeList2[index].fromTime2,
      "HtoTime2": dayTimeList2[index].toTime2,
    });
  }

  final aa = GlobalKey<FormState>();
  final bb = GlobalKey<FormState>();
  final cc = GlobalKey<FormState>();
  final dd = GlobalKey<FormState>();
  final ee = GlobalKey<FormState>();
  final ff = GlobalKey<FormState>();
  final gg = GlobalKey<FormState>();
  //Daytime from Late Keys
  final hh = GlobalKey<FormState>();
  final ii = GlobalKey<FormState>();
  final jj = GlobalKey<FormState>();
  final kk = GlobalKey<FormState>();
  final ll = GlobalKey<FormState>();
  final mm = GlobalKey<FormState>();
  final nn = GlobalKey<FormState>();
//Daytime To Early Keys to
  final aa2 = GlobalKey<FormState>();
  final bb2 = GlobalKey<FormState>();
  final cc2 = GlobalKey<FormState>();
  final dd2 = GlobalKey<FormState>();
  final ee2 = GlobalKey<FormState>();
  final ff2 = GlobalKey<FormState>();
  final gg2 = GlobalKey<FormState>();
  //Daytime To Late Keys to
  final hh2 = GlobalKey<FormState>();
  final ii2 = GlobalKey<FormState>();
  final jj2 = GlobalKey<FormState>();
  final kk2 = GlobalKey<FormState>();
  final ll2 = GlobalKey<FormState>();
  final mm2 = GlobalKey<FormState>();
  final nn2 = GlobalKey<FormState>();

  forKeyAssignDayTime(index) {
    if (dayTimeList[index].isSelect.isFalse) {
      dayTimeList[index].keyfrom?.currentState?.reset();
      dayTimeList[index].keyto?.currentState?.reset();
      dayTimeList[index].fromTime = "";
      dayTimeList[index].toTime = "";
    } else {
      if (index == 0) {
        dayTimeList[0].keyfrom = aa;
        dayTimeList[0].keyto = aa2;
      }
      if (index == 1) {
        dayTimeList[1].keyfrom = bb;
        dayTimeList[1].keyto = bb2;
      }
      if (index == 2) {
        dayTimeList[2].keyfrom = cc;
        dayTimeList[2].keyto = cc2;
      }
      if (index == 3) {
        dayTimeList[3].keyfrom = dd;
        dayTimeList[3].keyto = dd2;
      }
      if (index == 4) {
        dayTimeList[4].keyfrom = ee;
        dayTimeList[4].keyto = ee2;
      }
      if (index == 5) {
        dayTimeList[5].keyfrom = ff;
        dayTimeList[5].keyto = ff2;
      }
      if (index == 6) {
        dayTimeList[6].keyfrom = gg;
        dayTimeList[6].keyto = gg2;
      }
    }
  }

//*Business Hour and Days *//
  final hourBformKey = GlobalKey<FormState>();
  String? bDay;
  String? bFromtime;
  String? bTotime;
  void bUpdateDay(index) async {
    dayFromTimeToTimeList[index].isSelect.value =
        !dayFromTimeToTimeList[index].isSelect.value;
    for (var days in dayFromTimeToTimeList) {
      if (days.isSelect.isTrue) {
        // dayFromTimeToTimeList[index].day = days.day;
        bDay = dayFromTimeToTimeList[index].day;
        update();
      }
    }
    selecteddays
        .removeWhere((e) => e['bDay'] == dayFromTimeToTimeList[index].day);
  }

  final a = GlobalKey<FormState>();
  final b = GlobalKey<FormState>();
  final c = GlobalKey<FormState>();
  final d = GlobalKey<FormState>();
  final e = GlobalKey<FormState>();
  final f = GlobalKey<FormState>();
  final g = GlobalKey<FormState>();
  final a2 = GlobalKey<FormState>();
  final b2 = GlobalKey<FormState>();
  final c2 = GlobalKey<FormState>();
  final d2 = GlobalKey<FormState>();
  final e2 = GlobalKey<FormState>();
  final f2 = GlobalKey<FormState>();
  final g2 = GlobalKey<FormState>();
  forKeyAssign(index) {
    if (dayFromTimeToTimeList[index].isSelect.isFalse) {
      dayFromTimeToTimeList[index].key?.currentState?.reset();
      dayFromTimeToTimeList[index].key2?.currentState?.reset();
      dayFromTimeToTimeList[index].from = "";
      dayFromTimeToTimeList[index].to = "";
      //hourBformKey.currentState?.reset();
    } else {
      if (index == 0) {
        dayFromTimeToTimeList[0].key = a;
        dayFromTimeToTimeList[0].key2 = a2;
      }
      if (index == 1) {
        dayFromTimeToTimeList[1].key = b;
        dayFromTimeToTimeList[1].key2 = b2;
      }
      if (index == 2) {
        dayFromTimeToTimeList[2].key = c;
        dayFromTimeToTimeList[2].key2 = c2;
      }
      if (index == 3) {
        dayFromTimeToTimeList[3].key = d;
        dayFromTimeToTimeList[3].key2 = d2;
      }
      if (index == 4) {
        dayFromTimeToTimeList[4].key = e;
        dayFromTimeToTimeList[4].key2 = e2;
      }
      if (index == 5) {
        dayFromTimeToTimeList[5].key = f;
        dayFromTimeToTimeList[5].key2 = f2;
      }
      if (index == 6) {
        dayFromTimeToTimeList[6].key = g;
        dayFromTimeToTimeList[6].key2 = g2;
      }
    }
  }
  // void bUpdateDay(index) async {
  //   dayFromTimeToTimeList[index].isSelect.value =
  //       !dayFromTimeToTimeList[index].isSelect.value;
  //   for (var days in dayFromTimeToTimeList) {
  //     if (days.isSelect.isTrue) {
  //       bDay = dayFromTimeToTimeList[index].day;
  //     }
  //   }
  //   selecteddays
  //       .removeWhere((e) => e['bDay'] == dayFromTimeToTimeList[index].day);
  //   // if (selecteddays.contains({"bDay": dayFromTimeToTimeList[index].day})) {

  //   //   selecteddays.removeAt(index);
  //   //   print("remove" + index.toString());
  //   // }
  // }

  // void bDayTime() {
  //   !selecteddays.contains("bDay");
  //   selecteddays.add({"bDay": bDay, "bFtime": bFromtime, "bTtime": bTotime});
  // }
  void bDayTime(index) {
    selecteddays.add({
      "bDay": dayFromTimeToTimeList[index].day,
      "bFtime": dayFromTimeToTimeList[index].from,
      "bTtime": dayFromTimeToTimeList[index].to,
    });
  }

  //*Hour days and Times *//
  String? hDay;
  String? hFromTime;
  String? hToTime;
  String? hFromTime2;
  String? hToTime2;

  List hDayTimeList = [];
  bool ali = true;

  void hUpdateDay(index) async {
    dayTimeList[index].isSelect.value = !dayTimeList[index].isSelect.value;
    for (var day in dayTimeList) {
      if (day.isSelect.isTrue) {
        hDay = dayTimeList[index].day;
      }
      hDayTimeList.removeWhere((e) => e['Hday'] == dayTimeList[index].day);

      // if (dayTimeList[index].isSelect.isTrue &&
      //     hDayTimeList.contains(dayTimeList[index].day)) {
      //   hDayTimeList.removeAt(index);
      // }
      // print(hDayTimeList);
    }
  }

  void hDayTime(index) {
    !hDayTimeList.contains("Hday");
    hDayTimeList.add({
      "Hday": dayTimeList[index].day,
      "HfromTime": dayTimeList[index].fromTime,
      "HtoTime": dayTimeList[index].toTime,
    });
    print(hDayTimeList);
  }

  //*FoodItem Section*//
  List<Select> foodallList = [
    Select(id: 1, name: "Bone in Wings"),
    Select(id: 2, name: "Boneless Wings"),
    Select(id: 3, name: "Pizza"),
    Select(id: 4, name: "Flat Bread"),
    Select(id: 5, name: "Burger"),
    Select(id: 6, name: "Burger- Sliders"),
    Select(id: 7, name: "Nachos"),
    Select(id: 8, name: "Nachos Chicken/Steak"),
    Select(id: 9, name: "Nachos- Ahi"),
    Select(id: 10, name: "Tacos"),
    Select(id: 11, name: "Taquitos/Flautas"),
    Select(id: 12, name: "Margarita-Well"),
    Select(id: 13, name: "Fries"),
    Select(id: 14, name: "Fries- Loaded"),
    Select(id: 15, name: "Pretzels"),
    Select(id: 16, name: "Garlic Bread/Knots"),
    Select(id: 17, name: "Cheese Bread"),
    Select(id: 18, name: "Bruschetta"),
    Select(id: 19, name: "Mozzarella Sticks"),
    Select(id: 20, name: "Dip - Cheese"),
    Select(id: 21, name: "Dip- Spinach"),
    Select(id: 22, name: "Dip- Salsa"),
    Select(id: 23, name: "Dip- Guacamole"),
    Select(id: 24, name: "Dip- Artichoke"),
    Select(id: 25, name: "Dip- Hummus"),
    Select(id: 26, name: "Chicken- Tenders"),
    Select(id: 27, name: "Chicken- Fried"),
    Select(id: 28, name: "Chicken- Grilled"),
    Select(id: 28, name: " Chicken-Other"),
    Select(id: 29, name: "Potato Skins"),
    Select(id: 30, name: "Potatos- Loaded"),
    Select(id: 31, name: "Tater Tots"),
    Select(id: 32, name: "Tater Tots- Loaded"),
    Select(id: 33, name: "Chips/Crisps"),
    Select(id: 34, name: "Onion Rings"),
    Select(id: 35, name: "Onion Blossom"),
    Select(id: 36, name: "Zucchini"),
    Select(id: 37, name: "Jalapeno Poppers"),
    Select(id: 38, name: "Pickles- Fried"),
    Select(id: 39, name: "Mac and Cheese Bites"),
    Select(id: 40, name: "Combo Platter"),
    Select(id: 41, name: "Egg Roll"),
    Select(id: 42, name: "Dumpling/ Wonton/ Pot Sticker"),
    Select(id: 43, name: "Pita"),
    Select(id: 44, name: "Wrap"),
    Select(id: 45, name: "Sandwich- Cold"),
    Select(id: 46, name: "Sandwich- Hot"),
    Select(id: 47, name: "Soup"),
    Select(id: 48, name: "Salad"),
    Select(id: 49, name: "Pasta"),
    Select(id: 50, name: "Ravioli"),
    Select(id: 51, name: "Meatballs"),
    Select(id: 52, name: "Meatloaf"),
    Select(id: 53, name: "Kabab/Skewer"),
    Select(id: 54, name: "Steak"),
    Select(id: 55, name: "Ribs"),
    Select(id: 56, name: "Cheese Plate/Platter"),
    Select(id: 56, name: " Cheese- Curds"),
    Select(id: 57, name: "Cheese and Meat Platter"),
    Select(id: 58, name: "Carpaccio"),
    Select(id: 59, name: "Sushi- Roll"),
    Select(id: 60, name: "Sushi- Sashimi or Nigiri"),
    Select(id: 61, name: "Sushi- Handroll"),
    Select(id: 62, name: "Sushi- Platter"),
    Select(id: 63, name: "Poke"),
    Select(id: 64, name: "Edamame"),
    Select(id: 65, name: "Calamari"),
    Select(id: 66, name: "Shrimp"),
    Select(id: 67, name: "Oystersl"),
    Select(id: 68, name: "Scallops"),
    Select(id: 69, name: "Mussels"),
    Select(id: 70, name: "Crab- Cakes"),
    Select(id: 71, name: "Crab- Meat"),
    Select(id: 72, name: "Crab- Leggs"),
    Select(id: 73, name: "Crab- Whole"),
    Select(id: 74, name: "Fish and Chips"),
    Select(id: 75, name: "Other Fish Dish"),
    Select(id: 76, name: "Burrito"),
    Select(id: 77, name: "Empanadas"),
    Select(id: 78, name: "Tapas"),
    Select(id: 79, name: "Meat Pie"),
    Select(id: 80, name: "Mushrooms"),
    Select(id: 81, name: "Hotdog/Corn Dog"),
    Select(id: 82, name: "Fondue"),
  ];

  final _showDaysList = false.obs;
  bool get showDayList => _showDaysList.value;
  set showDayList(value) => _showDaysList.value = value;

  final _showLateDaysList = false.obs;
  bool get showLateDayList => _showLateDaysList.value;
  set showLateDayList(value) => _showLateDaysList.value = value;
  List<LocalFoodModel> foodList = [];
  void addfoodmanually() {
    foodList.add(
      LocalFoodModel(
        name: addfoodManuallyController.text.toString(),
        quantity: 0,
        price: "",
        discount: 0,
        dropDown: ["%", "\$"],
        priceController: TextEditingController(),
        earlyFood: true.obs,
        lateFood: true.obs,
        time: foodtime,
      ),
    );
    update();
  }

  void addFoodFromDropDownList(List foods) {
    for (var e in foods) {
      foodList.add(
        LocalFoodModel(
          name: e.name.toString(),
          quantity: 0,
          price: "",
          discount: 0,
          dropDown: ["%", "\$"],
          priceController: TextEditingController(),
          earlyFood: true.obs,
          lateFood: true.obs,
          time: foodtime,
        ),
      );
      update();
    }
    Get.back();
  }

  void foodincrement(int index) {
    foodList[index].quantity++;
    update();
  }

  void fooddecrement(int index) {
    if (foodList[index].quantity > 0) {
      foodList[index].quantity--;
    } else {
      foodList[index].quantity;
    }
    update();
  }

  void removeFood(index) {
    foodList.removeAt(index);
    update();
  }

  String foodtime = "Both Time";
  foodBothTime(index) {
    foodList[index].time = foodtime;
    update();
  }

  foodfirstTime(index) {
    foodList[index].time = hFromTime.toString();
    update();
  }

  foodSecondTime(index) {
    foodList[index].time = hFromTime2.toString();
    update();
  }

  String drinktime = "Both Time";
  drinkBothTime(index) {
    localdrinkList[index].time = "Both Time";
    update();
  }

  drinkfirstTime(index) {
    localdrinkList[index].time = hFromTime.toString();
    update();
  }

  drinkSecondTime(index) {
    localdrinkList[index].time = hFromTime2.toString();
    update();
  }

  //Drink type drop down
  final _drinkDiscount = "%".obs;
  String get drinkDiscount => _drinkDiscount.value;
  set drinkDiscount(value) => _drinkDiscount.value = value;
  final drinkDiscountDropdown = ['%', '\$'];
  //Size type drop down
  final _sizeDropDown = "oz".obs;
  String get sizeDropdown => _sizeDropDown.value;
  set sizeDropDown(value) => _sizeDropDown.value = value;
  final sizeDropdownList = [
    'oz',
    'ml',
    'Can',
    'Tall Can',
    'Bottle',
    'Pint-Draft',
    'Large Draft',
    'Pitcher',
    'Glass',
    'Shot'
  ];

  //*Drink Item Section*//
  List<LocalDrinkModel> localdrinkList = [];

  showEarlyTimeFood(index) {
    foodList[index].earlyFood.value = !foodList[index].earlyFood.value;
  }

  showLateTimeFood(index) {
    foodList[index].lateFood.value = !foodList[index].lateFood.value;
  }

  showEarlyTimeDrink(index) {
    localdrinkList[index].earlyDrink.value =
        !localdrinkList[index].earlyDrink.value;
  }

  showLateTimeDrink(index) {
    localdrinkList[index].lateDrink.value =
        !localdrinkList[index].lateDrink.value;
  }

  void addDrinksmanually() {
    localdrinkList.add(
      LocalDrinkModel(
        name: addDrinksManuallyController.text.toString(),
        size: "",
        price: "",
        discount: 0,
        sizeicon: "",
        discounticon: "",
        dropDown: ["%", "\$"],
        dropDownSize: [
          'oz',
          'ml',
          'Can',
          'Tall Can',
          'Bottle',
          'Pint-Draft',
          'Large Draft',
          'Pitcher',
          'Glass',
          'Shot'
        ],
        drinkController: TextEditingController(),
        bothTimeDrink: false.obs,
        time: drinktime,
        earlyDrink: true.obs,
        lateDrink: true.obs,
      ),
    );

    update();
  }

  void addDrinkFromDropDownList(List drinks) {
    for (var e in drinks) {
      localdrinkList.add(
        LocalDrinkModel(
          name: e.name.toString(),
          size: "",
          price: "",
          discount: 0,
          sizeicon: "",
          discounticon: "",
          dropDown: ["%", "\$"],
          dropDownSize: [
            'oz',
            'ml',
            'Can',
            'Tall Can',
            'Bottle',
            'Pint-Draft',
            'Large Draft',
            'Pitcher',
            'Glass',
            'Shot'
          ],
          drinkController: TextEditingController(),
          bothTimeDrink: false.obs,
          time: drinktime,
          earlyDrink: true.obs,
          lateDrink: true.obs,
        ),
      );
      update();
    }
    Get.back();
  }

  void removeDrink(index) {
    localdrinkList.removeAt(index);
    update();
  }

  List<Select> drinkList = [
    Select(id: 1, name: "Domestic Beer"),
    Select(id: 2, name: "Craft Beer"),
    Select(id: 3, name: "Import Beer"),
    Select(id: 4, name: "Mexican Beer"),
    Select(id: 5, name: "Michelada"),
    Select(id: 6, name: "Wine"),
    Select(id: 7, name: "Brandi"),
    Select(id: 8, name: "You call it- Well"),
    Select(id: 9, name: "You call it- Premium"),
    Select(id: 10, name: "Mixed Drink- Well"),
    Select(id: 11, name: "Mixed Drink- Premium"),
    Select(id: 12, name: "Margarita-Well"),
    Select(id: 13, name: "Margarita- Premium"),
    Select(id: 14, name: "Martini- Well"),
    Select(id: 15, name: "Martini- Premium"),
    Select(id: 16, name: "Bloody Mary-Well"),
    Select(id: 17, name: "Bloody Mary- Premium"),
    Select(id: 18, name: "Mojito- Well"),
    Select(id: 19, name: "Mojito- Premium"),
    Select(id: 20, name: "Long Island- Well"),
    Select(id: 21, name: "Long Island- Premium"),
    Select(id: 22, name: "Other Whisky/Bourbon Drink- Well"),
    Select(id: 23, name: " Other Whisky/Bourbon Drink - Premium"),
    Select(id: 24, name: "Other Vodka Drink- Well"),
    Select(id: 25, name: "Other Vodka Drink- Premium"),
    Select(id: 26, name: "Other Rum Drink- Well"),
    Select(id: 27, name: "Other Rum Drink- Premium"),
    Select(id: 28, name: "Other Gin Drink- Well"),
    Select(id: 29, name: "Other Gin Drink- Premium"),
    Select(id: 30, name: "Other Tequila/Mezcal Drink- Well"),
    Select(id: 31, name: "Other Tequila/Mezcal Drink- Premium"),
    Select(id: 32, name: "Sangria"),
    Select(id: 33, name: "Saki"),
    Select(id: 34, name: "Seltzer"),
    Select(id: 35, name: "Mule"),
  ];

  //* DailySpecial Sections * //
  final adddailySpecialManuallyController = TextEditingController();
  final dailySpecialPrice = TextEditingController();
  final dailySpecialKey = GlobalKey<FormState>();

  int? dailySpecialQuantity = 0;
  String? sundaydailySpecialType;
  String? mondaydailySpecialType;
  String? tuesdaydailySpecialType;
  String? wednesdaydailySpecialType;
  String? thursdaydailySpecialType;
  String? fridaydailySpecialType;
  String? saturdaydailySpecialType;
  String? dailSpecialName;

  String dailySpecialfromtime = "01:00 AM";
  String dailySpecialtotime = "02:00 AM";
  String dailyspecialsunDay = "Sunday";
  String dailyspecialmonDay = "Monday";
  String dailyspecialtuesDay = "Tuesday";
  String dailyspecialwedDay = "Wednesday";
  String dailyspecialthursDay = "Thursday";
  String dailyspecialfriDay = "Friday";
  String dailyspecialsaturDay = "Saturday";
  final dailyDropDown = ["Foods", "Drinks"];

  List alldailySpecialList = [];

  void updatesunday(daily) {
    sundaydailySpecialType = daily!;
    update();
  }

  addToDailyySpecial() {
    alldailySpecialList.clear();
    List alldailySpecial = [];
    for (var e in sundaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in mondaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in tuesdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in wednesdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in thursdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in fridaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in saturdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    alldailySpecialList.addAll(alldailySpecial);
    update();
  }

  List sundaydailySpecialItemList = [];
  List mondaydailySpecialItemList = [];
  List tuesdaydailySpecialItemList = [];
  List wednesdaydailySpecialItemList = [];
  List thursdaydailySpecialItemList = [];
  List fridaydailySpecialItemList = [];
  List saturdaydailySpecialItemList = [];

  sundayAddTodailySpecialItemList() {
    sundaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialsunDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": sundaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void sundaydailySpecialincrement(int index) {
    sundaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void sundaydailySpecialdecrement(int index) {
    if (sundaydailySpecialItemList[index]["quantity"] > 0) {
      sundaydailySpecialItemList[index]["quantity"]--;
    } else {
      sundaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removesunday(index) {
    sundaydailySpecialItemList.removeAt(index);
    update();
  }

  mondayAddTodailySpecialItemList() {
    mondaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialmonDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": mondaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallysundayAddTodailySpecialItemList() {
    sundaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialsunDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": sundaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallymondayAddTodailySpecialItemList() {
    mondaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialmonDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": mondaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallytuesdayAddTodailySpecialItemList() {
    tuesdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialtuesDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": tuesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallywednesdayAddTodailySpecialItemList() {
    wednesdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialwedDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": wednesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallythursdayAddTodailySpecialItemList() {
    thursdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialthursDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": thursdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallyfridayAddTodailySpecialItemList() {
    fridaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialfriDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": fridaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallysaturdayAddTodailySpecialItemList() {
    saturdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialsaturDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": saturdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void mondaydailySpecialincrement(int index) {
    mondaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void mondaydailySpecialdecrement(int index) {
    if (mondaydailySpecialItemList[index]["quantity"] > 0) {
      mondaydailySpecialItemList[index]["quantity"]--;
    } else {
      mondaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removemonday(index) {
    mondaydailySpecialItemList.removeAt(index);
    update();
  }

  tuesdayAddTodailySpecialItemList() {
    tuesdaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialtuesDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": tuesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void tuesdaydailySpecialincrement(int index) {
    tuesdaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void tuesdaydailySpecialdecrement(int index) {
    if (tuesdaydailySpecialItemList[index]["quantity"] > 0) {
      tuesdaydailySpecialItemList[index]["quantity"]--;
    } else {
      tuesdaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removetuesday(index) {
    tuesdaydailySpecialItemList.removeAt(index);
    update();
  }

  wednesdayAddTodailySpecialItemList() {
    wednesdaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialwedDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": wednesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void wednesdaydailySpecialincrement(int index) {
    wednesdaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void wednesdaydailySpecialdecrement(int index) {
    if (wednesdaydailySpecialItemList[index]["quantity"] > 0) {
      wednesdaydailySpecialItemList[index]["quantity"]--;
    } else {
      wednesdaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removewednesday(index) {
    wednesdaydailySpecialItemList.removeAt(index);
    update();
  }

  thursdayAddTodailySpecialItemList() {
    thursdaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialthursDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": thursdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void thursdaydailySpecialincrement(int index) {
    thursdaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void thursdaydailySpecialdecrement(int index) {
    if (thursdaydailySpecialItemList[index]["quantity"] > 0) {
      thursdaydailySpecialItemList[index]["quantity"]--;
    } else {
      thursdaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removethursday(index) {
    thursdaydailySpecialItemList.removeAt(index);
    update();
  }

  fridayAddTodailySpecialItemList() {
    fridaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialfriDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": fridaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void fridaydailySpecialincrement(int index) {
    fridaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void fridaydailySpecialdecrement(int index) {
    if (fridaydailySpecialItemList[index]["quantity"] > 0) {
      fridaydailySpecialItemList[index]["quantity"]--;
    } else {
      fridaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removefriday(index) {
    fridaydailySpecialItemList.removeAt(index);
    update();
  }

  saturdayAddTodailySpecialItemList() {
    saturdaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialsaturDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": saturdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void saturdaydailySpecialincrement(int index) {
    saturdaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void saturdaydailySpecialdecrement(int index) {
    if (saturdaydailySpecialItemList[index]["quantity"] > 0) {
      saturdaydailySpecialItemList[index]["quantity"]--;
    } else {
      saturdaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removesaturday(index) {
    saturdaydailySpecialItemList.removeAt(index);
    update();
  }

  void dailySpecialTap() {
    var index = daysList.where((e) => e.isSelect.isTrue).length;

    bool isSunday = true;
    bool isMonday = true;
    bool isTuesday = true;
    bool isWednesday = true;
    bool isThursday = true;
    bool isFriday = true;
    bool isSaturday = true;
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Sunday") {
        isSunday = false;
        if (sundaydailySpecialItemList.isNotEmpty) {
          isSunday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Monday") {
        isMonday = false;
        if (mondaydailySpecialItemList.isNotEmpty) {
          isMonday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Tuesday") {
        isTuesday = false;
        if (tuesdaydailySpecialItemList.isNotEmpty) {
          isTuesday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Wednesday") {
        isWednesday = false;
        if (wednesdaydailySpecialItemList.isNotEmpty) {
          isWednesday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Thursday") {
        isThursday = false;
        if (thursdaydailySpecialItemList.isNotEmpty) {
          isThursday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Friday") {
        isFriday = false;
        if (fridaydailySpecialItemList.isNotEmpty) {
          isFriday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Saturday") {
        isSaturday = false;
        if (saturdaydailySpecialItemList.isNotEmpty) {
          isSaturday = true;
        }
      }
    }

    if (!dailySpecialKey.currentState!.validate()) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Error", description: "Fill All The Required Fields");
    } else if (index == 0) {
      // Get.toNamed(Routes.businessAmenitiesScreen);
    } else if (isSunday == false ||
        isMonday == false ||
        isTuesday == false ||
        isWednesday == false ||
        isThursday == false ||
        isFriday == false ||
        isSaturday == false) {
      Get.find<GlobalGeneralController>()
          .errorSnackbar(title: "Error", description: "Add Items against Day");
    } else if (dailySpecialKey.currentState!.validate()) {
      if (isSunday &&
          isMonday &&
          isTuesday &&
          isWednesday &&
          isThursday &&
          isFriday &&
          isSaturday) {
        //Get.toNamed(Routes.businessAmenitiesScreen);
      }

      addToDailyySpecial();
    }
  }

  List<String> dri = [
    "Domestic Beer",
    "Craft Beer",
    "Import Beer",
    "Mexican Beer",
    "Michelada",
    "Wine",
    "Brandi",
    "You call it- Well",
    "You call it- Premium",
    "Mixed Drink- Well",
    "Mixed Drink- Premium",
    "Margarita-Well",
    "Margarita- Premium",
    "Martini- Well",
    "Martini- Premium",
    "Bloody Mary-Well",
    "Bloody Mary- Premium",
    "Mojito- Well",
    "Mojito- Premium",
    "Long Island- Well",
    "Long Island- Premium",
    "Other Whisky/Bourbon Drink- Well",
    "Other Whisky/Bourbon Drink - Premium",
    "Other Vodka Drink- Well",
    "Other Vodka Drink- Premium",
    "Other Rum Drink- Well",
    "Other Rum Drink- Premium",
    "Other Gin Drink- Well",
    "Other Gin Drink- Premium",
    "Other Tequila/Mezcal Drink- Well",
    "Other Tequila/Mezcal Drink- Premium",
    "Sangria",
    "Saki",
    "Seltzer",
    "Mule",
  ];
  List<String> foo = [
    "Bone in Wings",
    "Boneless Wings",
    "Pizza",
    "Flat Bread",
    "Burger",
    "Burger- Sliders",
    "Nachos",
    "Nachos Chicken/Steak",
    "Nachos- Ahi",
    "Tacos",
    "Taquitos/Flautas",
    "Quesadilla",
    "Fries",
    "Fries- Loaded",
    "Pretzels",
    "Garlic Bread/Knots",
    "Cheese Bread",
    "Bruschetta",
    "Mozzarella Sticks",
    "Dip - Cheese",
    "Dip- Spinach",
    "Dip- Salsa",
    "Dip- Guacamole",
    "Dip- Artichoke",
    "Dip- Hummus",
    "Chicken- Tenders",
    "Chicken- Fried",
    "Chicken- Grilled",
    "Chicken-Other",
    "Potato Skins",
    "Potatos- Loaded",
    "Tater Tots",
    "Tater Tots- Loaded",
    "Chips/Crisps",
    "Onion Rings",
    "Onion Blossom",
    "Zucchini",
    "Jalapeno Poppers",
    "Pickles- Fried",
    "Mac and Cheese Bites",
    "Combo Platter",
    "Egg Roll",
    "Dumpling/ Wonton/ Pot Sticker",
    "Pita",
    "Wrap",
    "Sandwich- Cold",
    "Sandwich- Hot",
    "Soup",
    "Salad",
    "Pasta",
    "Ravioli",
    "Meatballs",
    "Meatloaf",
    "Kabab/Skewer",
    "Steak",
    "Ribs",
    "Cheese Plate/Platter",
    "Cheese- Curds",
    "Cheese and Meat Platter",
    "Carpaccio",
    "Sushi- Roll",
    "Sushi- Sashimi or Nigiri",
    "Sushi- Handroll",
    "Sushi- Platter",
    "Poke",
    "Edamame",
    "Calamari",
    "Shrimp",
    "Oysters",
    "Scallops",
    "Mussels",
    "Crab- Cakes",
    "Crab- Meat",
    "Crab- Leggs",
    "Crab- Whole",
    "Fish and Chips",
    "Other Fish Dish",
    "Burrito",
    "Empanadas",
    "Tapas",
    "Meat Pie",
    "Mushrooms",
    "Hotdog/Corn Dog",
    "Fondue",
  ];

  //* Amenities Section *//
  String amenity = '';
  List<String> amentyAddList = [];
  List<Amenities> amenitiesList = [
    Amenities(isSelect: false.obs, amenity: "Pool Table"),
    Amenities(isSelect: false.obs, amenity: "Dart Boards"),
    Amenities(isSelect: false.obs, amenity: "Juke Box"),
    Amenities(isSelect: false.obs, amenity: "Arcade"),
    Amenities(isSelect: false.obs, amenity: "Shuffle Board"),
    Amenities(isSelect: false.obs, amenity: "Board Games"),
    Amenities(isSelect: false.obs, amenity: "Outdoor Smoking"),
    Amenities(isSelect: false.obs, amenity: "Indoor Smoking"),
    Amenities(isSelect: false.obs, amenity: "No Smoking"),
    Amenities(isSelect: false.obs, amenity: "NFL Package"),
    Amenities(isSelect: false.obs, amenity: "NBA Package"),
    Amenities(isSelect: false.obs, amenity: "MLB Package"),
    Amenities(isSelect: false.obs, amenity: "Soccer/Football Package"),
    Amenities(isSelect: false.obs, amenity: "UFC PPV"),
    Amenities(isSelect: false.obs, amenity: "Boxing PPV"),
    Amenities(isSelect: false.obs, amenity: "Casino"),
    Amenities(isSelect: false.obs, amenity: "Large Screens"),
    Amenities(isSelect: false.obs, amenity: "Pool (Swimming)"),
    Amenities(isSelect: false.obs, amenity: "Outdoor Seating Assigned"),
    Amenities(isSelect: false.obs, amenity: "Outdoor Space Unassigned"),
    Amenities(isSelect: false.obs, amenity: "Beach/Water Front"),
    Amenities(isSelect: false.obs, amenity: "Amazing Views"),
  ];

  void updateAmenity(index) async {
    amenitiesList[index].isSelect.value = !amenitiesList[index].isSelect.value;
    for (var e in amenitiesList) {
      if (e.isSelect.isTrue) {
        amenity = amenitiesList[index].amenity;
      }
    }

    if (amenitiesList[index].isSelect.isFalse &&
        amentyAddList.contains(amenity)) {
      amentyAddList.remove(amenity);
    } else {
      amentyAddList.add(amenity);
    }
  }

  //*BarType List Section *//
  String barType = '';
  List<String> barTypeAddList = [];
  List<BarType> barTypeList = [
    BarType(isSelect: false.obs, barType: "Restaurant"),
    BarType(isSelect: false.obs, barType: "Restaurant with Bar"),
    BarType(isSelect: false.obs, barType: "Bar-Only"),
    BarType(isSelect: false.obs, barType: "Bar with Food"),
    BarType(isSelect: false.obs, barType: "Sports Bar"),
    BarType(isSelect: false.obs, barType: "Brewery"),
    BarType(isSelect: false.obs, barType: "Owner Owned"),
    BarType(isSelect: false.obs, barType: "Corporate Owned"),
    BarType(isSelect: false.obs, barType: "Dive"),
    BarType(isSelect: false.obs, barType: "Upscale"),
    BarType(isSelect: false.obs, barType: "Ulta High-End"),
    BarType(isSelect: false.obs, barType: "Winery"),
    BarType(isSelect: false.obs, barType: "Distillery"),
    BarType(isSelect: false.obs, barType: "Pool Hall"),
    BarType(isSelect: false.obs, barType: "Bowling Alley"),
    BarType(isSelect: false.obs, barType: "Casino"),
    BarType(isSelect: false.obs, barType: "Club"),
    BarType(isSelect: false.obs, barType: "Strip Club"),
    BarType(isSelect: false.obs, barType: "Roof Top"),
    // BarType(isSelect: false.obs, barType: "Restaurant- Corporate"),
    // BarType(isSelect: false.obs, barType: "Restaurant- Owner"),
    // BarType(isSelect: false.obs, barType: "Bar- Standard"),
    // BarType(isSelect: false.obs, barType: "Bar- Upscale"),
    // BarType(isSelect: false.obs, barType: "Bar- Dive"),
    // BarType(isSelect: false.obs, barType: "Sports Bar"),
    // BarType(isSelect: false.obs, barType: "Brewery"),
    // BarType(isSelect: false.obs, barType: "Winery"),
    // BarType(isSelect: false.obs, barType: "Distillery"),
    // BarType(isSelect: false.obs, barType: "Pool Hall"),
    // BarType(isSelect: false.obs, barType: "Bowling Alley"),
    // BarType(isSelect: false.obs, barType: "Casino"),
    // BarType(isSelect: false.obs, barType: "Club"),
    // BarType(isSelect: false.obs, barType: "Strip Club"),
  ];

  void onBartypeDoneTap() {
    // barTypeAddList.add(barType);
    var index = barTypeList.where((e) => e.isSelect.isTrue);
    int a = index.length;
    if (a == 0) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Error", description: "Select atleast one Bar Type");
    }
    if (a > 3) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Error", description: "Select only Three Bar Type");
    }
    if (a <= 3 && a > 0) {
      update();
      Get.back();
    }
    update();
  }

  void updateBartype(index) async {
    barTypeList[index].isSelect.value = !barTypeList[index].isSelect.value;
    for (var e in barTypeList) {
      if (e.isSelect.value == true) {
        barType = barTypeList[index].barType;
      }
    }
    if (barTypeList[index].isSelect.isFalse &&
        barTypeAddList.contains(barType)) {
      barTypeAddList.remove(barType);
    } else {
      barTypeAddList.add(barType);
    }
  }

  //*Event Section*//
  final eventKey = GlobalKey<FormState>();
  String eventStarttime = "01:00 AM";
  String eventendtime = "01:00 PM";

  List selectedEvent = [];
  List eventList = [
    Event(isSelect: false.obs, event: "Pool Tournament", day: "", time: ""),
    Event(isSelect: false.obs, event: "Free Pool", day: "", time: ""),
    Event(isSelect: false.obs, event: "Dart Tournament", day: "", time: ""),
    Event(isSelect: false.obs, event: "Cornhole Tournment", day: "", time: ""),
    Event(
        isSelect: false.obs, event: "Beer Pong Tournament", day: "", time: ""),
    Event(isSelect: false.obs, event: "Other Tournament", day: "", time: ""),
    Event(isSelect: false.obs, event: "Karaoke", day: "", time: ""),
    Event(isSelect: false.obs, event: "Trivia Night", day: "", time: ""),
    Event(isSelect: false.obs, event: "Live Music ", day: "", time: ""),
    Event(isSelect: false.obs, event: "Comedy Night", day: "", time: ""),
    Event(isSelect: false.obs, event: "Open Mic", day: "", time: ""),
    Event(isSelect: false.obs, event: "Paint and Sip", day: "", time: ""),
    Event(isSelect: false.obs, event: "Ladies Night", day: "", time: ""),
    Event(isSelect: false.obs, event: "Industry Night", day: "", time: ""),
  ];

  String? eventname = "";

  eventListadded() {
    selectedEvent.add({
      "name": eventname!,
      "day": day,
      "fromtime": eventStarttime,
      "totime": eventendtime
    });
    update();
  }

  void updateEvent(index) async {
    eventList[index].isSelect.value = !eventList[index].isSelect.value;
    for (var event in eventList) {
      if (event.isSelect == true) {
        eventname = eventList[index].event;
        update();
      }
    }
    if (eventList[index].isSelect.value == false) {
      selectedEvent
          .removeWhere((e) => e['name'] == eventList[index].event.toString());
    }
    update();
  }

  List<SelectDay> daysList = [
    SelectDay(
      isSelect: false.obs,
      day: "Sunday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Monday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Tuesday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Wednesday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Thursday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Friday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Saturday",
    ),
  ];

  final _isShowMap = true.obs;
  bool get isShowMap => _isShowMap.value;
  set isShowMap(value) => _isShowMap.value = value;

  void onHourScreenNextTap() {
    var index = dayFromTimeToTimeList.where((e) => e.isSelect.isTrue).length;

    if (index == 0) {
      Get.toNamed(Routes.businessDayTimeScreen);
    }
    if (!hourBformKey.currentState!.validate()) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Select Time", description: "Please Select all the Time");
    }
    if (hourBformKey.currentState!.validate()) {
      if (dayFromTimeToTimeList[0].isSelect.isTrue &&
          bFromtime != null &&
          bTotime != null) {
        Get.toNamed(Routes.businessDayTimeScreen);
      }
    }
  }

  final businessKey = GlobalKey<FormState>();

  void onDayTimeNextTap() {
    var index = dayTimeList.where((e) => e.isSelect.isTrue).length;
    if (index == 0) {
      Get.toNamed(Routes.businessFoodItemScreen);
    }
    if (!businessKey.currentState!.validate()) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Select Time", description: "Please Select all the Time");
    }
    if (businessKey.currentState?.validate() ?? false) {
      if (dayTimeList[0].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[0].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[1].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[1].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[2].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[2].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[3].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[3].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[4].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[4].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[5].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[5].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[6].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[6].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.addHappyHourFoodItemScreen);
        }
      }
    }
  }

  void onBusinessnextTap() {
    if (formKey.currentState!.validate()) {
      if (businessCard == "" ||
          businessImage == "" ||
          businessLogo == "" ||
          happyHourMenuImage == "") {
        Get.find<GlobalGeneralController>().errorSnackbar(
            title: "Image",
            description: "Make sure you have picked all The images");
      } else if (formKey.currentState!.validate() &&
          businessCard != "" &&
          businessImage != "" &&
          businessLogo != "" &&
          happyHourMenuImage != "") {
        Get.toNamed(Routes.businessDescriptionScreen);
      }
    }
  }

  void onDescriptionNextTap() {
    Get.toNamed(Routes.addBusinessHourScreen);
    // if (descriptionController.text == "") {
    //   Get.find<GlobalGeneralController>().errorSnackbar(
    //       title: "Error", description: "Please Write The Description");
    // } else if (descriptionController.text != "") {
    //   Get.toNamed(Routes.addBusinessHourScreen);
    // }
  }

  final geo = Geoflutterfire();

  Future<void> duplicateHappyHour() async {
    // if (formKey.currentState!.validate()) {
    GeoFirePoint _position = geo.point(
        latitude: _lat == 0.0 ? hour.latitude! : _lat,
        longitude: _long == 0.0 ? hour.longitude! : _long);
    isLoading = true;
    await _addHappyHourProvider.uploadToFirebaseStorage(
      businessName: businessNameController.text,
      businessAddress: businessAddressController.text,
      description: descriptionController.text,
      phoneNumber: phonenumberController.text,
      businessCard: businessCard.contains("image_picker")
          ? await _addHappyHourProvider
              .uploadBusinessCardImageToFirebaseStorage(
                  businessCard: businessCard)
          : businessCard,
      businessLogo: businessLogo.contains("image_picker")
          ? await _addHappyHourProvider.uploadBusinessLogoToFirebaseStorage(
              businessLogo: businessLogo)
          : businessLogo,
      businessImage: businessImage.contains("image_picker")
          ? await _addHappyHourProvider.uploadBusinessImageToFirebaseStorage(
              businessImage: businessImage)
          : businessImage,
      menuImage: happyHourMenuImage.contains("image_picker")
          ? await _addHappyHourProvider
              .uploadBusinessMenuImageImageToFirebaseStorage(
                  menuImage: happyHourMenuImage)
          : happyHourMenuImage,
      dayTime: hDayTimeList,
      fromTimeToTime: selecteddays,
      dailySpecial: alldailySpecialList,
      foodNames: foodList
          .map((e) => {
                "foodname": e.name,
                "foodcount": e.quantity,
                "fooddiscount": e.discount,
                "foodprice": e.price,
                "secondtime": e.time,
                "early": e.earlyFood.value,
                "late": e.lateFood.value,
              })
          .toList(),
      drinkitemNames: localdrinkList
          .map((e) => {
                "drinkname": e.name,
                "drinksize": e.size,
                "drinkprice": e.price,
                "drinkdiscount": e.discount,
                "sizeIcon": e.sizeicon,
                "discountIcon": e.discounticon,
                "secondtime": e.time,
                "early": e.earlyDrink.value,
                "late": e.lateDrink.value,
              })
          .toList(),
      amenities: amentyAddList,
      barType: barTypeAddList,
      event: selectedEvent,
      id: Get.find<AuthController>().user.uid,
      position: _position,
      latLong: {
        "latitude": _lat == 0.0 ? hour.latitude : _lat,
        "longitude": _long == 0.0 ? hour.longitude : _long,
      },
    );
    isLoading = false;
    await Get.offAllNamed(Routes.duplicatePackagesScreen);

    // Get.back();
  }

  void onHourScreenDoneTap() {
    for (var i = 0; i < dayFromTimeToTimeList.length; i++) {
      if (dayFromTimeToTimeList[i].isSelect.isTrue) {
        if (dayFromTimeToTimeList[i].key!.currentState!.validate() &&
            dayFromTimeToTimeList[i].key2!.currentState!.validate()) {
        } else {
          Get.find<GlobalGeneralController>().errorSnackbar(
              title: "Select Time", description: "Please Select all the Time");
        }
      }
    }
    update();
    Get.back();
  }

  void onDayTimeDoneTap() {
    for (var i = 0; i < dayTimeList.length; i++) {
      if (dayTimeList[i].isSelect.isTrue) {
        if (dayTimeList[i].keyfrom!.currentState!.validate() &&
            dayTimeList[i].keyto!.currentState!.validate()) {
        } else {
          Get.find<GlobalGeneralController>().errorSnackbar(
              title: "Select Time", description: "Please Select all the Time");
        }
      }
    }
    update();
    Get.back();
  }

  // 37.7919185
  // -122.4130261
  //}
}

class Event {
  late RxBool isSelect;
  late String event;
  late String day;
  late String time;

  Event({
    required this.isSelect,
    required this.event,
    required this.day,
    required this.time,
  });
}

class SelectDay {
  late RxBool isSelect;
  late String day;

  SelectDay({
    required this.isSelect,
    required this.day,
  });
}

class LateDayTime {
  late RxBool isSelect;
  late String day;
  late String fromTime;
  late String toTime;
  late String? fromTime2;
  late String? toTime2;
  late List? secondTime;
  late RxBool isEarly;
  late RxBool isLate;
  late GlobalKey<FormState>? keyfrom;
  late GlobalKey<FormState>? keyto;
  late GlobalKey<FormState>? keyfrom2;
  late GlobalKey<FormState>? keyto2;
  LateDayTime({
    required this.isSelect,
    required this.day,
    required this.fromTime,
    required this.toTime,
    required this.isEarly,
    required this.isLate,
    this.fromTime2,
    this.toTime2,
    this.secondTime,
    this.keyfrom,
    this.keyto,
    this.keyfrom2,
    this.keyto2,
  });
}

class SelectDayTime {
  late GlobalKey<FormState>? key;
  late GlobalKey<FormState>? key2;

  late RxBool isSelect;
  late String day;

  late List? secondTime;
  late String? from;
  late String? to;
  SelectDayTime({
    required this.isSelect,
    required this.day,
    this.secondTime,
    this.from,
    this.to,
    this.key,
    this.key2,
  });
}

class Amenities {
  late RxBool isSelect;
  late String amenity;

  Amenities({
    required this.isSelect,
    required this.amenity,
  });
}

class BarType {
  late RxBool isSelect;
  late String barType;

  BarType({
    required this.isSelect,
    required this.barType,
  });
}

class LocalFoodModel {
  late String name;
  late int quantity;
  late String price;
  late int discount;
  List<String> dropDown;
  TextEditingController priceController;
  TextEditingController? discountController;
  RxBool earlyFood;
  RxBool lateFood;
  String time;

  LocalFoodModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.dropDown,
    required this.priceController,
    this.discountController,
    required this.earlyFood,
    required this.lateFood,
    required this.time,
  });
}

class LocalDrinkModel {
  late String name;
  late String size;
  late String price;
  late int discount;
  late String sizeicon;
  late String discounticon;
  List<String> dropDown;
  List<String> dropDownSize;
  TextEditingController drinkController;
  TextEditingController? discountController;
  TextEditingController? sizeController;
  RxBool bothTimeDrink;
  String time;
  RxBool earlyDrink;
  RxBool lateDrink;

  LocalDrinkModel({
    required this.name,
    required this.size,
    required this.price,
    required this.discount,
    required this.dropDown,
    required this.drinkController,
    required this.dropDownSize,
    required this.sizeicon,
    required this.discounticon,
    this.discountController,
    this.sizeController,
    required this.bothTimeDrink,
    required this.time,
    required this.earlyDrink,
    required this.lateDrink,
  });
}

class Select {
  final int id;
  final String name;

  Select({
    required this.id,
    required this.name,
  });
}
