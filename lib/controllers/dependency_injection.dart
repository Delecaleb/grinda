import 'package:get/get.dart';
import 'package:grinda/controllers/connectivity.dart';

class DependencyInjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}