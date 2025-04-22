import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController email_controller = new TextEditingController();
  TextEditingController email_password_controller = new TextEditingController();
  String _completePhoneNumber = '';
  TextEditingController phone_password_controller = new TextEditingController();
  GlobalKey<FormState> _form_key_phone = GlobalKey();
  GlobalKey<FormState> _form_key_email = GlobalKey();
  String currentLanguage = Get.locale?.languageCode == "ar"?"Arabic":"English";



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/user.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
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
                Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth / 3,
                  child: DropdownButton<String>(
                    value: currentLanguage,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    dropdownColor: Colors.black,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    underline: const SizedBox(),
                    onChanged: (String? newValue) {
                      if (newValue == "English") {
                        Get.updateLocale(const Locale('en'));
                      } else {
                        Get.updateLocale(const Locale('ar'));
                      }
                      setState(() {
                        currentLanguage = newValue!;
                      });
                    },
                    items: <String>['English', 'Arabic']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                Positioned(
                  top: screenHeight * 0.35,
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "YOUR BEST \nSHOPPING APP".tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),

                // White Bottom Container
                Positioned(
                  top: screenHeight * 0.6,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.blue,
                          blurRadius: 250,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "USER LOGIN".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        Text(
                          "LOGIN TO YOUR ACCOUNT".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),

                        // Login With Email
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/UserLoginEmail");
                          },
                          child: Container(
                            width: double.infinity,
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/emaillogin.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Login With Email",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Login With Phone
                        GestureDetector(
                          onTap: () {
                            // Get.toNamed("/user_login");
                            Get.toNamed("/userloginphone");
                          },
                          child: Container(
                            width: double.infinity,
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/phonelogin.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Login With Phone",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Signup Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account yet?",
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            SizedBox(width: 10,),
                            InkWell(

                              onTap: () {
                                Get.bottomSheet(

                                  Container(
                                   // height: 300,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Choose an Option",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed("/user_singup_email");
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: screenHeight * 0.08,
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage("assets/emaillogin.png"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Signup With Email",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {
                                            // Get.toNamed("/user_login");
                                            Get.toNamed("/user_singup_phone");
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: screenHeight * 0.08,
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage("assets/phonelogin.png"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Signup With Phone",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                      ],
                                    ),
                                  ),
                                  isDismissible: true,
                                );
                              },

                              child: Text(
                                "Signup",
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
