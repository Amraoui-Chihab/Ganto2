import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/Company_controller.dart';
import '../Models/Company.dart';
import '../main.dart';

class Companyloginemail extends StatefulWidget {
  const Companyloginemail({super.key});

  @override
  State<Companyloginemail> createState() => _CompanyloginemailState();
}

class _CompanyloginemailState extends State<Companyloginemail> {
  String currentLanguage = Get.locale?.languageCode == "ar"?"Arabic":"English";

  bool showpassword = false;

  bool isLoading = false;
  TextEditingController EmailController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents default keyboard behavior
      body: KeyboardAvoider(
        autoScroll: true, // Enables auto-scrolling when keyboard appears
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/company.png"),
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
                // Language Dropdown
                Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.3,
                  right: screenWidth * 0.3,
                  child: Center(
                    child: DropdownButton<String>(
                      value: currentLanguage,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      dropdownColor: Colors.black,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
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
                ),

                // Title
                Positioned(
                  top: screenHeight * 0.3,
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
                        fontSize: screenWidth * 0.08, // Responsive text size
                      ),
                    ),
                  ),
                ),

                // Bottom White Container with form
                Positioned(
                  top: screenHeight * 0.65,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.35,
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: Colors.blue,
                          blurRadius: 150,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "COMPANY LOGIN".tr,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    screenWidth * 0.06, // Responsive text size
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),

                            // Form Fields

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your email';
                                            } else if (!RegExp(
                                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                                .hasMatch(value)) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                          cursorColor: Colors.blue,
                                          decoration: InputDecoration(
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.black),
                                            hintText: "Please Enter UserName",
                                            border: InputBorder.none,
                                          ),
                                          controller: EmailController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your password';
                                            } else if (value.length < 6) {
                                              return 'Password must be at least 6 characters long';
                                            }
                                            return null;
                                          },
                                          cursorColor: Colors.blue,
                                          decoration: InputDecoration(
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.black),
                                            hintText: "Please Enter Password",
                                            border: InputBorder.none,
                                          ),
                                          controller: PasswordController,
                                          obscureText: !showpassword,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () => setState(() {
                                                showpassword = !showpassword;
                                              }),
                                          icon: Icon(
                                            !showpassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.blue,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),

                            // Buttons
                            ElevatedButton(
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  FocusScope.of(context).requestFocus(
                                      FocusNode()); // Remove focus from text fields
                                  await Future.delayed(Duration(
                                      milliseconds:
                                          100)); // Give time to close the keyboard
                                  await CompanyLoginWithEmail(
                                      EmailController.text,
                                      PasswordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child:
                                  Text("Login", style: GoogleFonts.poppins()),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      key: _key,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> CompanyLoginWithEmail(String Email, String Password) async {
    try {
      Get.dialog(
          Center(
            child: Container(
              padding: EdgeInsets.all(20), // Add padding for spacing
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Wraps content properly
                children: [
                  Lottie.asset('assets/loading.json',
                      width: 100, height: 100, fit: BoxFit.fitHeight),
                  SizedBox(width: 10), // Add spacing between animation and text
                  Text(
                    "Please Wait ...",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.blue),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          barrierDismissible: false, // Prevents dismissing the dialog
          useSafeArea: true);

      final url =
          Uri.parse('https://ganto-app.online/public/api/company/login/email');

      var response = await http.post(url,
          body: {"company_email": Email, "company_password": Password});

      // Check the response status

      Get.back();

      if (response.statusCode == 200) {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 7),
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.green,
            title: 'Notification',
            message: "Login Successfully",
            contentType: ContentType.success,
          ),
        );

        // Successfully received a response
        var data = jsonDecode(response.body);
        Company company = Company.fromJson(data["company"]);
        print(company.toJson());

        if (Get.isRegistered<CompanyController>()) {
          // If controller already exists, update the existing school
          print("registred company");
          Get.find<CompanyController>().updateCompany(company);
        } else {
          // If controller does not exist, create and register it
          Get.put(CompanyController()..updateCompany(company), permanent: true);
        }
        /*Get.delete<CompanyController>();
      Get.put(CompanyController(company),permanent: true);*/

        await prefs.setString("type", "company");
        String companyJson =
            jsonEncode(company.toJson()); // Proper JSON encoding
        await prefs.setString("company", companyJson);
        await prefs.setString("token", data["token"]);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Get.offNamed("/Company_Home");
      } else if (response.statusCode == 300) {
        Get.toNamed("/PendingCompany");
      } else if (response.statusCode == 350) {
        Get.toNamed("/RejectedCompany");
      } else {
        var error = jsonDecode(response.body);

        /* Get.snackbar("Alert".tr, error["message"],
            backgroundColor: Colors.red, duration: Duration(seconds: 7));*/

        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: error["message"],
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      Get.back();

      var snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: "Connection Error !",
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      /*Get.snackbar("Alert".tr, "Connection Error",
          backgroundColor: Colors.red, duration: Duration(seconds: 7));*/
    }
  }
}
