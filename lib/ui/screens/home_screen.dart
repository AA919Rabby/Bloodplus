import 'package:blood_donate/logic/controllers/auth_controller.dart';
import 'package:blood_donate/logic/controllers/bottomnav_controller.dart';
import 'package:blood_donate/logic/controllers/darkmode_controller.dart';
import 'package:blood_donate/logic/controllers/home_controller.dart';
import 'package:blood_donate/ui/screens/drawer_screen.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController=Get.put(HomeController());
  final authController=Get.put(AuthController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final darkController=Get.put(DarkmodeController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx((){
      final bool isDark = darkController.isDark.value;

      return Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        drawer: DrawerScreen(),
        onDrawerChanged: (value){
          if (!value) {
            homeController.changeColor(-1);
          }
          homeController.toggleIcon(value);
        },
        appBar: AppBar(
          leading: Obx(()=>InkWell(
            onTap: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                Get.back();
              } else {
                scaffoldKey.currentState!.openDrawer();
              }
            },
            child: Icon( homeController.isMenuOpen.value?Icons.close:Icons.menu,
              color: AllThemes.lightBg,size:size.height*.04,
              fontWeight: FontWeight.w500,),
          ),),
          backgroundColor: AllThemes.red,
          title: Text('Home',style: GoogleFonts.poppins(
            fontSize:size.height*.03,
            fontWeight: FontWeight.w500,
            color: AllThemes.lightBg,
          ),),
          actions: [
            GestureDetector(
            onTap: () => darkController.toggleMode(),
      child: Icon(isDark ? Icons.light_mode : Icons.dark_mode,
      color: isDark?AllThemes.lightBg:AllThemes.darkText,
      size: size.height*.04,),
            ),
            SizedBox(width: size.height*.03,)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AllThemes.lightBg,
                    boxShadow: [
                      BoxShadow(
                        color: AllThemes.lightGrey.withOpacity(0.03),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Emergency ⚠️',style: GoogleFonts.poppins(
                        fontSize:size.height*.026,
                        fontWeight: FontWeight.w500,
                        color: AllThemes.lightText,
                      ),),
                    ],
                  ),
                ),
              ),
              //Marquee text
              Container(
                height: size.height * 0.05,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AllThemes.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Marquee(
                    text: '⚠️ EMERGENCY: O- Blood heavily requested at General Hospital. Donate today! ⚠️',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .02,
                      fontWeight: FontWeight.w600,
                      color: AllThemes.red,
                    ),
                    blankSpace: 100.0,
                    velocity: 50.0,
                  ),
                ),
              ),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(stream: authController.getEmergencyRequest(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(
                          child: SizedBox(
                              height: size.height*.05,
                              width: size.width*.05,
                              child:  CircularProgressIndicator(color: AllThemes.red,)),
                        );
                      }

                      if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                        return Center(child: Text(
                          'No Emergency Request',style: GoogleFonts.poppins(
                          fontSize:size.height*.02,
                          fontWeight: FontWeight.w500,
                          color: AllThemes.lightGrey,
                        ),
                        ),);
                      }

                      var docs=snapshot.data!.docs;

                      return  ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          var data = docs[index].data() as Map<String, dynamic>;

                          String username = data['username'] ?? 'User';
                          String imageUrl = data['imageUrl'] ?? '';
                          String bloodGroup = data['blood'] ?? '--';
                          String bloodAmount = data['amount']?.toString() ?? '1';
                          String city = data['city'] ?? '--';
                          String location = data['location'] ?? '--';
                          String number = data['phone'] ?? '--';

                          String formattedDate = '--';
                          if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
                            formattedDate = DateFormat('d MMM, yyyy').format((data['createdAt'] as Timestamp).toDate());
                          }

                          return Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 5),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AllThemes.lightBg,
                                boxShadow: [
                                  BoxShadow(
                                    color: AllThemes.lightGrey.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //section 1 Image,name,date,Blood group
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AllThemes.red,width: 2),
                                          ),
                                          child: CircleAvatar(
                                            radius: size.height*.04,
                                            backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                                            child: imageUrl.isEmpty ? Icon(Icons.person, color: AllThemes.red) : null,
                                          ),
                                        ),
                                        SizedBox(width: size.height*.02,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(username,style: GoogleFonts.poppins(
                                                fontSize:size.height*.02,
                                                fontWeight: FontWeight.bold,
                                                color:AllThemes.lightText,
                                              ),),
                                              SizedBox(height: size.height*.01,),
                                              GestureDetector(
                                                onTap: (){
                                                  authController.openMap(location,city);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                      size:size.height*.018,
                                                      color: AllThemes.lightText,),
                                                    Flexible(
                                                      child: Text(' ${location}, ${city}',
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2
                                                        ,style: GoogleFonts.poppins(
                                                          fontSize:size.height*.015,
                                                          fontWeight: FontWeight.w400,
                                                          color:AllThemes.lightText,
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: size.height*.01,),
                                              Divider(
                                                color: AllThemes.lightGrey.withOpacity(.2),
                                                height: 10,
                                                thickness: 0.5,
                                              ),

                                            ],),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SizedBox(height: size.height*.01,),
                                        Text('Amount : ${bloodAmount} Bag',style: GoogleFonts.poppins(
                                          fontSize:size.height*.016,
                                          fontWeight: FontWeight.bold,
                                          color:AllThemes.lightText,
                                        ),),

                                        SizedBox(height: size.height*.007,),
                                        Row(
                                          children: [  Text('Published : ${formattedDate}',style: GoogleFonts.poppins(
                                            fontSize:size.height*.014,
                                            fontWeight: FontWeight.bold,
                                            color:AllThemes.lightGrey,
                                          ),),
                                            SizedBox(width: size.width*.02,),
                                            Container(
                                              padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
                                              decoration: BoxDecoration(
                                                color: AllThemes.red,
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Text(bloodGroup,style: GoogleFonts.poppins(
                                                fontSize:size.height*.026,
                                                fontWeight: FontWeight.w600,
                                                color:AllThemes.lightBg,
                                              ),),
                                            ),],
                                        ),
                                      ],
                                    ),
                                    //Section 3 call
                                    SizedBox(height: size.height*.005,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            authController.makeCall(number);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4),
                                            decoration: BoxDecoration(
                                              color: AllThemes.green,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Icon(Icons.call,
                                              size:size.height*.025,
                                              color: AllThemes.lightBg,),
                                          ),
                                        ),
                                        SizedBox(width: size.height*.01,),
                                        Text( number,style: GoogleFonts.poppins(
                                          fontSize:size.height*.018,
                                          fontWeight: FontWeight.w600,
                                          color: AllThemes.lightText,
                                        ),),
                                        const Spacer(),
                                        Icon(Icons.share,
                                          size:size.height*.025,
                                          color: AllThemes.lightText,),
                                        SizedBox(width: size.height*.016,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },


                      );

                    }),

              ),

            ],
          ),
        ),
      );
    });
  }
  //Blood related info
