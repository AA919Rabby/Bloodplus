import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {

  var isMenuOpen = false.obs;
  var selectedIndex = (-1).obs;
  var selectedSettings=(-1).obs;


//Drawer
  toggleIcon(bool isOpen) {
    isMenuOpen.value = isOpen;
  }


//change selected color
  changeColor(int index) {
    selectedIndex.value = index;
  }


//Change settings color
changeSettingsColor(int index){
    selectedSettings.value=index;
}




//For search
  final textSearchController = TextEditingController();
  var selectedBloodQuery = ''.obs;
  var searchLocationQuery = ''.obs;

  void updateSearchQuery(String val) {
    searchLocationQuery.value = val.trim();
  }

  void updateBloodFilter(String blood) {
    selectedBloodQuery.value = blood;
  }

  Stream<QuerySnapshot> getEmergencyRequest({String? bloodGroup, String? location}) {
    Query query = FirebaseFirestore.instance.collection('emergencyBlood');

    // 1. Filter by Blood Group if selected (and not 'All')
    if (bloodGroup != null && bloodGroup.isNotEmpty && bloodGroup != 'All') {
      query = query.where('blood', isEqualTo: bloodGroup);
    }

    // 2. Filter by City (Starts With logic)
    if (location != null && location.isNotEmpty) {
      // Capitalize first letter (ga -> Ga)
      String searchKey = location[0].toUpperCase() + location.substring(1);

      query = query
          .where('city', isGreaterThanOrEqualTo: searchKey)
          .where('city', isLessThanOrEqualTo: '$searchKey\uf8ff');
    } else {
      // If NOT searching by location, we can safely order by date
      // Note: If searching by location, Firestore requires ordering by city first.
      query = query.orderBy('createdAt', descending: true);
    }

    return query.snapshots();
  }


}