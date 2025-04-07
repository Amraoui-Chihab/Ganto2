import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:Ganto/Models/Company.dart';

import 'package:Ganto/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


import '../Models/School.dart';
import 'SchoolController.dart';

class CompanyController extends GetxController {
  String selectedlangugae = "English";
  RxBool Is_sub_Catgorgy = false.obs;

  RxList<Map<String, String>> categories = [
    {'name': 'Education', 'image': 'assets/Categories/eduaction.png'},
    {'name': 'Restaurant', 'image': 'assets/Categories/restaurant.png'},
    {'name': 'Hotels', 'image': 'assets/Categories/hotel.png'},
    {'name': 'Tourisme', 'image': 'assets/Categories/tourisme.png'},
    {'name': 'Hospitals', 'image': 'assets/Categories/hospital.png'},
    {'name': 'Stores', 'image': 'assets/Categories/store.png'},
    {'name': 'Cosmetics', 'image': 'assets/Categories/cosmetics.png'},
    {'name': 'Clothes', 'image': 'assets/Categories/clothes.png'},
    {'name': 'Delivery', 'image': 'assets/Categories/delivery.png'},
    {'name': 'Handyman', 'image': 'assets/Categories/handyman.png'},
    {'name': 'Products', 'image': 'assets/Categories/products.png'},
    {'name': 'Services', 'image': 'assets/Categories/services.png'},
    {'name': 'Estates', 'image': 'assets/Categories/estate.png'},
    {'name': 'Factories', 'image': 'assets/Categories/factory.png'},
    {'name': 'Bussines', 'image': 'assets/Categories/bussines.png'},
    {'name': 'Cars', 'image': 'assets/Categories/car.png'},
    {'name': 'Games', 'image': 'assets/Categories/games.png'},
    {'name': 'Libraries', 'image': 'assets/Categories/library.png'},
    {'name': 'Electronics', 'image': 'assets/Categories/electronics.png'},
    {'name': 'Taxi', 'image': 'assets/Categories/taxi.png'},
  ].obs;

  List<Map<String, String>> SchoolCategoriesForCompany = [
    {'name': 'School', 'image': 'assets/school.png'},
  ];

  void NavigateBack() {
    if (categories == SchoolCategoriesForCompany) {
      Is_sub_Catgorgy.value = false;
      Is_sub_Catgorgy.refresh();

      categories.value = [
        {'name': 'Education', 'image': 'assets/Categories/eduaction.png'},
        {'name': 'Restaurant', 'image': 'assets/Categories/restaurant.png'},
        {'name': 'Hotels', 'image': 'assets/Categories/hotel.png'},
        {'name': 'Tourisme', 'image': 'assets/Categories/tourisme.png'},
        {'name': 'Hospitals', 'image': 'assets/Categories/hospital.png'},
        {'name': 'Stores', 'image': 'assets/Categories/store.png'},
        {'name': 'Cosmetics', 'image': 'assets/Categories/cosmetics.png'},
        {'name': 'Clothes', 'image': 'assets/Categories/clothes.png'},
        {'name': 'Delivery', 'image': 'assets/Categories/delivery.png'},
        {'name': 'Handyman', 'image': 'assets/Categories/handyman.png'},
        {'name': 'Products', 'image': 'assets/Categories/products.png'},
        {'name': 'Services', 'image': 'assets/Categories/services.png'},
        {'name': 'Estates', 'image': 'assets/Categories/estate.png'},
        {'name': 'Factories', 'image': 'assets/Categories/factory.png'},
        {'name': 'Bussines', 'image': 'assets/Categories/bussines.png'},
        {'name': 'Cars', 'image': 'assets/Categories/car.png'},
        {'name': 'Games', 'image': 'assets/Categories/games.png'},
        {'name': 'Libraries', 'image': 'assets/Categories/library.png'},
        {'name': 'Electronics', 'image': 'assets/Categories/electronics.png'},
        {'name': 'Taxi', 'image': 'assets/Categories/taxi.png'},
      ];
      categories.refresh();
    }
  }

  void Navigate_Between_Categories(String category) {
    switch (category.toLowerCase()) {


      case 'education':
        naviagte_to_education_category();
        // Get.to(EducationPage());
        break;
      case 'school':
        navigate_to_school();
        // Get.to(TaxiPage());
        break;

      default:
        NotYetCategory();
      // Handle unknown categories
    }
  }

