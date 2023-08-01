import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grinda/controllers/login_controller.dart';
import 'package:grinda/models/models.dart';
import 'package:grinda/views/pages/login.dart';
import 'package:grinda/widgets/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class CreateAccount extends StatefulWidget {
   CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final controller = Get.put(SignUpController());

   FirebaseMessaging messaging = FirebaseMessaging.instance;
   
   String userToken='';

   void getUserToken()async{
    String ? token = await messaging.getToken();
    setState(() {
      userToken = token!;
    });
   }

  @override
  Widget build(BuildContext context) {
    getUserToken();
    return MaterialApp(
      home: Scaffold(

        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InputWidget(label:'First Name', input_controller:controller.firstName, inputIcon: Icon(Icons.person_3_outlined)),
                      InputWidget(label:'Other Name', input_controller:controller.lastName, inputIcon: Icon(Icons.person_3_outlined),),
                    InputWidget(label:'Email', input_controller:controller.emailAddress, inputIcon: Icon(Icons.email_outlined)),
                    IntlPhoneField(
                    controller: controller.phoneNumber,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.5,
                                ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 1.5
                              )
                            )
                        ),
                        initialCountryCode: 'NG',
                        onChanged: (phone) {
                            // print(phone.completeNumber);
                        },
                    ),
                  InputWidget(label:'City', input_controller:controller.city, inputIcon: Icon(Icons.location_city),),
                  InputWidget(label:'Address', input_controller:controller.address, inputIcon: Icon(Icons.location_on_outlined),),
                  InputWidget(label:'Password', input_controller:controller.password, inputIcon: Icon(Icons.lock_outline_rounded),),
                  
                    ],
                  ),
                  InkWell(
                    onTap: (){
                        if(controller.firstName.text.isNotEmpty && controller.emailAddress.text.isNotEmpty &&  controller.phoneNumber.text.isNotEmpty && controller.lastName.text.isNotEmpty && controller.city.text.isNotEmpty && controller.address.text.isNotEmpty && controller.password.text.isNotEmpty){
                            final user = UserModel(
                              userToken: userToken,
                              firstName: controller.firstName.text.trim(), 
                              otherName: controller.lastName.text.trim(), 
                              email: controller.emailAddress.text.trim(), 
                              phone: controller.phoneNumber.text.trim(), 
                              address: controller.address.text.trim(), 
                              city: controller.city.text.trim(), 
                              password: controller.password.text.trim(), 
                              kycStatus: 'pending', 
                              walletBalance: '0', 
                              profilePicture: '', 
                              createdAt: '', 
                              kycFileName: '', 
                              kycIdType: '', 
                              country: '');
                            SignUpController.instance.createUser(user);
                        }else{
                          Get.snackbar(
                            "Errors",
                            'All fields are required!',
                            icon: Icon(Icons.error)
                          );
                        }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)
                        
                      ),
                      width: double.infinity,
                      child: const Text('Create Account', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                      )),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: ()=>Get.to(
                        curve:Curves.ease,
                        transition:Transition.downToUp,
                        duration:const Duration(milliseconds: 500),
                        ()=>LoginScreen(),
                      ),
                      child: const Text.rich(
                        TextSpan(
                          text: 'Already Have an Account ?',
                          children: [
                          TextSpan(
                            text: 'Sing In',
                            style: TextStyle(color: Colors.green)
                          )
                        ])
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}