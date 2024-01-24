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
   bool isloading = false;
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
                  Text('Welcome Back', style: TextStyle(fontSize: 25),),
                  SizedBox(height: 20,),
                  Text('Login To Your Account', style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),

                  InputWidget(label:'Email', input_controller:controller.emailAddress, inputIcon: Icon(Icons.email_outlined), isPass: false,),
                  
                  InputWidget(label:'password', input_controller:controller.password, inputIcon: Icon(Icons.lock), isPass: true, ),
                  
                 ! isloading ? InkWell(
                    onTap: (){
                      if(controller.emailAddress.text.isNotEmpty && controller.password.text.isNotEmpty){
                        SignUpController.instance.SignIn(controller.emailAddress.text, controller.password.text);
                        setState(() {
                          isloading = true;
                        });
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
                    )
                    :
                    Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Connecting...")
                      ],
                    ),

                    const SizedBox(height: 20,),
                    TextButton(
                    onPressed: ()=>Get.to(()=>CreateAccount()), child: Text('Create Account'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size.fromHeight(50)
                    ),
                    ),
                    SizedBox(height: 20,),
                    TextButton(
                    onPressed: ()=>Get.to(()=>ForgetPasswordScreen()), child: Text('Forget Password'),
                    style: TextButton.styleFrom(
                      // backgroundColor: Colors.black,
                      minimumSize: Size.fromHeight(50)
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



class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Password Reset', style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              Text('Enter registered Email Address', style: TextStyle(fontSize: 15),),
              SizedBox(height: 20,),
              InputWidget(label:'Email', input_controller:controller.emailAddress, inputIcon: Icon(Icons.email_outlined), isPass: false,),
              TextButton(
                onPressed: (){
                   if(controller.emailAddress.text.isNotEmpty){
                        Get.to(()=>SignUpController.instance.ResetUserPassword(controller.emailAddress.text));
                   }else{
                     Get.snackbar('Error', 'Please enter a valid email address');
                   }
                },
                child: Text('Reset Account', style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size.fromHeight(50)
                ),
              ),

              const SizedBox(height: 20,),
                  
              TextButton(
                onPressed: ()=>Get.to(()=>LoginScreen()), child: Text('Sing In', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size.fromHeight(50)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}