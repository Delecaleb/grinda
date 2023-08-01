import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grinda/authentication/authenticationrepository.dart';
import 'package:grinda/controllers/login_controller.dart';
import 'package:grinda/views/pages/complete_kyc.dart';
import 'package:grinda/views/pages/start_kyc.dart';
import 'package:grinda/views/profiles_pages/about.dart';
import 'package:grinda/widgets/widgets.dart';

import '../models/models.dart';

class ProfileScreen extends StatelessWidget {
  final userProfileController = Get.put(UserDetailsController());
  final authenticationController = AuthenticationController();
  ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children:  [
          SizedBox(height: 20,),
          Container(
            width: double.infinity,
            child: Text('My Account',textAlign: TextAlign.left, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),)),
          SizedBox(height: 6,),
          Card(
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                box['profilePicture'] !=null && box['profilePicture'] !=''?
                CircleAvatar(
                  radius: 52,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                    width: 100,
                    height: 100,
                    imageUrl:box['profilePicture'],
                    ),
                  ),
                ):
                ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/user_icon.jpg',
                  width: 100,
                  height: 100,
                ),
              ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Text("${userProfileController.userDetails['firstName']} ${userProfileController.userDetails['otherName']}", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, overflow: TextOverflow.ellipsis),)),
                      SizedBox(height: 5,),
                      Container(child: Text('${userProfileController.userDetails['phone']}', style: TextStyle(overflow: TextOverflow.ellipsis),)),
                      SizedBox(height: 5,),
                      Container(
                        child: Text('${userProfileController.userDetails['email']}', style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                        )
                        ),
                    ],
                  ),
                ),
            
              ]
              ),
            ),
          ),

          SizedBox(height: 20,),

          Card(
            child: Container(
             child: Column(children: [
              ListTileWidget(listIcon: Icon(Icons.mail_outline_rounded), listTitle: 'Messages',),
              Divider(),
              ListTileWidget(listTitle: 'Help', listIcon: Icon(Icons.help_outline_rounded)),
              Divider(),
              InkWell(onTap: () => Get.to(()=>AboutUs()),child: ListTileWidget(listTitle: 'About', listIcon: Icon(Icons.supervised_user_circle))),
              Divider(),
              InkWell(
                onTap: (){Get.to(()=>StartKyc());},
             child: ListTileWidget(listTitle: 'KYC', listIcon: Icon(Icons.verified)),
              ),
              Divider(),
              
              InkWell(
                onTap: ()=>authenticationController.signUserOut(),
                child: ListTileWidget(listTitle: 'Logout', listIcon: Icon(Icons.lock)),
              ),
              
                
             ]), 
            ),
          )

        ],
      ),
    );
  }
}