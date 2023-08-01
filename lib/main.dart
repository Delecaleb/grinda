import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/authentication/authenticationrepository.dart';
import 'package:grinda/controllers/geolocation_controller.dart';
import 'package:grinda/views/onboard/onbord.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grinda/views/pages/login.dart';
import 'package:grinda/views/pages/register.dart';
Future main() async{
  await GetStorage.init();
  final box = GetStorage();
  bool showOnboard = true;
  
  if( box.read('showOnboard') !=null){
    showOnboard = box.read('showOnboard');
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // .then((value) => Get.put(AuthenticationRepository()));
  await Geolocator.requestPermission();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Get.put(GeolocatorController());
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
   
  runApp(MyApp(showOnboard:showOnboard));
}

class MyApp extends StatelessWidget {
   bool showOnboard; 
   MyApp({ required this.showOnboard, super.key});
  
  @override
  Widget build(BuildContext context) {
    print(showOnboard);
    return GetMaterialApp(
      // routes: ,
      theme: ThemeData(
      
        primarySwatch: const MaterialColor(0xFF4CAF50, <int, Color>{
            50: Color(0xFF4CAF05),
            100: Color(0xFF4CAF10),
            200: Color(0xFF4CAF20),
            300: Color(0xFF4CAF30),
            400: Color(0xFF4CAF40),
            500: Color(0xFF4CAF50),
            600: Color(0xFF4CAF60),
            700: Color(0xFF4CAF70),
            800: Color(0xFF4CAF80),
            900: Color(0xFF4CAF90),

        }),
      ),
      home: showOnboard ? OnboardScreen() : LoginScreen(),
    );
  }
}

