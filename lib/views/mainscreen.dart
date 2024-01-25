import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/services.dart/service_handler.dart';
import 'package:grinda/utils/styles.dart';
import 'package:grinda/views/ServiceProviderTrackingScreen.dart';
import 'package:grinda/views/pages/start_kyc.dart';
import 'package:grinda/views/pay.dart';
import 'package:grinda/widgets/animation.dart';
import 'package:grinda/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';
import '../controllers/kycdata_controllers.dart';
import '../controllers/geolocation_controller.dart';
import '../controllers/user_current_data_controllers.dart';
import '../models/service_provider_models.dart';
import '../transaction_history.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final GeolocatorController locationController =  Get.put(GeolocatorController());

  PageController _pageController = PageController(initialPage: 0);
  final serviceHandler = ServiceHandler();
  @override
  Widget build(BuildContext context) {
    final UserCurrentDataController userCurrentData = Get.put(UserCurrentDataController());  
    final KYCDataController kycDataController = Get.put(KYCDataController());
    
    final box = GetStorage().read('userDetails');
    
    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          child: Row(
            children: [
              KYCAlertWidget(),
              box['profilePicture'] !=null && box['profilePicture'] !=''?
              ClipOval(
                child: CachedNetworkImage(
                  width: 40,
                  height: 40,
                  imageUrl:  box['profilePicture'],
                ),
              )
              :
              Container(
                child: Image.asset(
                  'assets/user_icon.jpg',
                  width: 40,
                  height: 40,
                ),
              ),

              SizedBox(width: 20,),
              Text(
                'Hi, ${box['otherName']} ',
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Wallet Ballance', style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),
                      IconButton(onPressed: () {
                        if(userCurrentData.showBallance.value){
                            userCurrentData.showBallance.value=false;
                        }else{
                            userCurrentData.showBallance.value=true;
                        }
                      },icon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,size: 17,),),
                    ],
                  ),

                  Obx(() {
                      return Container(
                          child: userCurrentData.showBallance.value ? 
                                Text('₦ ${userCurrentData.accountBalance.value}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500))
                                :
                                Text("* * * * *", style: titleHeaderLight,)
                      );
                    }
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      GestureDetector(
                        child: ActionIconBtnWidget(title: 'Add Money', icon: Icons.add),
                        onTap: () => Get.to(()=>AddMoney()),
                      ), 
                      SizedBox(width: 20,),
                      
                      GestureDetector(
                          child: ActionIconBtnWidget(title: 'History', icon: Icons.history),
                          onTap: ()=>Get.to(TransactionHistory(userId: box['email'],)),
                      )                      
                    
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),


            
            Container(
                decoration:const  BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                  BoxShadow(
                    color:Color.fromARGB(255, 197, 232, 198),
                    offset: Offset(0, 1),
                    spreadRadius: 1,
                    blurRadius: 1
                  )
                ] 
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'What Service Do You Need ?',
                      style: titleHeader,
                    ),
                    SizedBox(height: 10,),
                    TextField(
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          late Future<List<ServiceProviderModel>> getService =
                              locationController.getClosestServiceProvider(
                                  locationController.serviceSearchController.text
                                      .trim());
            
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  height: 500,
                                  padding: EdgeInsets.only(top: 20),
                                  child:
                                      FutureBuilder<List<ServiceProviderModel>>(
                                          future: getService,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data!.isEmpty) {
                                                  return Container(
                                                    child: Center(
                                                        child: Text(
                                                            'No Service provider found')),
                                                  );
                                                } else {
                                                  return ListView.builder(
                                                      itemCount:
                                                          snapshot.data?.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              index) {
                                                        ServiceProviderModel
                                                            serviceProvider =
                                                            snapshot.data![index];
                                                        return Card(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              color: Colors.white,
                                                              child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width * 0.46,
                                                                      child: serviceProvider.profilePics !='' && serviceProvider.profilePics !=null ? 
                                                                      Image.network(
                                                                        loadingBuilder:(context, child, loadingProgress){
                                                                          if (loadingProgress == null) {
                                                                                  // If the image is fully loaded, return the original child
                                                                                  return child;
                                                                                } else {
                                                                                  // If the image is still loading, display a loading indicator
                                                                                  return Center(
                                                                                    child: CircularProgressIndicator(
                                                                                      value: loadingProgress.expectedTotalBytes != null
                                                                                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                                                          : null,
                                                                                    ),
                                                                                  );
                                                                                }
                                                                        } ,
                                                                        serviceProvider.profilePics,
                                                                        width: MediaQuery.of(context).size.width,
                                                                      )
                                                                      :
                                                                      Text('Image not Available')
                                                                    ),
                                                                    SizedBox(width: 10,),

                                                                    Expanded(
                                                                      child: Column(
                                                                          children: [
                                                                      Text(
                                                                        "${serviceProvider.firstName} ${serviceProvider.lastName}",
                                                                        style: TextStyle(
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          '${serviceProvider.jobTitle}'),
                                                                      Text(
                                                                          '${serviceProvider.description}'),
                                                                      
                                                                      SizedBox( height:5,),
                                                                      RateWidget(),
                                                                      SizedBox(height: 5,),
                                                                      Text('Currently Location '),
                                                                      SizedBox(height: 5,),
                                                                      FutureBuilder<List<Placemark>>(
                                                                      future: placemarkFromCoordinates(
                                                                        (serviceProvider.latitude),
                                                                        (serviceProvider.longitude),
                                                                      ),
                                                                      builder: (context, snapshot) {
                                                                        if (snapshot.connectionState == ConnectionState.done &&
                                                                            snapshot.hasData &&
                                                                            snapshot.data!.isNotEmpty) {
                                                                          Placemark placemark = snapshot.data![0];
                                                                          return Container(
                                                                              child: Text("${placemark.name} ${placemark.street}, ${placemark.subLocality}, ${placemark.locality}")
                                                                              );
                                                                        } else {
                                                                          return Text("Location information not available");
                                                                        }
                                                                      },
                                                                    ),
                                                                    Text('Approximately', style: IconTitle,),
                                                                    Text("${serviceProvider.distance} miles to you"),
                                                                      
                                                                      // send notification if KYC has been completed else send them to kyc
                                                                      kycDataController.kycData.value['account_status'] !='' && kycDataController.kycData.value['account_status'] !=null && kycDataController.kycData.value['account_status'].toLowerCase() =='approved' ?
                                                                      ElevatedButton(
                                                                          onPressed: () async {
                                                                            serviceHandler.acceptServiceProvider(box['email'], serviceProvider.email, locationController.serviceSearchController.text.trim());
                                                                            Get.to(() => ServiceProviderTrackingScreen(serviceProvider:serviceProvider));
                                                                          },
                                                                          child: Text('CONNECT')
                                                                      )
                                                                      :
                                                                      ElevatedButton(
                                                                          onPressed: ()=>Get.to(()=>StartKyc()),
                                                                          child: Text('CONNECT')
                                                                      )

                                                                          ],
                                                                        ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                }
                                              } else {
                                                return Container(
                                                  child: Text(
                                                      'No Service provider found'),
                                                );
                                              }
                                            } else {
                                              return Container(
                                                child: Center(
                                                  child: AnimatedSearch()
                                                ),
                                              );
                                            }
                                          }),
                                ),
                              );
                            },
                          );
                        },
                        scrollPadding: EdgeInsets.only(bottom: 30),
                        controller: locationController.serviceSearchController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.green,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 1.5)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                            ))),
                      )
                  ],
                )
            ),

            SizedBox(height: 20,),
            Obx(() {
                return kycDataController.kycData.value['account_status'] !='' && kycDataController.kycData.value['account_status'] !=null && kycDataController.kycData.value['account_status'].toLowerCase() =='approved' ? 
                Container()
                :
                InkWell(
                  onTap: ()=> Get.to(()=>StartKyc()),
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10) 
                    ),
                    child: Text("Complete KYC to help connect with service providers",textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),)
                  ),
                );

              }
            ), 
            SizedBox(
              height: 20,
            ),           
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 197, 232, 198),
                    offset: Offset(0, 1),
                    spreadRadius: 1,
                    blurRadius: 1
                  )
                ] 
              ),
              child: ListTile(
                onTap: ()=>Share.share('Grindas makes life easy. Sign up on Grindas to start conneting with service providers https://example.com', subject: 'Grindas App'),
                title:  Text("Refer a Friend and Earn",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
                trailing:  Icon(Icons.share)
                
              )
            ),

            SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 197, 232, 198),
                    offset: Offset(0, 1),
                    spreadRadius: 1,
                    blurRadius: 1
                  )
                ] 
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Column(
                      children: [
                        const Text('Total Bonus'),
                        SizedBox(height: 10,),
                        Obx(() {
                          return Text("${userCurrentData.totalReferrals.value}%", style: titleHeader,);
                        }),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('assets/bonus.png', width: Get.width*0.3,),
                        SizedBox(height: 10,),
                        Text('Invite Friends & Earn More')                    
                      ],
                    ),
                ], 
              ),
            )
          ],
        ),
      ),
    );
  }
}
