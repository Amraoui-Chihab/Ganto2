
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:http/http.dart' as http;

import '../Controllers/User_controller.dart';
import '../Models/User.dart';
import '../main.dart';

class UserLoginEmail extends StatefulWidget {
  const UserLoginEmail({super.key});

  @override
  State<UserLoginEmail> createState() => _UserLoginEmailState();
}

class _UserLoginEmailState extends State<UserLoginEmail> {
  String currentLanguage = Get.locale?.languageCode == "ar"?"Arabic":"English";

  bool showpassword = false;

 // TextEditingController Usernamecontroller = TextEditingController();
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
                              "USER LOGIN".tr,
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
                                            if (value!.isEmpty) {
                                              return 'Please Enter Email';
                                            }
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
                                            if (value!.isEmpty) {
                                              return 'Please Enter Password';
                                            }
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
                                          obscureText: showpassword,

                                        ),
                                      ),
                                      IconButton(onPressed: ()=>setState(() {
                                        showpassword=!showpassword;
                                      }), icon: Icon(!showpassword?Icons.visibility_off:Icons.visibility,color: Colors.blue,))
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
                                  await  LoginWithEmail(EmailController.text,PasswordController.text);
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



  Future<void> LoginWithEmail(String Email, String Password) async {
    try
    {
      final url =
      Uri.parse('https://ganto-app.online/public/api/users/login/email');


      SnackbarController c = Get.snackbar(
          backgroundColor: Colors.black,
          "",
          "",
          messageText: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.blue,
              ),
              Text(
                "Please Wait while Login".tr,
                style: GoogleFonts.poppins(color: Colors.white),
              )
            ],
          ),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);

      var response = await http
          .post(url, body: {"user_email": Email, "user_password": Password});
      c.close();
      // Check the response status
      if (response.statusCode == 200) {

        // Successfully received a response
        var data = jsonDecode(response.body);

        User user = User.fromJson(data["user"]);

        if (Get.isRegistered<UserController>()) {
          // If controller already exists, update the existing school
          print("registred user");
          Get.find<UserController>().updateUser(user);
        } else {
          // If controller does not exist, create and register it
          Get.put(UserController()..updateUser(user), permanent: true);
        }

        /*Get.delete<UserController>();

        Get.put( UserController(user),permanent: true);*/
        await prefs.setString("type", "user");
        String userJson = jsonEncode(user.toJson()); // Proper JSON encoding
        await prefs.setString("user", userJson);
        await prefs.setString("token", data["token"]);


        Get.offNamed("/User_Home");
      } else {
        var error = jsonDecode(response.body);

        Get.snackbar("Alert", error["message"],
            backgroundColor: Colors.red, duration: Duration(seconds: 7));
      }
    }
    catch(e)
    {
      Get.snackbar("Alert", "Connection Error",
          backgroundColor: Colors.red, duration: Duration(seconds: 7));
    }

  }

  // Responsive Form Fields
  Widget BuildFieldData(
      String labelText, String hintText, dynamic Function(String?)? validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
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
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintStyle:
                    GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
