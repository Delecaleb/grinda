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
class ProveOfAddressController extends GetxController{
   
   var _photoFile = Rxn<File>();
   var showNext = Rx(false);
   var isUploading = Rx(false);
   var hasUploaded = Rx(false);
   pickImage()async{
    final file = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
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

class ProveOfAddress extends StatelessWidget {

  ProveOfAddress({Key? key}) : super(key: key);
  ProveOfAddressController proveOfAddressController = Get.put(ProveOfAddressController());
  
  final userData = GetStorage().read('userDetails');  

  uploadPhoto(File _editedImg)async{
  serviceController.UploadProveOfAddress(_editedImg, userData['email']).then((response){
    Get.snackbar('Message', response['msg']);

      if (response['status']=='done' && userData != null && userData is Map<String, dynamic>) {
        // Check if the 'userDetails' data is a Map and not null
        proveOfAddressController.hasUploaded.value = true;
        userData['proveOfAddress'] = response['img_file']; // Update the profilePics parameter
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
              Text("Prove of Address", style: titleHeader,),
              SizedBox(height: 10,),
              Text("Upload your Electricity Bill or other documents containing your home address", style: subTitle,),
              SizedBox(height: 20,),
              //face id image
              userData['proveOfAddress'] !=null && userData['proveOfAddress'] !='' ?
              // Obx(() {
              //     return 
                  Center(
                    child: Column(
                      
                      children: [
                        Text('Location Document'),
                        SizedBox(height:20),

                        CachedNetworkImage(
                          imageUrl:"${userData['proveOfAddress']}",
                          height:350.0,
                          ),
                        SizedBox(height: 50,),
                        
                        TextButton(
                          onPressed: ()=>Get.to(()=>CompleteKyc()), 
                          child: Text('Continue KYC', style: TextStyle(color: Colors.white,),),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                            )
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
                        child: proveOfAddressController._photoFile.value !=null ?
                        Image.file( 
                          proveOfAddressController._photoFile.value!,
                          
                          height:350,
                          ) : 
                          Image.asset(
                            'assets/user_icon.jpg',
                            height:350,
                            ),
                        ),

                        SizedBox(height: 20,),

                        !proveOfAddressController.showNext.value ? 
                        TextButton.icon(onPressed: ()=>proveOfAddressController.pickImage(), icon: const Icon(Icons.file_upload_outlined), label: const Text('Select FIle')):Text(''),
                        
                        // show upload button or next button
                         proveOfAddressController.hasUploaded.value ? 
                         Column(
                           children: [
                            Text('File Uploaded'),
                            TextButton(
                              onPressed: ()=>Get.to(()=>CompleteKyc()), 
                              child: Text('Continue KYC', style: TextStyle(color: Colors.white),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                                )
                              ),
                              ),
                           ],
                         )
                         :
                        Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: proveOfAddressController._photoFile.value !=null ?
                          TextButton(
                                onPressed: (){
                                proveOfAddressController.isUploading.value = true;
                                uploadPhoto(proveOfAddressController._photoFile.value!); 
                                proveOfAddressController.showNext.value = true;
                                },
                                child:  proveOfAddressController.isUploading.value ? Text('Uploading. Please Wait!') : const Text('Continue Upload File', style: TextStyle(color: Colors.white),),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.all(15)
                                ),                                
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