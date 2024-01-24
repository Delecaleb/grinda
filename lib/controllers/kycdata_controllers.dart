import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/services.dart/service_handler.dart';

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

