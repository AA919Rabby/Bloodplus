import 'package:blood_donate/logic/controllers/auth_controller.dart';
import 'package:blood_donate/logic/controllers/home_controller.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
   final homeController=Get.find<HomeController>();
   final authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AllThemes.red,
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: size.height * .03,
            fontWeight: FontWeight.w500,
            color: AllThemes.lightBg,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
          child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeOutQuart,
              builder: (context,value,child){
                return Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Transform.translate(
                    offset: Offset(0, -50 * (1 - value)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text(
                              'General',
                              style: GoogleFonts.poppins(
                                fontSize: size.height * .025,
                                fontWeight: FontWeight.w500,
                                color: AllThemes.lightText,
                              ),
                            ),
                          ),
                          Obx(()=>buildList(
                            title:'Share',
                            leadingIcon: Icons.share,
                            size: size,
                            isSelected: homeController.selectedSettings.value==0,
                            onTap: (){
                              homeController.changeSettingsColor(0);
                            },
                          ),),
                         Obx(()=> buildList(
                           title:'Rate Us',
                           leadingIcon: Icons.star,
                           size: size,
                           isSelected: homeController.selectedSettings.value==1,
                           onTap: (){
                             homeController.changeSettingsColor(1);
                           },
                         ),),
                         Obx(()=> buildList(
                           title:'About Us',
                           leadingIcon: Icons.info,
                           size: size,
                           isSelected: homeController.selectedSettings.value==2,
                           onTap: (){
                             homeController.changeSettingsColor(2);
                           },
                         ),),
                          Padding(
                            padding: const EdgeInsets.only(left: 7,top: 5),
                            child: Text(
                              'Account',
                              style: GoogleFonts.poppins(
                                fontSize: size.height * .025,
                                fontWeight: FontWeight.w500,
                                color: AllThemes.lightText,
                              ),
                            ),
                          ),
                          //Logout
                         Obx(()=> buildLogoutList(title: 'Logout',
                             leadingIcon: Icons.logout,
                             size: size,
                             isSelected: homeController.selectedSettings.value==3,
                             onTap: (){
                              homeController.changeSettingsColor(3);
                              buildAccountLogout(size, 'Logout?',
                                  'After logout you can login again.');
                             }),),
                           Obx(()=> buildLogoutList(title: 'Delete',
                               leadingIcon: Icons.delete,
                               size: size,
                               isSelected: homeController.selectedSettings.value==4,
                               onTap: (){
                               homeController.changeSettingsColor(4);
                               buildAccountDelete(size, 'Delete Account?',
                                   'After delete all data will be removed.');
                               }),),
                        ],
                      )
                    ,
                  )
                );
              }),
        ),
      ),
    );
  }

  //Helper widget
  buildList({
    required String title,
    required IconData leadingIcon,
    // required IconData? trailingIcon,
    required Size size,
    required VoidCallback? onTap,
    required bool isSelected,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isSelected?AllThemes.red:AllThemes.lightBg,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: isSelected?AllThemes.lightBg:AllThemes.lightText,
            fontSize: size.height * .025,
            fontWeight: FontWeight.w400,
          ),
        ),
        // trailing: Icon(trailingIcon),
        leading: Icon(
          leadingIcon,
          size: size.height * .032,
          color: isSelected?AllThemes.lightBg:AllThemes.lightText,
        ),
      ),
    );
  }

  //Settings item list
  buildLogoutList({
    required String title,
    required IconData leadingIcon,
    // required IconData? trailingIcon,
    required Size size,
    required VoidCallback? onTap,
    required bool isSelected,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isSelected?AllThemes.red:AllThemes.lightBg,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: isSelected?AllThemes.lightBg:AllThemes.lightText,
            fontSize: size.height * .025,
            fontWeight: FontWeight.w400,
          ),
        ),
        // trailing: Icon(trailingIcon),
        leading: Icon(
          leadingIcon,
          size: size.height * .032,
          color: isSelected?AllThemes.lightBg:AllThemes.red,
        ),
      ),
    );
  }

  //account helper widget
buildAccountLogout(Size size,String title,String subTitle){
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal:size.width*.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AllThemes.lightBg,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,style: GoogleFonts.poppins(
                fontSize:size.height*.033,
                fontWeight: FontWeight.w500,
                color: AllThemes.lightText
              ),),
              SizedBox(height: size.height*.007,),
              Text(subTitle,style: GoogleFonts.poppins(
                  fontSize:size.height*.015,
                  fontWeight: FontWeight.w400,
                  color: AllThemes.lightGrey,
              ),),
              SizedBox(height: size.height*.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 3,bottom: 3,left: 18,right: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text('No',style: GoogleFonts.poppins(
                            fontSize:size.height*.027,
                            fontWeight: FontWeight.w500,
                            color: AllThemes.lightText,
                        ),),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: AllThemes.red,
                    elevation: 2,
                    child: GestureDetector(
                      onTap: (){
                       authController.logoutUSer();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 3,bottom: 3,left: 18,right: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AllThemes.red,
                        ),
                        child: Text('Yes',style: GoogleFonts.poppins(
                            fontSize:size.height*.027,
                            fontWeight: FontWeight.w500,
                            color: AllThemes.lightBg,
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
}


   //account helper widget
   buildAccountDelete(Size size,String title,String subTitle){
     Get.dialog(
       barrierDismissible: false,
       Dialog(
         insetPadding: EdgeInsets.symmetric(horizontal:size.width*.1),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(15),
         ),
         backgroundColor: AllThemes.lightBg,
         child: Padding(
           padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 10),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text(title,style: GoogleFonts.poppins(
                   fontSize:size.height*.033,
                   fontWeight: FontWeight.w500,
                   color: AllThemes.lightText
               ),),
               SizedBox(height: size.height*.007,),
               Text(subTitle,style: GoogleFonts.poppins(
                 fontSize:size.height*.015,
                 fontWeight: FontWeight.w400,
                 color: AllThemes.lightGrey,
               ),),
               SizedBox(height: size.height*.05,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15),
                     ),
                     child: GestureDetector(
                       onTap: (){
                         Get.back();
                       },
                       child: Container(
                         padding: EdgeInsets.only(top: 3,bottom: 3,left: 18,right: 18),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                         ),
                         child: Text('No',style: GoogleFonts.poppins(
                           fontSize:size.height*.027,
                           fontWeight: FontWeight.w500,
                           color: AllThemes.lightText,
                         ),),
                       ),
                     ),
                   ),
                   Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15),
                     ),
                     color: AllThemes.red,
                     elevation: 2,
                     child: GestureDetector(
                       onTap: (){
                         authController.deleteUser();
                       },
                       child: Container(
                         padding: EdgeInsets.only(top: 3,bottom: 3,left: 18,right: 18),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: AllThemes.red,
                         ),
                         child: Text('Yes',style: GoogleFonts.poppins(
                           fontSize:size.height*.027,
                           fontWeight: FontWeight.w500,
                           color: AllThemes.lightBg,
                         ),),
                       ),
                     ),
                   ),
                 ],
               ),
             ],
           ),
         ),
       ),
     );
   }



}
