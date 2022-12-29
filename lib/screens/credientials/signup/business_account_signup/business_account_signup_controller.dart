import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

class BusinessAccountSignUpController extends GetxController {
  // * variables
  final formGlobalKey = GlobalKey<FormState>();
  final nameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // * observable variables.

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _obscurePassword = true.obs;
  bool get obscurePassword => _obscurePassword.value;

  final _obscureConfirmPassword = true.obs;
  bool get obscureConfirmPassword => _obscureConfirmPassword.value;

  // * methods
  onShowPasswordTap() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  onShowConfirmPasswordTap() {
    _obscureConfirmPassword.value = !_obscureConfirmPassword.value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (!GetUtils.isEmail(value)) {
      return "Invalid Email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (value.length < 8) {
      return "Password should be 8 or more characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (value.length < 8) {
      return "Password should be 8 or more characters";
    } else if (passwordFieldController.text != value) {
      return "Password does not match";
    }

    return null;
  }

  // * if all field are correct then pass the values to auth controller's createUser method.
  validateForm() {
    if (formGlobalKey.currentState!.validate()) {
      isLoading = true;

      Get.find<AuthController>().createBusinessUser(
        username: nameFieldController.text,
        email: emailFieldController.text,
        password: passwordFieldController.text,
        confirmPassword: confirmPasswordController.text,
        isBusiness: true,
      );
    }
  }

  // onSignInTap() {
  //   Get.offNamed(Routes.loginScreen);
  // }
}
