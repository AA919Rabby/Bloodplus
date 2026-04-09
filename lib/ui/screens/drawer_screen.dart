import 'package:blood_donate/logic/controllers/auth_controller.dart';
import 'package:blood_donate/logic/controllers/home_controller.dart';
import 'package:blood_donate/ui/screens/edit_profile.dart';
import 'package:blood_donate/ui/screens/emergency.dart';
import 'package:blood_donate/ui/screens/last_donate.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});
  final homeController=Get.find<HomeController>();
  final authController=Get.put(AuthController());
  //final authController=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: AllThemes.lightBg,
      elevation: 5,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: [
                StreamBuilder(
                    stream: authController.getUserData(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return  CircularProgressIndicator(color: AllThemes.red,);
                      }
                      String username = 'User';
                      String imageUrl = '';
                      String bloodGroup = '';
                      if(snapshot.hasData && snapshot.data!.exists){
                        var data=snapshot.data!.data() as Map<String,dynamic>;
                         username=data['username']?? 'User';
                         imageUrl=data['imageUrl']?? '';
                         bloodGroup=data['blood']?? '';
                      }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                SizedBox(height: size.height * .01),
                                Container(
                                  height: size.height * .35,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AllThemes.lightGrey.withOpacity(0.03),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                    color: AllThemes.red,
                                    borderRadius: BorderRadius.circular(15),
                                    image: imageUrl != null && imageUrl.isNotEmpty
                                        ? DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                  ),
                                  child: imageUrl == null || imageUrl.isEmpty
                                      ? Center(
                                    child: Icon(
                                      Icons.person,
                                      color: AllThemes.lightBg,
                                      size: size.height * .10,
                                    ),
                                  )
                                      : null,
                                ),

                                Container(
                                  height: size.height * .25,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        AllThemes.lightText,
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          username,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                            fontSize: size.height * .026,
                                            fontWeight: FontWeight.w500,
                                            color: AllThemes.lightBg,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        bloodGroup,
                                        style: GoogleFonts.poppins(
                                          fontSize: size.height * .028,
                                          fontWeight: FontWeight.bold,
                                          color: AllThemes.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ],
                        );

                    }),

                SizedBox(height: size.height * .01),
                Obx(()=>buildList(
                  title: 'Edit Profile',
                  leadingIcon: Icons.edit,
                  isSelected: homeController.selectedIndex.value==0,
                  size: size,
                  onTap: (){
                    homeController.changeColor(0);
                    Get.to(()=>EditProfile(),transition: Transition.fadeIn,duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn
                    );
                  },
                ),),
                Obx(()=>buildList(
                  title: 'Emergency',
                  leadingIcon: Icons.local_hospital,
                  size: size,
                  isSelected: homeController.selectedIndex.value==1,
                  onTap: (){
                    homeController.changeColor(1);
                    Get.to(()=>Emergency(),transition: Transition.fadeIn,duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn
                    );
                  },
                ),),
                Obx(()=>buildList(
                  title: 'Top Donator',
                  leadingIcon: Icons.volunteer_activism,
                  size: size,
                  isSelected: homeController.selectedIndex.value==2,
                  onTap: (){
                    homeController.changeColor(2);

                  },
                ),),
              Obx(()=>  buildList(
                title: 'Last Donate',
                leadingIcon: Icons.bloodtype,
                size: size,
                isSelected: homeController.selectedIndex.value==3,
                onTap: (){
                  homeController.changeColor(3);
                  Get.to(()=>LastDonate(),transition: Transition.fadeIn,duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn
                  );
                },
              ),),
              ],
            ),
          ),
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
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15),
     ),
      color: isSelected?AllThemes.red:AllThemes.lightBg,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: isSelected?AllThemes.lightBg:AllThemes.lightText,
            fontSize: size.height*.025,
            fontWeight: FontWeight.w400,
          ),
        ),

        leading: Icon(
          leadingIcon,
          size: size.height*.032,
          color: isSelected?AllThemes.lightBg:AllThemes.lightText,
        ),
      ),
    );
  }


}
