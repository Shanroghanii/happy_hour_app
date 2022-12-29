import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/app_routes.dart';

class MapController extends GetxController {
  final List hours = Get.arguments;
  // final Completer<GoogleMap> complete = Completer();
  late Uint8List mapMarkerStandard;
  late Uint8List mapMarkerBusiness;
  @override
  Future<void> onInit() async {
    super.onInit();
    final ByteData standard =
        await rootBundle.load('assets/icons/Group 11720.png');
    mapMarkerStandard = standard.buffer.asUint8List();

    final ByteData business =
        await rootBundle.load('assets/icons/Group 11719.png');
    mapMarkerBusiness = business.buffer.asUint8List();
    // mapMarkerStandard =
    //     await getBytesFromAsset('assets/icons/Group 8550.png', 100);
    // mapMarkerBusiness = await getBytesFromAsset('assets/icons/map.png', 120);
  }

  double? latitude;
  double? longitude;

  // * initial camera position
  final CameraPosition defaultCameraPosition = const CameraPosition(
    target: LatLng(33.6292139, 73.1170956),
    zoom: 12.5,
  );

  // * observable variables
  final _markers = <Marker>{}.obs;
  // ignore: invalid_use_of_protected_member
  get markers => _markers.value;
  set addMarker(value) => _markers.add(value);

  onMapCreated(GoogleMapController controller) async {
    for (final hour in Get.arguments) {
      addMarker = Marker(
        markerId: MarkerId(hour.businessName.toString()),
        infoWindow: InfoWindow(
            onTap: () {
              Get.toNamed(Routes.happyHourDetailScreen, arguments: hour);
            },
            title: hour.businessName,
            snippet: hour.businessName,
            anchor: const ui.Offset(0.9, 1)),
        position: LatLng(hour.latitude, hour.longitude),
        // icon: BitmapDescriptor.defaultMarker,
        icon: hour.id == ""
            ? BitmapDescriptor.fromBytes(mapMarkerStandard)
            : BitmapDescriptor.fromBytes(mapMarkerBusiness),
        // icon: hour.paid.toString() != ""
        //     ? BitmapDescriptor.fromBytes(mapMarkerBusiness)
        //     : BitmapDescriptor.fromBytes(mapMarker),
      );
      latitude = hour.latitude;
      longitude = hour.longitude;
    }
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude!, longitude!), zoom: 12.5)));
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
