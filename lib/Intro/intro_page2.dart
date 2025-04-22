import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroductionPage2 extends StatefulWidget {
  const IntroductionPage2({super.key});

  @override
  State<IntroductionPage2> createState() => _IntroductionPage2State();
}

class _IntroductionPage2State extends State<IntroductionPage2> {
  String currentlanguage = Get.locale?.languageCode == "ar"?"Arabic":"English";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height, // Ensures container matches the screen height
        width: Get.width, // Ensures container matches the screen width
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/choice.png"),
            fit: BoxFit.cover, // Ensures the image covers the entire background
          ),
        ),
        child: Stack(
          children: [
            // Circular Back Button - positioned based on language
            Positioned(
                top: 40,
                left: Get.locale?.languageCode == "ar" ? null : 20,
                right: Get.locale?.languageCode == "ar" ? 20 : null,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
            ),

            // Text Positioned on Background Image
            Container(
              margin: EdgeInsets.only(
                  top: Get.height * 0.5 / 10,
                  left: Get.width / 2.6,
                  right:
                  Get.locale?.languageCode == "en" ? 0 : Get.width / 3.7),
              child: DropdownButton<String>(
                value: currentlanguage,

                icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                dropdownColor: Colors.black,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 25),
                underline: SizedBox(), // Remove default underline
                onChanged: (String? newValue) {
                  if (newValue == "English") {
                    Get.updateLocale(Locale('en'));
                    currentlanguage = "English";
                  } else {
                    Get.updateLocale(Locale('ar'));
                    currentlanguage = "Arabic";
                  }
                  setState(() {
                    currentlanguage = newValue!;
                  });
                  //Navigator.pop(context);
                },
                items: <String>[
                  'English',
                  'Arabic',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: Get.height * 1.85 / 4,
                  left: 30,
                  right: Get.locale?.languageCode == "en" ? 0 : 30),
              child: Text(
                "YOUR BEST \nSHOPPING APP".tr,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ),

            // White Bottom Container
            Container(
              height: Get.height *
                  1.5 /
                  4, // Set the height for the bottom container
              margin: EdgeInsets.only(top: Get.height * 2.5 / 4),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0), // Shadow position
                    color: Colors.blue, // Shadow color
                    blurRadius: 250, // Shadow blur
                    blurStyle: BlurStyle.outer, // Outer shadow style
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  // Welcome Text Section
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: (Get.height * 1.5 / 4) * 0.5 / 10,
                    ),
                    height: (Get.height * 1.5 / 4) * 2 / 10,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: (Get.height * 1.5 / 4) * 1.25 / 10,
                          child: FittedBox(
                            child: Text(
                              "WELCOME BACK".tr,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: (Get.height * 1.5 / 4) * 0.75 / 10,
                          child: FittedBox(
                            child: Text(
                              "LOGIN TO YOUR ACCOUNT".tr,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // User Login Button
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/user_login");
                    },
                    child: Container(
                      height: (Get.height * 1.5 / 4) * 3 / 10,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/user_login.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  // Company Login Button
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/company_login");
                    },
                    child: Container(
                      height: (Get.height * 1.5 / 4) * 3 / 10,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/company_login.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}