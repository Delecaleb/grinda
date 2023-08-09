import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/models/models.dart';
import 'package:grinda/service_providers_rating.dart';
import 'package:grinda/services.dart/service_handler.dart';
import 'package:grinda/utils/styles.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class ServiceProviderTrackingScreen extends StatefulWidget {
  final ServiceProviderModel serviceProvider;

  ServiceProviderTrackingScreen({required this.serviceProvider, Key? key}) : super(key: key);

  @override
  _ServiceProviderTrackingScreenState createState() => _ServiceProviderTrackingScreenState();
}

class _ServiceProviderTrackingScreenState extends State<ServiceProviderTrackingScreen> {
  bool approval = false;
  bool declined = false;
  late Timer timer;
  late Future getStatus;

  final box = GetStorage().read('userDetails');

  void getApprovalStatus()async{
      ServiceHandler().checkAcceptance(box['email'], widget.serviceProvider.email).then((response){
        if(response['message'].toLowerCase()=='accepted'){
          
          setState(() {
            approval=true;
          });
        }
        else if(response['message'].toLowerCase()=='completed'){
          timer.cancel();
          Get.to(()=>UserRating(serviceProvider: widget.serviceProvider, userId: box['email'],));
        }
        else if(response['message'].toLowerCase()=='declined'){
          timer.cancel();
          setState(() {
            declined=true;
          });
        }
      });
  }
  
  late IO.Socket socket;
  @override
  void initState() {
    print('object');
    socket = IO.io('http://grindas.smart-school.online', IO.OptionBuilder().setTransports(['websocket']).setQuery({'email':box['email']}).build());

    super.initState();

    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      getApprovalStatus();
    });

    socket.connect();
    connectToServer();
  }
  // Image.asset('assets/rider.gif'),
String address='';
String eta='';
  void connectToServer(){
    
    socket.onConnect((data){
      print('connection established');


    });
    socket.onConnectError((data) => print('dl Error occured $data'));

    socket.on('update-location',(locationData){
      print(locationData);
      setState(() {
        address = locationData['address'];
        eta = locationData['eta'];
      });
    });

   }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 245, 245, 245)
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                    children: [
                        
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.serviceProvider.profilePics,
                              height: 90,
                              width: 90,
                              ),
                            
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.serviceProvider.firstName} ${widget.serviceProvider.lastName}", style: titleHeader,),
                            SizedBox(height: 10,),
                            Text("${widget.serviceProvider.description}")
                          ],
                        ),
                    ],
                  ),
              ),
              Stepper(
                controlsBuilder: (ctx, details) {
                          return Container();
                        },
               steps: <Step>[
                    Step(
                      state: StepState.complete,
                      title:  ListTile(
                        minLeadingWidth: 20,
                        horizontalTitleGap: 0,
                        // leading: Icon(Icons.note_alt_rounded),
                        title: Text('Notification Sent'),
                        subtitle: Text('Your service provider has been notified'),
                        ),
                      content: Container(
                      ),
                    ),
                    Step(
                      state: approval? StepState.complete : StepState.editing,
                      title:  ListTile(
                        // leading: Icon(Icons.note_alt_rounded),
                        title: Text('Approval'),
                        subtitle: approval ? Text('Offer Approved') : Text('Waiting for approval'),
                        ),
                      content: Container(
                        
                      ),
                    ),
                  ],
                ),
                approval ? 
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(255, 245, 245, 245)
                  ),
                  child:ListTile(
                    leading: Image.asset('assets/rider.gif'),
                    title: Text('Current Location: $address'),
                    subtitle: Text('$eta mins to get to you'),
                  )
                ) : Container(
                    child: Center(child: CircularProgressIndicator()),
                ),
                declined ? Container(
                  child: ListTile(
                    leading: Icon(Icons.cancel, color: Colors.red, size: 50,),
                    title: Text('OFFER CANCELED', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  ),
                ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
