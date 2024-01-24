import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/views/home.dart';
import 'package:grinda/views/pages/login.dart';

import '../views/onboard/onboard.dart';

class AuthenticationController {

  // static AuthenticationRepository get instance =>Get.find();
  final box = GetStorage();
  DefaultCacheManager manager = new DefaultCacheManager();
  late final Rx<User?> firebaseUser;

  _setInitialScreen(User?user){
    user ==null ?Get.offAll(()=>OnboardScreen()) : Get.offAll(()=>HomeScreen());
  }
void signUserOut()async{
  await box.remove('userDetails');
  box.remove('hasLogin');
  await box.erase();
  await manager.emptyCache();
  Get.offAll(()=>LoginScreen());
}

}