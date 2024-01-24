import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/services.dart/service_handler.dart';

class OrderController extends GetxController {
   final _user = GetStorage().read('userDetails');
  final orders = [].obs;
  final serviceHandler = ServiceHandler();
  @override
  void onInit() {
    // TODO: implement onInit
    getOrders();
    super.onInit();
  }

  void getOrders()async{
    try{
      serviceHandler.GetCompletedOrders(_user['email']).then((data){
        print(data);
        orders.assignAll(data);
      });

    }catch(e){

    }

    
  }
}