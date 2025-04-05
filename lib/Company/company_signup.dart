import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanySignup extends StatefulWidget {
  const CompanySignup({super.key});

  @override
  State<CompanySignup> createState() => _CompanySignupState();
}

class _CompanySignupState extends State<CompanySignup> {
  String currentlanguage = "English";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width * 9 / 10,
        margin: EdgeInsets.only(bottom: 20),

        // height: MediaQuery.of(context).size.height*10/100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have a Company ?".tr,
              style: GoogleFonts.poppins(),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Get.toNamed("/company_login");
              },
              child: Text(
                "Login".tr,
                style: GoogleFonts.poppins(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          DropdownButton<String>(
            value: currentlanguage,

            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
            dropdownColor: Colors.white,
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
            underline: SizedBox(), // Remove default underline
            onChanged: (String? newValue) {
              currentlanguage = newValue!;
              if (newValue == "English") {
                Get.updateLocale(Locale('en'));
              } else {
                Get.updateLocale(Locale('ar'));
              }

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
          )
        ],
        backgroundColor: const Color.fromARGB(255, 76, 166, 240),
        title: Text(
          'Signup_company'.tr,
          overflow: TextOverflow.fade,
          style: GoogleFonts.poppins(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Image.asset("assets/company2.png"),
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: MediaQuery.of(context).size.height * 40 / 100,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 9 / 10,
              height: MediaQuery.of(context).size.height * 8 / 100,
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed("/CompanySignupEmail");
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      Colors.white, // Set the background color here
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                        10), // Makes the button rectangular
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/mail.png", height: 20),
                    SizedBox(
                        width:
                            8), // Optional: Add spacing between icon and text
                    Text(
                      "Signup with Email".tr,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors
                              .black), // Change text color to contrast the background
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 9 / 10,
              height: MediaQuery.of(context).size.height * 8 / 100,
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed("/CompanySignupPhone");
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      Colors.white, // Set the background color here
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                        10), // Makes the button rectangular
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/phone.png", height: 20),
                    SizedBox(
                        width:
                            8), // Optional: Add spacing between icon and text
                    Text(
                      'Signup with Phone'.tr,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors
                              .black), // Change text color to contrast the background
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