bloodInfo(Size size){
    Get.dialog(
      Dialog(
        backgroundColor: AllThemes.lightBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 7),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             Stack(
               alignment: Alignment.center,
               children: [
                 Opacity(
                   opacity: 0.2,
                   child: Image.asset('assets/images/bd.jpg',height: size.height*.3,
                     width: size.width*.3,fit: BoxFit.contain,),
                 ),
                Column(
                  children: [
                    Text('General Eligibility',style: GoogleFonts.poppins(
                      fontSize:size.height*.03,
                      fontWeight: FontWeight.w500,
                      color: AllThemes.lightText,
                    ),),
                    SizedBox(height: size.height*.005,),
                     Divider(
                      color: AllThemes.lightGrey,
                      indent: 30,
                      endIndent: 30,
                    ),
                    SizedBox(height: size.height*.005,),
                    Text('Requirements\n'
                        '• Age: 18 - 65 years old.\n'
                        '• Weight: At least 50 kg (110 lbs).\n'
                        '• Hemoglobin: Minimum 12.5 g/dL.\n'
                        '• Interval: 3-4 months since last donation.',style: GoogleFonts.poppins(
                      fontSize:size.height*.025,
                      fontWeight: FontWeight.w400,
                      color: AllThemes.lightText,
                    ),),
                  ],
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
