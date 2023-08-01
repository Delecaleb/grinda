import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/services.dart/service_handler.dart';

class AppControllers extends GetxController {
  var currentScreen = 1.obs;
}

class KYCDataController extends GetxController{
  final serviceHandler = ServiceHandler();
  final _user = GetStorage().read('userDetails');
  
  // final kycData = Rx<dynamic>(null);
  Rx<Map<String, dynamic>> kycData = Rx<Map<String, dynamic>>({});

   @override
  void onInit() {
    fetchData(); // Fetch data when the controller is initialized
    super.onInit();
  }
  void fetchData()async{
    try{
      serviceHandler.GetKYCStatus(_user['email']).then((data){
        print(data);
        kycData.value =data;
      });
    }catch(e){

    }
  }

}

class UserCurrentDataController extends GetxController{
  final serviceHandler = ServiceHandler();
  final _user = GetStorage().read('userDetails');

  RxInt accountBalance = 0.obs;

  @override
  void onInit() {
    getCurrentData();

    super.onInit();
  }

  void getCurrentData(){
    try{
      serviceHandler.GetCurrentData(_user['email']).then((responseData){
     
     if(responseData['account_balance'] !=null && responseData['account_balance'] !=''){
          accountBalance.value = responseData['account_balance']; 
     }

    });
    }catch(e){

    }
  }
}

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