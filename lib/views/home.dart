import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grinda/controllers/controllers.dart';
import 'package:grinda/views/mainscreen.dart';
import 'package:grinda/views/orders.dart';
import 'package:grinda/views/profile.dart';  
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  List pages = [
    OrderScreen(),
    MainScreen(),
    ProfileScreen(),
];
  final app_controller = AppControllers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: CurvedNavigationBar(
        index: app_controller.currentScreen.value,
        onTap: (index)=>app_controller.currentScreen.value=index,
        color: Color.fromARGB(125, 11, 175, 8),
        backgroundColor: Colors.white,
        // animationCurve: Curves.easeIn,
        buttonBackgroundColor: Colors.green,
        animationDuration: Duration(milliseconds: 100),
        height: 60,
        items: [
        //  BottomNavigationBarItem(
           Icon(Icons.list_alt_sharp, color: Colors.white,),
          // label: 'Orders',
          // ),
          // BottomNavigationBarItem(
            ImageIcon(AssetImage('assets/grind.png'), size: 30,),
          // label: '',
          // ),
          // BottomNavigationBarItem(
            Icon(Icons.person_3_outlined , color: Colors.white,),
          // label: 'Account',
          // ),
        ]
        ),
      body: SafeArea(
        child: Obx(() {
            return pages[app_controller.currentScreen.value];
          }
        )
      ),
    );
  }
}