
import 'package:flutter/material.dart';
import 'package:ganto_shop/Company/Pages/CompanyProfile.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'Pages/CompanyFirstHome.dart';

class Companyhome extends StatefulWidget {
  const Companyhome({super.key});

  @override
  State<Companyhome> createState() => _CompanyhomeState();
}

class _CompanyhomeState extends State<Companyhome> {
  static int current_index = 0;

  //CompanyController companyController = Get.find<CompanyController>();
 // GeneralController _GeneralController = Get.put(GeneralController(),permanent: true);

  @override
  void initState() {
    super.initState();
  }
  
  final List<Widget> Pages = [
    Companyfirsthome(),

    Companyprofile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 25,
        enableFeedback: true,
        selectedFontSize: 15.0,
        unselectedFontSize: 12.0,
        selectedLabelStyle: GoogleFonts.poppins(),
        unselectedLabelStyle: GoogleFonts.poppins(),
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: SizedBox(
              width: 40, height: 40, // Ensure size is appropriate
              child: Image.asset('assets/home.png'),
            ),
            label: 'Home'.tr,
          ),
          /*BottomNavigationBarItem(
            icon: SizedBox(
              width: 40, height: 40, // Ensure size is appropriate
              child: Image.asset('assets/cat.png'),
            ),
            label: 'Products2'.tr,
          ),
          BottomNavigationBarItem(
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
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: current_index,
        onTap: (int index) {
          setState(() {
            current_index = index;
          });
        },
      ),
      body: /*IndexedStack(
        
        children: Pages,
        index: current_index,
      )*/
          Pages[current_index],
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final Widget child;
  KeepAlivePage(this.child);

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Keep state alive
    
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
