import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/models/models.dart';
import 'package:grinda/services.dart/service_handler.dart';
import 'package:grinda/utils/styles.dart';
import 'package:grinda/views/ServiceProviderTrackingScreen.dart';
import 'package:grinda/views/pages/start_kyc.dart';
import 'package:grinda/widgets/animation.dart';
import 'package:grinda/widgets/widgets.dart';

import '../controllers/controllers.dart';
import '../controllers/geolocation_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final _user = GetStorage().read('userDetails');
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
                      IconButton(onPressed: () {},icon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,size: 17,),),
                    ],
                  ),

                  Obx(() {
                      return Container(
                          child: Text('₦ ${userCurrentData.accountBalance}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),)
                      );
                    }
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      ActionIconBtnWidget(title: 'Add Money', icon: Icons.add),
                      SizedBox(width: 20,),
                      ActionIconBtnWidget(title: 'Add Money', icon: Icons.history),
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            Container(
                color: Colors.white,
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
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              color: Colors.white,
                                                              child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width * 0.46,
                                                                      child: serviceProvider.profilePics !='' && serviceProvider.profilePics !=null ? Image.network(
                                                                        serviceProvider.profilePics,
                                                                        width: MediaQuery.of(context).size.width,
                                                                      )
                                                                      :
                                                                      Text('Image not Available')
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
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
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      RatingBar(
                                                                        glowColor:
                                                                            Colors.amber,
                                                                        itemSize:
                                                                            20.0,
                                                                        glow:
                                                                            true,
                                                                        allowHalfRating:
                                                                            true,
                                                                        initialRating:
                                                                            2.5,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        itemCount:
                                                                            5,
                                                                        ratingWidget: RatingWidget(
                                                                            full: Icon(
                                                                              Icons.star,
                                                                              color: Colors.amber[600],
                                                                            ),
                                                                            half: Icon(Icons.star_half, color: Colors.amber[100]),
                                                                            empty: Icon(Icons.star_border_sharp)),
                                                                        onRatingUpdate:
                                                                            (rating) {
                                                                          print(rating);
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text("App. ${serviceProvider.distance} miles to you"),
                                                                      
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
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10) 
                  ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ServiceCategoryWidget(title: 'Laundry', imageIcon:'assets/washing.png'),
                      ServiceCategoryWidget(title: 'Repairs', imageIcon:"assets/mechanic.png"),
                      ServiceCategoryWidget(title: 'Home Service', imageIcon:"assets/bucket.png"),
                      ServiceCategoryWidget(title: 'Laundry', imageIcon:'assets/washing.png'),
                      ServiceCategoryWidget(title: 'Repairs', imageIcon:"assets/mechanic.png"),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ServiceCategoryWidget(title: 'Electricals', imageIcon:'assets/electricals.png'),
                      ServiceCategoryWidget(title: 'Deliveries', imageIcon:"assets/delivery.png"),
                      ServiceCategoryWidget(title: 'Home Service', imageIcon:"assets/bucket.png"),
                      ServiceCategoryWidget(title: 'Laundry', imageIcon:'assets/washing.png'),
                      ServiceCategoryWidget(title: 'Repairs', imageIcon:"assets/mechanic.png"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
