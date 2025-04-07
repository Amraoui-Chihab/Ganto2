import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Ganto/Controllers/User_controller.dart';
import 'package:Ganto/User/Pages/Categories_for_user.dart';

import 'package:Ganto/User/Pages/User_profile.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';



class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late List<Widget> Pages;
  static int CurrentPageIndex = 0;
  int current_category_index = 0;
  late UserController userController ;
  // GeneralController _GeneralController = Get.put(GeneralController(),permanent: true);
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  

  @override
  Widget build(BuildContext context) {
    Pages = [

      CategoriesForUser(),
     // UserOrders(),
      UserProfile()
    ];
    return WillPopScope(
      child: Scaffold(
        
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 25,
          enableFeedback: true,
          selectedFontSize: 15.0,
          unselectedFontSize: 12.0,
          selectedLabelStyle: GoogleFonts.poppins(),
          unselectedLabelStyle: GoogleFonts.poppins(),
          items: [
           /* BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: SizedBox(
                width: 40, height: 40, // Ensure size is appropriate
                child: Image.asset('assets/home.png'),
              ),
              label: 'Home'.tr,
            ),*/
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 40, height: 40, // Ensure size is appropriate
                child: Image.asset('assets/cat.png'),
              ),
              label: 'Categories'.tr,
            ),
            /*BottomNavigationBarItem(
              icon: SizedBox(
                width: 40, height: 40, // Ensure size is appropriate
                child: Image.asset('assets/order.png'),
              ),
              label: 'Orders2'.tr,
            ),*/
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 40, height: 40, // Ensure size is appropriate
                child: Image.asset('assets/profile.png'),
              ),
              label: 'Profile'.tr,
            )
          ],
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: CurrentPageIndex,
          onTap: (int index) => setState(() {
            CurrentPageIndex = index;
          }),
        ),
        body: Pages[CurrentPageIndex],
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
