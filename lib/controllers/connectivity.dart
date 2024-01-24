import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController{
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionState);
  }

  void _updateConnectionState(ConnectivityResult connectivityResult){
    if(connectivityResult == ConnectivityResult.none){
      Get.rawSnackbar(
        messageText: Text('PLEASE CONNECT TO INTERNECT', style: TextStyle(color: Colors.white),),
        duration: Duration(minutes: 20),
        snackPosition: SnackPosition.TOP
      );
    }else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}