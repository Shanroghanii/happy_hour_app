import 'package:get/get.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

class StartedScreenController extends GetxController {
  onGetStartedTap() {
    Get.offNamed(Routes.homeScreen);
    // Get.offNamed(Routes.addHappyDailySpecialScreen);
  }
}
