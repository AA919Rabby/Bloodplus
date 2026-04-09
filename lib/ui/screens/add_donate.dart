import 'package:blood_donate/logic/controllers/auth_controller.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:blood_donate/ui/widgets/blood_auth.dart';
import 'package:blood_donate/ui/widgets/custom_auth.dart';
import 'package:blood_donate/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class AddDonate extends StatelessWidget {
  AddDonate({super.key});
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Hero(
            tag: 'donate',
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back,size:size.height*.04,
                    fontWeight: FontWeight.w500,
                    color: AllThemes.lightBg),
              ),
            ),
          ),
          backgroundColor: AllThemes.red,
          title: Text('Your Blood Donation',style: GoogleFonts.poppins(
            fontSize:size.height*.03,
            fontWeight: FontWeight.w500,
            color: AllThemes.lightBg,
          ),),
        ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,top: 20,right: 10),
        child: Form(
          key: authController.donateBloodKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAuth(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Required';
                  }return null;
                },
                controller: authController.donateUsernameController,
                hintText: 'Enter your username',
            prefixIcon: Icon(Icons.person,color: AllThemes.lightText,),
            ),
            SizedBox(height: size.height*.02,),
              CustomAuth(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Required';
                  }if(value.length<11){
                    return 'Invalid number';
                  }if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Only numbers allowed';
                  }
                  return null;
                },
                controller: authController.donatePhoneController,
                hintText: 'Enter your number',
                prefixIcon: Icon(Icons.phone,color: AllThemes.lightText,),),
              SizedBox(height: size.height*.02,),
              CustomAuth(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Required';
                  }return null;
                },
                controller: authController.locationController,
                hintText: 'Enter your location',
                prefixIcon: Icon(Icons.location_on,color: AllThemes.lightText,),),
              SizedBox(height: size.height*.02,),
              Row(
                children: [
                  Expanded(child: Obx(()=>BloodAuth(
                    onTap: (){
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Required';
                      }return null;
                    },
                    controller: authController.cityController,
                    prefixIcon: Icon(Icons.location_city_outlined,color: AllThemes.lightText,),
                    suffixIcon: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          icon: Icon(Icons.arrow_drop_down_sharp,color: AllThemes.red,size: size.height*.05,),
                          focusColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          items: [
                            DropdownMenuItem(value: 'Dhaka', child: Text('Dhaka')),
                            DropdownMenuItem(value: 'Chittagong', child: Text('Chittagong')),
                            DropdownMenuItem(value: 'Rajshahi', child: Text('Rajshahi')),
                            DropdownMenuItem(value: 'Khulna', child: Text('Khulna')),
                            DropdownMenuItem(value: 'Barishal', child: Text('Barishal')),
                            DropdownMenuItem(value: 'Sylhet', child: Text('Sylhet')),
                            DropdownMenuItem(value: 'Rangpur', child: Text('Rangpur')),
                            DropdownMenuItem(value: 'Mymensingh', child: Text('Mymensingh')),
                          ],
                          onChanged: (value){
                            authController.cityAdd(value.toString());
                          }),
                    ),
                    readOnly: true,
                    hintText: authController.city.value.isEmpty?
                    'City':authController.city.value,
                  ))),
                  SizedBox(width: size.height*.02,),
                  Expanded(child: BloodAuth(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Required';
                      }if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Only numbers allowed';
                      }
                      return null;
                    },
                    controller: authController.ageController,
                    hintText: 'Age',
                    prefixIcon: Icon(Icons.calendar_month,color: AllThemes.lightText,),
                  )),
                ],
              ),
              SizedBox(height: size.height*.02,),
               Row(
                 children: [
                   Expanded(child: Obx(()=>BloodAuth(
                     onTap: (){
                     },
                     validator: (value){
                       if(value!.isEmpty){
                         return 'Required';
                       }return null;
                     },
                     controller: authController.donateBloodController,
                       prefixIcon: Icon(Icons.bloodtype_outlined,color: AllThemes.lightText,),
                       suffixIcon: DropdownButtonHideUnderline(
                         child: DropdownButton(
                             icon: Icon(Icons.arrow_drop_down_sharp,color: AllThemes.red,size: size.height*.05,),
                             focusColor: Colors.transparent,
                             borderRadius: BorderRadius.circular(8),
                             items: [
                               DropdownMenuItem(child: Text('A+'), value: 'A+'),
                               DropdownMenuItem(child: Text('A-'), value: 'A-'),
                               DropdownMenuItem(child: Text('B+'), value: 'B+'),
                               DropdownMenuItem(child: Text('B-'), value: 'B-'),
                               DropdownMenuItem(child: Text('O+'), value: 'O+'),
                               DropdownMenuItem(child: Text('O-'), value: 'O-'),
                               DropdownMenuItem(child: Text('AB+'), value: 'AB+'),
                               DropdownMenuItem(child: Text('AB-'), value: 'AB-'),
                             ],
                             onChanged: (value){
                               authController.donateBloodRequest(value.toString());
                             }),
                       ),
                       readOnly: true,
                       hintText: authController.donateBlood.value.isEmpty?
                       'Blood type':authController.donateBlood.value,
                   ))),
                   SizedBox(width: size.height*.02,),
                   Expanded(child: BloodAuth(
                     validator: (value){
                       if(value!.isEmpty){
                         return 'Required';
                       }if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                         return 'Only numbers allowed';
                       }
                       return null;
                     },
                     controller: authController.weightController,
                     hintText: 'Weight',
                   prefixIcon: Icon(Icons.monitor_weight,color: AllThemes.lightText,),
                   )),
                 ],
               ),
              SizedBox(height: size.height*.035,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Amount  :  ',style: GoogleFonts.poppins(
                    fontSize:size.height*.023,
                    fontWeight: FontWeight.w400,
                    color: AllThemes.lightText,
                  ),),
                  SizedBox(width: size.height*.007,),
                  GestureDetector(
                      onTap: (){
                        authController.decrease();
                      },
                      child: Icon(Icons.delete,color: AllThemes.red,size:  size.height*.025,)),
                  SizedBox(width: size.height*.01,),
                  Obx(()=>Text('  ${authController.amount.value} Bag  ',style: GoogleFonts.poppins(
                    fontSize:size.height*.023,
                    fontWeight: FontWeight.w500,
                    color: AllThemes.lightText,
                  ),),),
                  SizedBox(width: size.height*.01,),
                  GestureDetector(
                      onTap: (){
                        authController.increase();
                      },
                      child: Icon(Icons.add,color: AllThemes.green,size:  size.height*.025,)),
                ],
              ),
              Spacer(),
             Obx(()=> authController.isLoading.value?Center(
               child: CircularProgressIndicator(color: AllThemes.red,),
             ):CustomButton(
               onTap: (){
                 if(authController.donateBloodKey.currentState!.validate()){
                     authController.sendDonation();
                 }
               },
               color: AllThemes.red, label: 'Submit',labelColor: AllThemes.lightBg,),),
              SizedBox(height: size.height*.04,),
            ],
          ),
        ),
      ),
    );
  }
}
