import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/services.dart/service_handler.dart';

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

