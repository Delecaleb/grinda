import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/views/home.dart';
import 'package:grinda/views/pages/login.dart';

import '../views/onboard/onbord.dart';

class AuthenticationController {

  // static AuthenticationRepository get instance =>Get.find();
  final box = GetStorage();

  late final Rx<User?> firebaseUser;

  _setInitialScreen(User?user){
    user ==null ?Get.offAll(()=>OnboardScreen()) : Get.offAll(()=>HomeScreen());
  }
void signUserOut()async{
  box.remove('userDetails');
  box.remove('hasLogin');
  box.erase();
  Get.offAll(()=>LoginScreen());
}


}