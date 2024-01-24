import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../models/onboard_models.dart';

class OnboardController extends GetxController{
   var currentScreen = 0.obs;
   var pageScrollController = PageController();
   bool get isLastPage => currentScreen.value== onboardScreens.length-1;
   void nextFunc(){
    pageScrollController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
   }
  List<OnboardModel> onboardScreens= [
    OnboardModel(image: 'assets/lb.jpg', subTitle: 'Contact skilled handymen for professional repairs and maintenance of all your needs and get Quality service, efficient solutions, and excellent results', title: 'Get the Help You Need, When You Need It!'),
    OnboardModel(image: 'assets/lb.jpg', subTitle: 'Hassle-free repairs and maintenance, anytime and anywhere you need them.', title: 'Expert Services at Your Fingertips!'),
    OnboardModel(image: 'assets/lb.jpg', subTitle: '24/7 access to the labour market to address your needs and concerns.', title: 'Relax While We Take Care of Your Needs'),
  ];
}

class RegisterFormController extends GetxController{
  TextEditingController firstNameController = TextEditingController();
}