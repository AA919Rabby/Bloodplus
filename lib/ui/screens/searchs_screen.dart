import 'package:blood_donate/logic/controllers/home_controller.dart';
import 'package:blood_donate/ui/screens/searchtextfield.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SearchsScreen extends StatelessWidget {
  SearchsScreen({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AllThemes.red,
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find Donor',
                style: GoogleFonts.poppins(
                  fontSize: size.height * .03,
                  fontWeight: FontWeight.w500,
                  color: AllThemes.lightBg,
                ),
              ),
              SizedBox(height: size.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Find Blood donor at nearby location.',
                    style: GoogleFonts.poppins(
                      fontSize: size.height * .02,
                      fontWeight: FontWeight.w400,
                      color: AllThemes.lightBg,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * .03),
              Searchtextfield(),
            ],
          ),
        ),
        toolbarHeight: size.height * .27,
      ),
      body: Obx(() {
        return StreamBuilder<QuerySnapshot>(
          stream: homeController.getEmergencyRequest(
            bloodGroup: homeController.selectedBloodQuery.value,
            location: homeController.searchLocationQuery.value,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AllThemes.red),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Donor Found',
                  style: GoogleFonts.poppins(
                    fontSize: size.height * .02,
                    fontWeight: FontWeight.w500,
                    color: AllThemes.lightGrey,
                  ),
                ),
              );
            }

            var docs = snapshot.data!.docs;

            return ListView.builder(
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
                  formattedDate = DateFormat('d MMM, yyyy')
                      .format((data['createdAt'] as Timestamp).toDate());
                }

                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 5),
                  child: Container(
                    padding: const EdgeInsets.all(5),
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
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AllThemes.red, width: 2),
                                ),
                                child: CircleAvatar(
                                  radius: size.height * .04,
                                  backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                                  child: imageUrl.isEmpty ? Icon(Icons.person, color: AllThemes.red) : null,
                                ),
                              ),
                              SizedBox(width: size.height * .02),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(username, style: GoogleFonts.poppins(fontSize: size.height * .02, fontWeight: FontWeight.bold, color: AllThemes.lightText)),
                                    SizedBox(height: size.height * .01),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: size.height * .018, color: AllThemes.lightText),
                                        Flexible(
                                          child: Text(' $location, $city', overflow: TextOverflow.ellipsis, maxLines: 2, style: GoogleFonts.poppins(fontSize: size.height * .015, fontWeight: FontWeight.w400, color: AllThemes.lightText)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * .01),
                                    Divider(color: AllThemes.lightGrey.withOpacity(.2), height: 10, thickness: 0.5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Amount : $bloodAmount Bag', style: GoogleFonts.poppins(fontSize: size.height * .016, fontWeight: FontWeight.bold, color: AllThemes.lightText)),
                              Row(
                                children: [
                                  Text('Published : $formattedDate', style: GoogleFonts.poppins(fontSize: size.height * .014, fontWeight: FontWeight.bold, color: AllThemes.lightGrey)),
                                  SizedBox(width: size.width * .02),
                                  Container(
                                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                                    decoration: BoxDecoration(color: AllThemes.red, borderRadius: BorderRadius.circular(15)),
                                    child: Text(bloodGroup, style: GoogleFonts.poppins(fontSize: size.height * .026, fontWeight: FontWeight.w600, color: AllThemes.lightBg)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .005),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
                                decoration: BoxDecoration(color: AllThemes.green, borderRadius: BorderRadius.circular(15)),
                                child: Icon(Icons.call, size: size.height * .025, color: AllThemes.lightBg),
                              ),
                              SizedBox(width: size.height * .01),
                              Text(number, style: GoogleFonts.poppins(fontSize: size.height * .018, fontWeight: FontWeight.w600, color: AllThemes.lightText)),
                              const Spacer(),
                              Icon(Icons.share, size: size.height * .025, color: AllThemes.lightText),
                              SizedBox(width: size.height * .016),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}