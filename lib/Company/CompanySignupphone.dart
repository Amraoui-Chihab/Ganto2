

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:lottie/lottie.dart';

class CompanySignupphone extends StatefulWidget {
  const CompanySignupphone({super.key});

  @override
  State<CompanySignupphone> createState() => _CompanySignupphoneState();
}

class _CompanySignupphoneState extends State<CompanySignupphone> {

  String currentLanguage = Get.locale?.languageCode == "ar"?"Arabic":"English";

  bool showpassword = false;
  String? _phoneNumber;

  TextEditingController CompanyNamecontroller = TextEditingController();
  TextEditingController PhoneController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  TextEditingController DescriptionController = new TextEditingController();
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
                              "COMPANY SIGNUP".tr,
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
                                  "CompanyName",
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
                                              return 'Please Enter CompanyName';
                                            }
                                          },
                                          cursorColor: Colors.blue,
                                          decoration: InputDecoration(
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.black),
                                            hintText:
                                            "Please Enter CompanyName",
                                            border: InputBorder.none,
                                          ),
                                          controller: CompanyNamecontroller,
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
                                  "Company Description",
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
                                              return 'Please Enter Description';
                                            }
                                          },
                                          cursorColor: Colors.blue,
                                          decoration: InputDecoration(
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.black),
                                            hintText: "Please Enter Description",
                                            border: InputBorder.none,
                                          ),
                                          controller: DescriptionController,
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
                                  "Phone",
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

                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: IntlPhoneField(

                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(borderSide: BorderSide.none),
                                            hintText: "Please Enter Phone",
                                          ),
                                          initialCountryCode: 'US',
                                          showDropdownIcon: false,
                                          cursorColor: Colors.blue,

                                          onChanged: (phone) {
                                            setState(() {
                                              _phoneNumber = phone.completeNumber;
                                            });
                                          },
                                        )
                                        ,
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

                                  FocusScope.of(context).requestFocus(FocusNode()); // Remove focus from text fields
                                  await Future.delayed(Duration(milliseconds: 100));
                                  await signupCompany();

                                  //await  Signupuserwithemail(Usernamecontroller.text,EmailController.text,PasswordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child:
                              Text('Signup_company'.tr, style: GoogleFonts.poppins()),
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

  Future<void> signupCompany() async {
    if(_phoneNumber == null)
      {
        var snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            color: Colors.red,
            title: 'Error'.tr,
            message:
            'Please Enter Your Phone Number'.tr,
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.warning,

          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      }
    // Check if the form is valid
    if (_key.currentState!.validate()) {
      // Validate that all fields are filled
      try{
        if (CompanyNamecontroller.text.isEmpty ||

            DescriptionController.text.isEmpty ||
            _phoneNumber!.isEmpty ||

            PasswordController.text.isEmpty ||

            logoImage == null) {
          var snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              color: Colors.red,
              title: 'Error'.tr,
              message:
              'Please fill in all fields and upload the logo image.'.tr,
              messageTextStyle: GoogleFonts.poppins(),
              titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.warning,

            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          return;
        }

        // Validate that all required documents are uploaded
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
                    Lottie.asset('assets/loading.json', width: 100, height: 100,fit: BoxFit.fitHeight),
                    SizedBox(width: 10), // Add spacing between animation and text
                    Text(
                      "Please Wait ...",
                      style: GoogleFonts.poppins(fontSize: 20, decoration: TextDecoration.none,color: Colors.blue),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
            barrierDismissible: false, // Prevents dismissing the dialog
            useSafeArea: true
        );

        // If all validations pass, proceed with the signup
        String? base64LogoImage;

          List<int> logoBytes = await logoImage!.readAsBytes();
          base64LogoImage = base64Encode(logoBytes);






        var data = {
          'company_name': CompanyNamecontroller.text,

          'company_description': DescriptionController.text,
          'company_phone': _phoneNumber,
          'company_password': PasswordController.text,
          'company_logo': base64LogoImage,

        };



        final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/company/Signup/phone'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data),
        );
        print(response.body);

        Get.back();

        if (response.statusCode == 200) {
          var snackBar = SnackBar(
            elevation: 0,

            duration: Duration(seconds: 3),
            backgroundColor: Colors.transparent,

            content: AwesomeSnackbarContent(
              messageTextStyle: GoogleFonts.poppins(),
              titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),
              color: Colors.green,
              title: 'Notification',
              message: "Your Company Has Created Successefully",
              contentType: ContentType.success,

            ),
          );


          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          Get.toNamed("/company_login");
        } else {

          var error = jsonDecode(response.body);
          var snackBar = SnackBar(
            elevation: 0,



            backgroundColor: Colors.transparent,




            content: AwesomeSnackbarContent(
              messageTextStyle: GoogleFonts.poppins(),
              titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),
              color: Colors.red,
              title: 'Error',
              message: error["error"],
              contentType: ContentType.warning,


            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      }
      catch(e)
      {
        Get.back();
        var snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message:
            "Connection Error !",
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,

          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      }
    }


}
