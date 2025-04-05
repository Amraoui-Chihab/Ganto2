
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'TeacherHome.dart';
import 'TeacherProfile.dart';
class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int currentIndex = 0;
  List<Widget> Pages = [TeacherHome(),TeacherProfile()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

 // TeacherController _teacherController =Get.find<TeacherController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            elevation: 25,
            enableFeedback: true,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            selectedFontSize: 15.0,
            unselectedFontSize: 12.0,
            selectedLabelStyle: GoogleFonts.poppins(),
            unselectedLabelStyle: GoogleFonts.poppins(),
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            onTap: (int index) {
              setState(() {
                currentIndex = index;
                print(currentIndex);
              });
            },
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SizedBox(
                  width: 40, height: 40, // Ensure size is appropriate
                  child: Image.asset('assets/home.png'),
                ),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: SizedBox(
                  width: 40, height: 40, // Ensure size is appropriate
                  child: Image.asset('assets/profile.png'),
                ),
                label: 'Profile',
              ),
            ]),
        /* appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          "SchoolDashboard",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),*/
        backgroundColor: Colors.white,
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
