import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/utils/styles.dart';
import 'package:grinda/views/pages/start_kyc.dart';

import '../views/pages/complete_kyc.dart';

class InputWidget extends StatelessWidget {
  
  String label;
  Icon inputIcon;
  late TextEditingController input_controller;
  InputWidget({super.key, required this.label, required this.input_controller, required this.inputIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.only(bottom: 15),
      child: TextField(
        scrollPadding: EdgeInsets.only(bottom: 30),
        controller: input_controller,
        decoration: InputDecoration(
        prefixIcon: inputIcon,
        prefixIconColor: Colors.green,
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 1.5)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.5,
          )
        )
    
        ),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget{
  String image, category;
CategoryBox({required this.category, required this.image});
 @override
Widget build(BuildContext context){
  return Card(
    child: Container(
      padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Image.asset(image, width: MediaQuery.of(context).size.width *0.23, height: MediaQuery.of(context).size.width *0.23,),
                  Text(category)
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(187, 251, 255, 251),
              ),
            ),
  );
}

}

class ListTileWidget extends StatelessWidget{
  String listTitle;
  Icon listIcon;
  
  ListTileWidget({required this.listTitle, required this.listIcon});

  Widget build(BuildContext context){
    return ListTile(
      // onTap: tapFunction,
      leading: CircleAvatar(
        backgroundColor: Colors.green[50],
        child: listIcon
        ),
      title: Text(listTitle, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15,),
    );
  }
}


class OrdersListWidget extends StatelessWidget{
  String listTitle, subTitle;
  OrdersListWidget({required this.listTitle,  required this.subTitle});

  Widget build(BuildContext context){
    return ListTile(
      title: Text(listTitle),
      subtitle: Text(subTitle),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}

class ActionIconBtnWidget extends StatelessWidget {
  String title; IconData icon;

   ActionIconBtnWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Icon(icon),
                          ),
                          SizedBox(height: 5,),
                          Text(title, style: TextStyle(color: Colors.white, fontSize: 9),)
                        ],
                      );
  }
}

class ServiceCategoryWidget extends StatelessWidget {
  String title, imageIcon;  
   ServiceCategoryWidget({required this.title, required this.imageIcon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            child: Image.asset(
              imageIcon,
              width: 35,
              height: 35,
              ),
          ),
          Text(title, style: IconTitle,)
        ],
      ),
    );
  }
}

class KYCAlertWidget extends StatefulWidget {
  const KYCAlertWidget({super.key});

  @override
  State<KYCAlertWidget> createState() => _KYCAlertWidgetState();
}
bool showKYC = true;
final box = GetStorage().read('userDetails');


class _KYCAlertWidgetState extends State<KYCAlertWidget> {
  void showKYCDialog()async{
    Get.defaultDialog(
      title: ' ',
      content: Container(
            padding: EdgeInsets.all(20),
            height: 500,
            width: double.infinity,
            child: Column(
              children: [
                const Text(
                  'KYC',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                const Text('Important Notice'),
                Text(
                    ' You can not use this service if you have not completed KYC. This is important to ensure the safety of every party involved in trasactionsions',
                    style: TextStyle(height: 2.4)),
                Text(
                  'To complete your KYC, click on the button bellow',
                  style: TextStyle(height: 2.4),
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () =>
                            Get.to(()=>StartKyc()),
                        child: Text('Complete KYC')))
              ],
            ),
          )
    );
    setState(() {
      showKYC = false;
    });
  }
  @override
  void initState() {
    if(box['accountStatus'].toLowerCase()!='approved' && showKYC){

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showKYCDialog();
    });
   
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PaddedContainerWidget extends StatelessWidget {
  final Widget child; 
  PaddedContainerWidget({ required this.child,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: child,
    );
  }
}