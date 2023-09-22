import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get_storage/get_storage.dart";
import 'package:flutter_paystack/flutter_paystack.dart';
import "package:grinda/utils/styles.dart";

class AddMoney extends StatefulWidget {
  AddMoney({super.key});

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

  TextEditingController amountController = TextEditingController();
  final box = GetStorage().read('userDetails');
  TextEditingController emailController = TextEditingController();
class _AddMoneyState extends State<AddMoney> {
  var publicKey = 'pk_live_ad1eb7b0e3aadb304a73e3bf55ca1af3a73ddb9d';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
  }
  String email = box['email'];
  void makePay(int amount)async{

  Charge charge = Charge()
      ..amount = amount*100
      ..reference = '${email}_${DateTime.now()}'
       // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = email
      ..currency ='NGN';
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    if(response.status==true){
      // call a function to add money to user ballance
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fund My Wallet', style: titleHeader,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              
              SizedBox(height: 20,),
              Text('Enter Amount',),
              SizedBox(height: 15,),
              TextField(
                style: TextStyle(fontSize: 20),
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                decoration: InputDecoration(
                  labelText: 'Amount',
      
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: ()=>makePay(int.parse(amountController.text)), 
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  
                ),
                )
            ],
          ),
        ),
      ),
    );
  }
}