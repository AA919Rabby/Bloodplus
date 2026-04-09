import 'dart:io';
import 'package:blood_donate/logic/controllers/auth_controller.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:blood_donate/ui/widgets/blood_auth.dart';
import 'package:blood_donate/ui/widgets/custom_auth.dart';
import 'package:blood_donate/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,size:size.height*.04,
              fontWeight: FontWeight.w500,
              color: AllThemes.lightBg),
        ),
        backgroundColor: AllThemes.red,
        title: Text('Edit Profile',style: GoogleFonts.poppins(
          fontSize:size.height*.03,
          fontWeight: FontWeight.w500,
          color: AllThemes.lightBg,
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Center(
            child: Form(
              key: authController.editProfileKey,
              child: Column(
                children: [
                  Obx(() {
                    return InkWell(
                      onTap: () {
                        pickImage(size);
                      },
                      child: CircleAvatar(
                        radius: size.height * .08,
                        backgroundColor: AllThemes.red,
                        backgroundImage: authController.selectedImage.value.isNotEmpty
                            ? FileImage(File(authController.selectedImage.value))
                            : null,
                        child: authController.selectedImage.value.isEmpty
                            ? Icon(
                          Icons.add_a_photo_rounded,
                          color: AllThemes.lightBg,
                          size: size.height * .1,
                        )
                            : null,
                      ),
                    );
                  }),
                  SizedBox(height: size.height*.03,),
                  CustomAuth(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Required';
                      }
                      return null;
                    },
                    controller:authController.editFirstNameController,
                    hintText: 'First name',
                  prefixIcon: Icon(Icons.drive_file_rename_outline_outlined),
                  ),
                  SizedBox(height: size.height*.03,),
                  CustomAuth(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Required';
                      }
                      return null;
                    },
                    controller: authController.editSecondNameController,
                    hintText: 'Last name',
                    prefixIcon: Icon(Icons.drive_file_rename_outline_outlined),
                  ),
                 SizedBox(height: size.height*.03,),
                  Obx(()=> BloodAuth(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Required';
                      }
                      return null;
                    },
                    onTap:(){
                      bloodGroup(size);
                    },
                    controller: authController.editBloodGroup,
                    readOnly: true,
                    hintText: authController.bloodData.value.isEmpty
                        ? 'Pick your blood group'
                        : authController.bloodData.value,
                    prefixIcon: Icon(
                      Icons.bloodtype_outlined,
                      color: AllThemes.lightText,
                    ),
                  ),),
                  SizedBox(height: size.height*.07,),
                 Obx(()=> authController.isLoading.value?Center(
                   child: CircularProgressIndicator(color: AllThemes.red,),
                 ):CustomButton(
                   onTap: (){
                     if(authController.editProfileKey.currentState!.validate()){
                       authController.editProfile();
                     }
                   },
                   color: AllThemes.red, label: 'Update',
                   labelColor: AllThemes.lightBg,
                 ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Helper widget
  bloodGroup(Size size) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(left: 25, right: 25,top: 40),
        height: size.height * .4,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AllThemes.lightBg,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
        child: Obx(()=>Column(
          children: [
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'
              ].map((bg) {
                bool isSelected = authController.bloodData.value == bg;
                return GestureDetector(
                  onTap: () {
                    authController.selectBlood(bg);
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: isSelected ?AllThemes.red:AllThemes.lightBg,
                      border: Border.all(color: AllThemes.lightGrey),
                    ),
                    child: Text(
                      bg,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: size.height * .03,
                        color: isSelected
                            ? AllThemes.lightBg
                            : AllThemes.lightText,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),),
      ),
    );
  }

//select image
pickImage(Size size){
    Get.bottomSheet(
      backgroundColor: AllThemes.lightBg,
      Container(
        padding: EdgeInsets.only(top: 15,left: 10,right: 10,bottom: 7),
        height: size.height * .13,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AllThemes.lightBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                authController.pickImage(ImageSource.gallery);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.photo_library,color: AllThemes.lightGrey,),
                  SizedBox(width: size.height*.012,),
                  Text('Gallery',style: GoogleFonts.poppins(
                    fontSize:size.height*.028,
                    fontWeight: FontWeight.w500,
                    color: AllThemes.lightGrey,
                  ),),
                ],
              ),
            ),
            SizedBox(height: size.height*.01,),
            GestureDetector(
              onTap: (){
                authController.pickImage(ImageSource.camera);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.camera_alt,color: AllThemes.lightGrey,),
                  SizedBox(width: size.height*.012,),
                  Text('Camera',style: GoogleFonts.poppins(
                      fontSize:size.height*.028,
                      fontWeight: FontWeight.w500,
                      color: AllThemes.lightGrey,
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}


}
