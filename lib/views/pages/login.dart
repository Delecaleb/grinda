import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/views/home.dart';
import 'package:grinda/views/pages/register.dart';

import '../../controllers/login_controller.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(SignUpController());
  final box = GetStorage();
   bool hasLogin = false;
@override
  void initState() {
    // TODO: implement initState
    if( box.read('hasLogin') !=null){
        hasLogin = box.read('hasLogin');
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: hasLogin ? HomeScreen() : SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputWidget(label:'Email', input_controller:controller.emailAddress, inputIcon: Icon(Icons.email_outlined)),
                  
                  InputWidget(label:'password', input_controller:controller.password, inputIcon: Icon(Icons.lock),),
                  InkWell(
                    onTap: (){
                      if(controller.emailAddress.text.isNotEmpty && controller.password.text.isNotEmpty){
                        SignUpController.instance.SignIn(controller.emailAddress.text, controller.password.text);
                      }else{
                        Get.snackbar('Error', 'All fields Are required');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(5)
                        
                      ),
                      width: double.infinity,
                      child: const Text('Sign In', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                      )),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () => Get.to(()=>CreateAccount()),
                      child: const Text.rich(
                        TextSpan(
                          text: 'New Here ? ',
                          children: [
                            TextSpan(
                              text: 'Create Account',
                              style: TextStyle(color: Colors.green)
                            ),
                          ]
                        )
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      );
  }
}