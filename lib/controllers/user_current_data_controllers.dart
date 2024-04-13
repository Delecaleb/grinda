import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/services.dart/service_handler.dart';

class UserCurrentDataController extends GetxController{
  final serviceHandler = ServiceHandler();
  final _user = GetStorage().read('userDetails');
  RxBool showBallance = true.obs;
  RxList currentData = [].obs;
  RxDouble accountBalance = 0.0.obs;
  RxDouble totalReferrals = 0.0.obs;
  @override
  void onInit() {
    getCurrentData();

    super.onInit();
  }


   void getCurrentData()async{
    try{
     await serviceHandler.GetCurrentData(_user["email"]).then((response){
      print('bawo');
      print(response);
      final  responseData = response;
     if(responseData["account_balance"] !=null && responseData["account_balance"] !=""){
        double? balance = double.tryParse(responseData["account_balance"]);
         double? referrals = double.tryParse(responseData["total_referrals"]);
      if (balance != null) {
          accountBalance.value = balance;
      }
      if(referrals != null){
          totalReferrals.value = referrals*5;
      }
     }

    });
    }catch(e){

    }
  }
}

