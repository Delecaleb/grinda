import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/utils/styles.dart';
import 'package:grinda/views/pages/register.dart';

import '../../controllers/onboard_controller.dart';

class OnboardScreen extends StatelessWidget {
   OnboardScreen({super.key});
  final onboard_controller = OnboardController();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              
              onPageChanged: onboard_controller.currentScreen,
              controller: onboard_controller.pageScrollController,
              itemCount: onboard_controller.onboardScreens.length,
              itemBuilder: (BuildContext, index){
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(onboard_controller.onboardScreens[index].image, 
                      width: MediaQuery.of(context).size.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        
                        child: Text(onboard_controller.onboardScreens[index].title,textAlign: TextAlign.center,  style: onboardHeader,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30.0),
                        
                        child: Text(onboard_controller.onboardScreens[index].subTitle, textAlign: TextAlign.center, ),
                      ),
                      
                    ],
                  ),
                );
              }
              ),
              Positioned(
                bottom: 15,
                left: 10,
                child: Row(
                  children: List.generate(onboard_controller.onboardScreens.length, 
                  (index) => Obx(() {
                      return Container(
                        width: 20,
                        height: 5,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: onboard_controller.currentScreen.value==index ? Colors.green : Colors.grey,
                        ),
                      );
                    }
                  )
                  ),
                )             
              ),
              Obx(() {
                  return Positioned(
                    bottom: 15,
                    right: 10,
                    child:!onboard_controller.isLastPage ? 
                    InkWell(onTap:()=>onboard_controller.nextFunc(), 
                      child: Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: Colors.green
                          ),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Text('NEXT >', style: TextStyle(color: Colors.green),)),
                        )  :
                      InkWell(
                        onTap: (){
                            box.write('showOnboard', false);
                            Get.to(()=>CreateAccount());
                        }, 
                      child: Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 2,
                            color: Colors.green
                          ),
                        ),
                        child: Text('Get Started', style: TextStyle(color: Colors.white),)),
                        ) 
                  );
                }
              ),
          ],
        ) 
      ),
    );
  }
}