  void NotYetCategory()
  {
    var snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        messageTextStyle: GoogleFonts.poppins(),
        titleTextStyle:
        GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
        color: Colors.blue,
        title: 'Notification',
        message: "Category Available Soon",
        contentType: ContentType.help,


      ),
    );

    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void navigate_to_school() {
    Get.bottomSheet(
      Container(
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
              "Select an Option",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                //Get.back(); // Close bottom sheet
                Get.toNamed("/School_Login");
              },
              child: Text("Login to School", style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/Create_School");
              },
              child: Text(
                "Create New School",
                style: GoogleFonts.poppins(),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  Future<void> SchoolLogin(
      String schoolEmail, String schoolPassword, BuildContext c) async {

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


    final String url =
        "https://ganto-app.online/public/api/SchoolLogin"; // Update with actual API URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": schoolEmail,
          "password": schoolPassword,
        }),
      );
      Get.back();
      if (response.statusCode == 200) {


        final data = jsonDecode(response.body);

        School school = School.fromJson(data["school"]);

        if (Get.isRegistered<SchoolController>()) {
          // If controller already exists, update the existing school
          print("registred");
          Get.find<SchoolController>().updateSchool(school);
        } else {
          // If controller does not exist, create and register it
          Get.put(SchoolController()..updateSchool(school), permanent: true);
        }

        // Get.put(SchoolController(school), permanent: true);

        await prefs.setString("token2", data["token"]);
        await prefs.setString("type2", "director");
        String schoolJson = jsonEncode(school.toJson()); // Proper JSON encoding
        await prefs.setString("director", schoolJson);

        Get.offNamed("/DirectorDashboard");

        // Handle successful login (e.g., store token, navigate to home screen)
      } else {

        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: jsonDecode(response.body)["message"],
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(Get.context!)
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

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> createNewSchool(
      String schoolName,
      String email,
      String password,
      String phone,
      String directorName,
      String directorLastName,
      DateTime creationDate,
      BuildContext c,
      File? image) async {




    String? base64LogoImage;
    if (image != null) {
      List<int> logoBytes = await image.readAsBytes();
      base64LogoImage = base64Encode(logoBytes);
    } else {
      var snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          color: Colors.red,
          title: 'Error',
          message: "Please Select School Image",
          contentType: ContentType.warning,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return;
    }
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
    final Uri url = Uri.parse(
        'https://ganto-app.online/public/api/new_school'); // Replace with your actual API URL

    final Map<String, dynamic> data = {
      "school_name": schoolName,
      "email": email,
      "password": password,
      "phone": phone,
      "director_name": directorName,
      "director_lastname": directorLastName,
      "creation_date": creationDate
          .toIso8601String()
          .split('T')[0], // Converts to YYYY-MM-DD

      'School_logo': base64LogoImage,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(data),
      );
      Get.back();
      if (response.statusCode == 201 || response.statusCode == 200) {

        // Get.offNamed("/Categories");
        var snackBar = SnackBar(
          elevation: 0,

          duration: Duration(seconds: 3),
          backgroundColor: Colors.transparent,

          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),
            color: Colors.green,
            title: 'Notification',
            message: "School Created Successfully",
            contentType: ContentType.success,

          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Get.offNamed("/Company_Home");

      }
      else {

        var error = jsonDecode(response.body);
        var snackBar = SnackBar(
          elevation: 0,



          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 7),



          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: error["message"],
            contentType: ContentType.warning,


          ),
        );

        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);


      }
    } catch (e) {
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

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  void naviagte_to_education_category() {
    categories.value = SchoolCategoriesForCompany;
    categories.refresh();
    Is_sub_Catgorgy.value = true;
    Is_sub_Catgorgy.refresh();
  }



  var company = Rx<Company?>(null);

  void updateCompany(Company newcompany) {
    company.value = newcompany;

    Is_sub_Catgorgy.value = false;
    Is_sub_Catgorgy.refresh();

    categories.value = [
      {'name': 'Education', 'image': 'assets/Categories/eduaction.png'},
      {'name': 'Restaurant', 'image': 'assets/Categories/restaurant.png'},
      {'name': 'Hotels', 'image': 'assets/Categories/hotel.png'},
      {'name': 'Tourisme', 'image': 'assets/Categories/tourisme.png'},
      {'name': 'Doctors', 'image': 'assets/Categories/hospital.png'},
      {'name': 'Stores', 'image': 'assets/Categories/store.png'},
      {'name': 'Cosmetics', 'image': 'assets/Categories/cosmetics.png'},
      {'name': 'Clothes', 'image': 'assets/Categories/clothes.png'},
      {'name': 'Delivery', 'image': 'assets/Categories/delivery.png'},
      {'name': 'Handyman', 'image': 'assets/Categories/handyman.png'},
      {'name': 'Products', 'image': 'assets/Categories/products.png'},
      {'name': 'Services', 'image': 'assets/Categories/services.png'},
      {'name': 'Estates', 'image': 'assets/Categories/estate.png'},
      {'name': 'Factories', 'image': 'assets/Categories/factory.png'},
      {'name': 'Bussines', 'image': 'assets/Categories/bussines.png'},
      {'name': 'Cars', 'image': 'assets/Categories/car.png'},
      {'name': 'Games', 'image': 'assets/Categories/games.png'},
      {'name': 'Libraries', 'image': 'assets/Categories/library.png'},
      {'name': 'Electronics', 'image': 'assets/Categories/electronics.png'},
      {'name': 'Taxi', 'image': 'assets/Categories/taxi.png'},
    ];
    categories.refresh();
  }












  Future<void> Change_Company_Email(String Email) async {

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
    try {
      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/company/change_email'),
          body: {
            'new_email': Email
          },
          headers: {
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      var data = jsonDecode(response.body);
      Get.back();
      if (response.statusCode == 200) {


        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 5),
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.green,
            title: 'Success',
            message: "Email Updated Successefully",
            contentType: ContentType.success,
          ),
        );
        Company c = Company.fromJson(data["company"]);
        this.company.value = c;
        this.company.refresh();
        String companyJson = jsonEncode(c.toJson());
        await prefs.setString("company", companyJson);
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: data["error"],
            contentType: ContentType.warning,

          ),
        );

        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      Get.back();

      var snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: "Connection Error !",
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
          inMaterialBanner: true,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> logout() async {
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
    try {
      final response = await http.get(
          Uri.parse('https://ganto-app.online/public/api/company/logout'),
          headers: {
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });
      Get.back();


      var data =jsonDecode(response.body);
      if (response.statusCode == 200) {

        prefs.remove("token");
        prefs.remove("type");
        prefs.remove("company");
        Get.delete<CompanyController>();

        Get.offNamed("/intro");

      } else {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: response.body,
            contentType: ContentType.warning,

          ),
        );

        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      Get.back();
      print(e.toString());

      var snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: "Connection Error !",
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
          inMaterialBanner: true,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> Change_Company_Logo(String Logo) async {
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
      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/company/change_logo'),
          body: {
            'logo': Logo
          },
          headers: {
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      var data = jsonDecode(response.body);
      Get.back();
      if (response.statusCode == 200) {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 5),
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.green,
            title: 'Success',
            message: "Logo Updated Succesefully",
            contentType: ContentType.success,
          ),
        );
        Company c = Company.fromJson(data["company"]);
        this.company.value = c;
        this.company.refresh();
        String companyJson = jsonEncode(c.toJson());
        await prefs.setString("company", companyJson);
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: data["message"],
            contentType: ContentType.warning,

          ),
        );

        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      Get.back();

      var snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: "Connection Error !",
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
          inMaterialBanner: true,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }





  Future<void> Change_Company_Description(String Description) async {
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
      final response = await http.post(
          Uri.parse(
              'https://ganto-app.online/public/api/company/change_Description'),
          body: {
            'new_Description': Description
          },
          headers: {
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      var data = jsonDecode(response.body);
      Get.back();
      if (response.statusCode == 200) {
        Company c = Company.fromJson(data["company"]);
        this.company.value = c;
        this.company.refresh();
        String companyJson = jsonEncode(c.toJson());
        await prefs.setString("company", companyJson);

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
            message: "Description Updated Succesefully",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: data["error"],
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(Get.context!)
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

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> Change_Company_Phone(String phone) async {
    if (phone.isEmpty) {

      var snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          color: Colors.red,
          title: 'Error',
          message: "Please Enter Phone",
          contentType: ContentType.warning,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      return;
    }
    Navigator.of(Get.context!)
        .pop();
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
    try {

      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/company/change_phone'),
          body: {
            'new_phone': phone
          },
          headers: {
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      var data = jsonDecode(response.body);

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
            message: "Phone updated successefully",
            contentType: ContentType.success,
          ),
        );

        var data = jsonDecode(response.body);
        Company company = Company.fromJson(data["company"]);

        this.company.value=company;
        this.company.refresh();
        String companyJson =
        jsonEncode(company.toJson()); // Proper JSON encoding
        await prefs.setString("company", companyJson);
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: data["error"],
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(Get.context!)
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

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> Change_Company_Name(String name) async {
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
      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/company/change_name'),
          body: {
            'new_name': name
          },
          headers: {
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      Get.back();
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 5),
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.green,
            title: 'Success',
            message: "Name Updated Succesefully",
            contentType: ContentType.success,
          ),
        );
        Company c = Company.fromJson(data["company"]);
        this.company.value = c;
        this.company.refresh();
        String companyJson = jsonEncode(c.toJson());
        await prefs.setString("company", companyJson);
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        var error = jsonDecode(response.body);
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: error["error"],
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(Get.context!)
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

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> deleteCompany(int id) async {
    final url = Uri.parse('https://ganto-app.online/public/api/companies/$id');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${prefs.getString("token")}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        prefs.remove("token");
        Get.delete<CompanyController>();

        Get.offNamed("/intro");
        print("Company deleted successfully");
        Get.snackbar("Success", "Company deleted successfully");
      } else if (response.statusCode == 404) {
        Get.snackbar("Error", "Company not found or not authorized");
      } else {
        print(response.statusCode);
        print(response.body);
        Get.snackbar("Error", "Failed to delete company");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
