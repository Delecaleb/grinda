import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/services.dart/service_handler.dart';
import 'package:grinda/utils/styles.dart';
import 'package:grinda/views/pages/complete_kyc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final serviceController = ServiceHandler();
class StartKycController extends GetxController{
   
   var _photoFile = Rxn<File>();
   var showNext = Rx(false);
   var isUploading = Rx(false);
   var hasUploaded = Rx(false);
   pickImage()async{
    final file = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front, maxHeight: 1000, maxWidth: 1000);
    if(file ==null) return;
    final fileSourcePath = File(file.path);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: fileSourcePath.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ]
      );
    _photoFile.value = croppedFile !=null ? File(croppedFile.path) : null;
  }  
}

class StartKyc extends StatelessWidget {

  StartKyc({Key? key}) : super(key: key);
  StartKycController startKycController = Get.put(StartKycController());
  
  final userData = GetStorage().read('userDetails');
  
  

  uploadPhoto(File _editedImg)async{
  serviceController.UploadDpFile(_editedImg, userData['email']).then((response){
    Get.snackbar('Message', response['msg']);

      if (response['status']=='done' && userData != null && userData is Map<String, dynamic>) {
        // Check if the 'userDetails' data is a Map and not null
        startKycController.hasUploaded.value = true;
        userData['profilePicture'] = response['img_file']; // Update the profilePics parameter
        GetStorage().write('userDetails', userData); // Save the updated data back to the storage
      }
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete KYC'),
      ), 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 25,),
              Text("Face Identification", style: titleHeader,),
              SizedBox(height: 10,),
              Text("Upload your picture photograph to allow services providers connect with you easily", style: subTitle,),
              SizedBox(height: 20,),
              //face id image
              userData['profilePicture'] !=null && userData['profilePicture'] !='' ?
              // Obx(() {
              //     return 
                  Center(
                    child: Column(
                      
                      children: [
                        Text('My Picture'),
                        SizedBox(height:20),
                        CircleAvatar(
                          radius: 82,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child:CachedNetworkImage(
                              imageUrl:"${userData['profilePicture']}",
                              width:160.0,
                              height:160.0,
                              ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        TextButton(
                          onPressed: ()=>Get.to(()=>CompleteKyc()), child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 20),),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: Size.fromHeight(50),
                            
                          ),
                          )
                      ],
                    ),
                  )
                // }
              // )
              :
              //show default image if user has not uploaded image
              Obx(() {
                  return Column(
                    children: [
                      Container(
                        child: startKycController._photoFile.value !=null ?
                        Image.file( 
                          startKycController._photoFile.value!,
                          width:150,
                          height:150,
                          ) : 
                          Image.asset(
                            'assets/user_icon.jpg',
                            width:150,
                            height:150,
                            ),
                        ),

                        SizedBox(height: 20,),

                        !startKycController.showNext.value ? 
                        TextButton.icon(onPressed: ()=>startKycController.pickImage(), icon: const Icon(Icons.camera_alt_outlined), label: const Text('Take Picture')):Text(''),
                        
                        // show upload button or next button
                         startKycController.hasUploaded.value ? 
                         Column(
                           children: [
                            Text('File Uploaded'),
                            TextButton(onPressed: ()=>Get.to(()=>CompleteKyc()), child: Text('Continue KYC')),
                           ],
                         )
                         :
                        Container(
                        child: startKycController._photoFile.value !=null ?
                          TextButton(onPressed: (){
                                startKycController.isUploading.value = true;
                                uploadPhoto(startKycController._photoFile.value!); 
                                startKycController.showNext.value = true;
                                },
                                child:  startKycController.isUploading.value ? Text('Uploading. Please Wait!') : const Text('Save Picture')
                                )
                            :
                          Text(''),
                        )
                    ],
                  );
                }
              ),      
            ],
          ),
        ),
      ),
    );
  }
}