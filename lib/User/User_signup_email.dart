import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:http/http.dart' as http;

class UserSignupemail extends StatefulWidget {
  const UserSignupemail({super.key});

  @override
  State<UserSignupemail> createState() => _UserSignupemailState();
}

class _UserSignupemailState extends State<UserSignupemail> {
  String currentLanguage = Get.locale?.languageCode == "ar"?"Arabic":"English";

  bool showpassword = false;

  TextEditingController Usernamecontroller = TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController InviteCodeController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  final picker = ImagePicker();
  File? logoImage;
  Future<void> pickLogoImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        logoImage = File(pickedFile.path);
      });
    }
  }

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
                  top: screenHeight * 0.5,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.5,
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
                              "USER SIGNUP".tr,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    screenWidth * 0.06, // Responsive text size
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),

                            InkWell(
                              onTap: pickLogoImage,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                backgroundImage: logoImage != null ? FileImage(logoImage!) : null,
                                child: logoImage == null
                                    ? Icon(Icons.camera_alt, size: 50, color: Colors.blue)
                                    : null,
                              ),
                            ),

                            // Form Fields
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "UserName",
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
                                              return 'Please Enter UserName';
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
                                          controller: Usernamecontroller,
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
                                  "Invite Code",
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
                                              return 'Please Enter Invite Code';
                                            }
                                          },
                                          cursorColor: Colors.blue,
                                          decoration: InputDecoration(
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.black),
                                            hintText: "Please Enter Invite Code",
                                            border: InputBorder.none,
                                          ),

                                          controller: InviteCodeController,
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
                                await  Signupuserwithemail(Usernamecontroller.text,InviteCodeController.text,EmailController.text,PasswordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child:
                                  Text("Signup", style: GoogleFonts.poppins()),
                            ),
                            SizedBox(height: 10,)
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

  Future<void> Signupuserwithemail(
      String Username, String InviteCode,String Email, String password) async {
    try {
      print("hello");
      final url =
          Uri.parse('https://ganto-app.online/public/api/users/Signup/email');
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
                "Please Wait while Signup".tr,
                style: GoogleFonts.poppins(color: Colors.white),
              )
            ],
          ),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);


      String? base64LogoImage;
      if (logoImage != null) {
        List<int> logoBytes = await logoImage!.readAsBytes();
        base64LogoImage = base64Encode(logoBytes);
      }else
      {
        Get.snackbar("Notification", "Please Upload User Photo",backgroundColor: Colors.red);
        return;
      }
      final requestBody = InviteCodeController.text.isNotEmpty?{
        'invite_code':InviteCodeController.text,
        'user_name': Usernamecontroller.text,
        'user_email': EmailController.text,
        'user_password': PasswordController.text,
        'user_photo':base64LogoImage
      }:{
        'user_name': Usernamecontroller.text,
        'user_email': EmailController.text,
        'user_password': PasswordController.text,
        'user_photo':base64LogoImage
      };

      var response = await http.post(url, body: requestBody);

      // Check the response status
      if (response.statusCode == 200) {
        c.close();
        // Successfully received a response
        var data = jsonDecode(response.body);

        Get.snackbar("Notification", "You Have Succeseffully Registred",
            backgroundColor: Colors.green);

        Get.offNamed("/user_login");
      } else {
        var error = jsonDecode(response.body);

        Get.snackbar(error["message"], error["error"],
            backgroundColor: Colors.red, duration: Duration(seconds: 5));
      }
    } catch (e) {
      Get.snackbar("Alert", e.toString(), backgroundColor: Colors.red);
      print('Error occurred: $e');
    }
  }

  // Responsive Form Fields

}
