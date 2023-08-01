import 'package:get/get.dart';

class FCMTokenController extends GetxController {
  FCMTokenController();
  String? token;

  void setToken(String? value) {
    token = value;
    update(); // Notify listeners of the token change
  }
}
