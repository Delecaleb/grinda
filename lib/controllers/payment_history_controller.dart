import 'package:get/get.dart';
import 'package:grinda/services.dart/service_handler.dart';

class PaymentHistoryController extends GetxController{
  RxList paymentsList = [].obs;
  RxBool isloading = false.obs;

  final serviceHandler = ServiceHandler();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  void getPaymentHistory(userid)async{
    
    final payments = await serviceHandler.getPaymentHistory(userid);
    paymentsList.addAll(payments);

  }


}