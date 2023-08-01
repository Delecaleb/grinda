
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/authentication/authenticationrepository.dart';
import 'package:grinda/models/models.dart';
import 'package:grinda/services.dart/service_handler.dart';

import '../views/home.dart';


final _box = GetStorage();

class SignUpController extends GetxController {

  static SignUpController get instance=>Get.find();
  final _db = FirebaseFirestore.instance;
  final servicehandler = ServiceHandler();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final emailAddress = TextEditingController();
  final phoneNumber = TextEditingController();
  final city = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();

  Future createUser(UserModel user) async{
    // final docUser = _db.collection('registered_users').doc();
    final userJson = user.toJson();
    servicehandler.createUser(user).then((response) => {
      if(response['message']=='done'){
        _box.write('userDetails', userJson),
        _box.write('hasLogin', true),
        Get.snackbar('Success', 'Account Created Successfully', icon: Icon(Icons.done, color: Colors.green,)),
        Get.offAll(()=>HomeScreen()),
      }else{
              Get.snackbar('Error', response['message']),
           }

    });    
  }

  void SignIn(email, password) async{
    try{

        servicehandler.LoginUser(email, password).then((response){
            final responseMap = {
              "address" : response['address'],
              "city" : response['city'],
              "country" : response['country'],
              "createdAt" : response['createdAt'],
              "email" : response['email'],
              "firstName" : response['first_name'],
              "kycFileName" : response['kycFileName'],
              "kycIdType" : response['kycIdType'],
              "kycStatus" : response['kyc_status'],
              "otherName" : response['last_name'],
              "phone" : response['phone'],
              "profilePicture" : response['profile_pics'],
              "walletBalance" : response['account_balance'],
              "password" : response['password'],
              "accountStatus":response['account_status']
            };

            _box.write('userDetails', responseMap);
            _box.write('hasLogin', true);
            Get.offAll(()=>HomeScreen());
        });    
    }catch(error){
      Get.snackbar('Error', 'Login failed. ${error.toString()}');
    }
  }

}

class UserDetailsController extends GetxController{
  final userDetails = _box.read('userDetails');

  
}