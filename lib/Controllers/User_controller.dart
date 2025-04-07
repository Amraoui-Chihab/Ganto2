import 'dart:io';

import 'package:flutter/material.dart';


import 'package:Ganto/Models/User.dart';
import 'package:Ganto/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';



import '../Models/Student.dart';
import '../Models/Teacher.dart';
import '../School/QRScannerPageStudent.dart';
import '../School/QRScannerPageTeacher.dart';
import 'StudentController.dart';
import 'TeacherController.dart';

class UserController extends GetxController {


  var Current_User = Rx<User?>(null);


  void updateUser(User newUser) {
    Current_User.value = newUser;

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

  RxBool Is_sub_Catgorgy = false.obs;

  RxList<Map<String, String>> categories = [
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

  ].obs;

  List<Map<String, String>> SchoolCategoriesForUser = [

    {'name': 'Teacher', 'image': 'assets/teacher.png'},
    {'name': 'Parent', 'image': 'assets/parent.png'},
  ];


  void Navigate_Between_Categories(String category) {
    switch (category.toLowerCase()) {
    // Convert to lowercase for case-insensitive comparison
      case 'restaurant':
        print("Navigating to Restaurant Page...");
        // Get.to(RestaurantPage());
        break;
      case 'hotels':
        print("Navigating to Hotels Page...");
        // Get.to(HotelsPage());
        break;
      case 'tourisme':
        print("Navigating to Tourism Page...");
        // Get.to(TourismPage());
        break;
      case 'hospitals':
        print("Navigating to Hospitals Page...");
        // Get.to(HospitalsPage());
        break;
      case 'stores':
        print("Navigating to Stores Page...");
        // Get.to(StoresPage());
        break;
      case 'cosmetics':
        print("Navigating to Cosmetics Page...");
        // Get.to(CosmeticsPage());
        break;
      case 'clothes':
        print("Navigating to Clothes Page...");
        // Get.to(ClothesPage());
        break;
      case 'delivery':
        print("Navigating to Delivery Page...");
        // Get.to(DeliveryPage());
        break;
      case 'handyman':
        print("Navigating to Handyman Page...");
        // Get.to(HandymanPage());
        break;
      case 'products':
        print("Navigating to Products Page...");
        // Get.to(ProductsPage());
        break;
      case 'services':
        print("Navigating to Services Page...");
        // Get.to(ServicesPage());
        break;
      case 'estates':
        print("Navigating to Estates Page...");
        // Get.to(EstatesPage());
        break;
      case 'factories':
        print("Navigating to Factories Page...");
        // Get.to(FactoriesPage());
        break;
      case 'bussines':
        print("Navigating to Business Page...");
        // Get.to(BusinessPage());
        break;
      case 'cars':
        print("Navigating to Cars Page...");
        // Get.to(CarsPage());
        break;
      case 'games':
        print("Navigating to Games Page...");
        // Get.to(GamesPage());
        break;
      case 'libraries':
        print("Navigating to Libraries Page...");
        // Get.to(LibrariesPage());
        break;
      case 'electronics':
        print("Navigating to Electronics Page...");
        // Get.to(ElectronicsPage());
        break;
      case 'taxi':
        print("Navigating to Taxi Page...");
        // Get.to(TaxiPage());
        break;

      case 'education':
        naviagte_to_education_category();
        // Get.to(EducationPage());
        break;


      case 'teacher':
        Navigate_to_Teacher();
        // Get.to(TaxiPage());
        break;

      case 'parent':
        NavigateToParentPage();
        // Get.to(TaxiPage());
        break;
      default:
        print("Category not found!");
    // Handle unknown categories
    }
  }

  void NavigateToParentPage() {
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
              "Please Scan Student QrCode",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {


                Get.to(() => QRScannerPageStudent());
              },
              child: Text("Scan Student QrCode", style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Get.back();
                await   scanQRFromGallery();

                if(qrCodeResult!=null)
                {
                  await CheckStudentQrCode(qrCodeResult!);
                }
                else
                {
                  Get.snackbar("Alert", "No QrCode Found In The Image",backgroundColor: Colors.red);
                }

              },
              child: Text("Import QrCode From Phone", style: GoogleFonts.poppins()),
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


  RxBool IsCheckingQrCode = false.obs;
  Future<void> CheckStudentQrCode(String StudentQRcode) async {
    IsCheckingQrCode.value = true;
    IsCheckingQrCode.refresh();

    final String url = "https://ganto-app.online/public/api/CheckStudentQrCode";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "StduentQrCode": StudentQRcode,
        }),
      );

      if (response.statusCode == 200) {
        // Type the first password for signup

        final data = jsonDecode(response.body);
        Get.snackbar("Notification", data["message"],
            backgroundColor: Colors.green, duration: Duration(seconds: 5));

        showQRBottomSheet(Get.context!, _PasswordController, data["idStudent"]);

        IsCheckingQrCode.value = false;
        IsCheckingQrCode.refresh();
      } else if (response.statusCode == 300) {
        final data = jsonDecode(response.body);
        Get.snackbar("Notification", data["message"],
            backgroundColor: Colors.green, duration: Duration(seconds: 5));

        showQRBottomSheetForLoginStudent(Get.context!,PasswordStudentLogin,data["idStudent"]);

        IsCheckingQrCode.value = false;
        IsCheckingQrCode.refresh();
        // make new Password for the user
      } else if (response.statusCode == 400) {
        IsCheckingQrCode.value = false;
        IsCheckingQrCode.refresh();
        final data = jsonDecode(response.body);
        Get.snackbar("Notification", data["message"],
            backgroundColor: Colors.red, duration: Duration(seconds: 5));
      }
    } catch (e) {
      IsCheckingQrCode.value = false;
      IsCheckingQrCode.refresh();
      Get.snackbar("Error", "No Connection", backgroundColor: Colors.red);
    }
  }


  TextEditingController PasswordStudentLogin =new TextEditingController();
  void showQRBottomSheetForLoginStudent(BuildContext context,
      TextEditingController PasswordController, int IdStudent) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Please Enter Student Password To Login",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(horizontal: 12), // Inner padding
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => TextField(
                      controller: PasswordController,
                      obscureText: isObscure.value,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        hintText: "Enter Student Password",
                        border: InputBorder.none, // Removes borders
                      ),
                    )),
                  ),
                  Obx(() => IconButton(
                    onPressed: toggleObscure, // Toggle password visibility
                    icon: Icon(
                      isObscure.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.blue,
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async{
                Navigator.of(context).pop();
                await  LoginStudent(PasswordController.text,IdStudent,context);
              },
              child: Text("Student Show Data", style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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


  Future<void> LoginStudent(String PasswordStudent,int IdStudent,BuildContext c) async{
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 15),
        backgroundColor: Colors.grey,
        content: Row(
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                "Please wait ...",
                style: GoogleFonts.poppins(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
    final Uri url = Uri.parse(
        'https://ganto-app.online/public/api/LoginStudent');

    final Map<String, dynamic> data = {
      "ID_ELEVE": IdStudent,

      "Password": PasswordStudent,
      // Converts to YYYY-MM-DD
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
      print("jhghkfjkfgdjkgfjk");
      print(response.body);


      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(c).clearSnackBars();

        Get.snackbar("Notifiaction", data["message"],backgroundColor: Colors.green, duration: Duration(seconds: 7) );

        Student student = Student.fromJson(data["student"]);


        if (Get.isRegistered<StudentController>()) {
          // If controller already exists, update the existing school
          print("registred student");
          Get.find<StudentController>().updateSTudent(student);
        } else {
          // If controller does not exist, create and register it
          Get.put(StudentController()..updateSTudent(student), permanent: true);
        }

        /* Get.delete<StudentController>();
        Get.put(StudentController(student), permanent: true);*/

        await prefs.setString("type2",  "parent");
        String StudentJson = jsonEncode(student.toJson()); // Proper JSON encoding
        await prefs.setString("student", StudentJson);
        await prefs.setString("token2", data["token"]);





        Get.offNamed("/ParentDashboard");


      }  else {
        ScaffoldMessenger.of(c).clearSnackBars();
        final data = jsonDecode(response.body);

        Get.snackbar("Alert", data["message"],backgroundColor: Colors.red);

      }
    } catch (e) {
      ScaffoldMessenger.of(c).clearSnackBars();

      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, duration: Duration(seconds: 7));

    }


  }

  TextEditingController _PasswordController = new TextEditingController();
  void showQRBottomSheet(BuildContext context,
      TextEditingController PasswordController, int IdStudent) {
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
              "Please Enter Student Password",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(horizontal: 12), // Inner padding
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => TextField(
                      controller: PasswordController,
                      obscureText: isObscure.value,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        hintText: "Enter Student Password",
                        border: InputBorder.none, // Removes borders
                      ),
                    )),
                  ),
                  Obx(() => IconButton(
                    onPressed: toggleObscure, // Toggle password visibility
                    icon: Icon(
                      isObscure.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.blue,
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async{
                Navigator.of(context).pop();
                await  SignUpStudent(PasswordController.text,IdStudent,context);
              },
              child: Text("Set Student Password", style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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

  Future<void> SignUpStudent(String PasswordStudent,int IdStudent,BuildContext c) async {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 15),
        backgroundColor: Colors.grey,
        content: Row(
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                "Please wait ...",
                style: GoogleFonts.poppins(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );


    final Uri url = Uri.parse(
        'https://ganto-app.online/public/api/SignUpStudent');

    final Map<String, dynamic> data = {
      "ID_ELEVE": IdStudent,

      "Password": PasswordStudent,
      // Converts to YYYY-MM-DD
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


      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(c).clearSnackBars();
        // Get.offNamed("/ParentDashboard");
        Get.snackbar("Notifiaction", data["message"],backgroundColor: Colors.green, duration: Duration(seconds: 7) );


      }  else {
        ScaffoldMessenger.of(c).clearSnackBars();
        final data = jsonDecode(response.body);

        Get.snackbar("Alert", data["message"],backgroundColor: Colors.red);

      }
    } catch (e) {
      ScaffoldMessenger.of(c).clearSnackBars();

      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, duration: Duration(seconds: 7));

    }


  }

  void Navigate_to_Teacher() {
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
              "Please Scan your QrCode",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Get.back();
                Get.to(() => QRScannerPageTeacher());

              },
              child: Text("Scan Teacher QrCode", style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Get.back();
                await   scanQRFromGallery();

                if(qrCodeResult!=null)
                {
                  await CheckTeacherQrCodeTeacher(qrCodeResult!);
                }
                else
                {
                  Get.snackbar("Alert", "No QrCode Found In The Image",backgroundColor: Colors.red);
                }

              },
              child: Text("Import QrCode From Phone", style: GoogleFonts.poppins()),
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

  String? qrCodeResult;
  final ImagePicker _picker = ImagePicker();

  final MobileScannerController _cameraController = MobileScannerController();



  Future<void> scanQRFromGallery() async {
    try {
      // Pick an image from the gallery
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Scan the selected image for QR code
        final BarcodeCapture? capture = await _cameraController.analyzeImage(image.path);

        // Extract barcode value if available
        if (capture != null && capture.barcodes.isNotEmpty) {
          qrCodeResult = capture.barcodes.first.rawValue;
        } else {
          qrCodeResult = null;
        }
      }
    } catch (e) {
      qrCodeResult = null;
    } finally {
      print("**********************");
      print(qrCodeResult);
    }
  }



  void naviagte_to_education_category() {


      categories.value = SchoolCategoriesForUser;
      categories.refresh();
      Is_sub_Catgorgy.value = true;
      Is_sub_Catgorgy.refresh();





  }


  void NavigateBack() {
    if (categories == SchoolCategoriesForUser  ) {
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

  RxBool IsCheckingQrCodeTeacher = false.obs;

  Future<void> CheckTeacherQrCodeTeacher(String TeacherQrCode) async {
    IsCheckingQrCodeTeacher.value = true;
    IsCheckingQrCodeTeacher.refresh();

    final String url = "https://ganto-app.online/public/api/CheckTeacherQrCode";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "TeacherQrCode": TeacherQrCode,
        }),
      );
      print("jhfghjgdfjkhfkhgj");
      print(response.body);

      if (response.statusCode == 200) {
        // Type the first password for signup

        final data = jsonDecode(response.body);
        Get.snackbar("Notification", data["message"],
            backgroundColor: Colors.green, duration: Duration(seconds: 5));

        showQRBottomSheetTeacher(Get.context!, _PasswordControllerTeacher, data["idTeacher"]);

        IsCheckingQrCodeTeacher.value = false;
        IsCheckingQrCodeTeacher.refresh();
      } else if (response.statusCode == 300) {
        final data = jsonDecode(response.body);
        Get.snackbar("Notification", data["message"],
            backgroundColor: Colors.green, duration: Duration(seconds: 5));

        showQRBottomSheetForLoginTeacher(Get.context!,PasswordTeacherLogin,data["idTeacher"]);

        IsCheckingQrCodeTeacher.value = false;
        IsCheckingQrCodeTeacher.refresh();
        // make new Password for the user
      } else if (response.statusCode == 400) {
        IsCheckingQrCodeTeacher.value = false;
        IsCheckingQrCodeTeacher.refresh();
        final data = jsonDecode(response.body);
        Get.snackbar("Notification", data["message"],
            backgroundColor: Colors.red, duration: Duration(seconds: 5));
      }
    } catch (e) {
      IsCheckingQrCodeTeacher.value = false;
      IsCheckingQrCodeTeacher.refresh();
      Get.snackbar("Error", "No Connection", backgroundColor: Colors.red);
    }
  }


  var isObscure = true.obs; // Observable boolean

  // Toggle visibility
  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  Future<void> LoginTeacher(String PasswordTeacher,int IdTeacher,BuildContext c) async{
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 15),
        backgroundColor: Colors.grey,
        content: Row(
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                "Please wait ...",
                style: GoogleFonts.poppins(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
    final Uri url = Uri.parse(
        'https://ganto-app.online/public/api/LoginTeacher');

    final Map<String, dynamic> data = {
      "ID_TEACHER": IdTeacher,

      "Password": PasswordTeacher,
      // Converts to YYYY-MM-DD
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
      print("jhghkfjkfgdjkgfjk");
      print(response.body);


      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(c).clearSnackBars();

        Get.snackbar("Notifiaction", data["message"],backgroundColor: Colors.green, duration: Duration(seconds: 7) );

        Teacher teacher = Teacher.fromJson(data["Teacher"]);
        print("TEACHER LOGIN");

        if (Get.isRegistered<TeacherController>()) {
          // If controller already exists, update the existing school
          print("registred teacher");
          Get.find<TeacherController>().updateTeacher(teacher);
        } else {
          // If controller does not exist, create and register it
          Get.put(TeacherController()..updateTeacher(teacher), permanent: true);
        }


        /* Get.delete<TeacherController>();

        Get.put(TeacherController(teacher), permanent: true);*/
        await prefs.setString("type2",  "teacher");
        String TeacherJson = jsonEncode(teacher.toJson()); // Proper JSON encoding
        await prefs.setString("teacher", TeacherJson);

        await prefs.setString("token2", data["token"]);




        //  Get.offNamed("/ParentDashboard");

        Get.offNamed("/TeacherDashboard");


      }  else {
        ScaffoldMessenger.of(c).clearSnackBars();
        final data = jsonDecode(response.body);

        Get.snackbar("Alert", data["message"],backgroundColor: Colors.red);

      }
    } catch (e) {
      ScaffoldMessenger.of(c).clearSnackBars();

      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, duration: Duration(seconds: 7));

    }


  }


  TextEditingController PasswordTeacherLogin =new TextEditingController();
  void showQRBottomSheetForLoginTeacher(BuildContext context,
      TextEditingController PasswordController, int IdTeacher) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Please Enter Teacher Password To Login",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(horizontal: 12), // Inner padding
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => TextField(
                      controller: PasswordController,
                      obscureText: isObscure.value,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        hintText: "Enter Teacher Password",
                        border: InputBorder.none, // Removes borders
                      ),
                    )),
                  ),
                  Obx(() => IconButton(
                    onPressed: toggleObscure, // Toggle password visibility
                    icon: Icon(
                      isObscure.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.blue,
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async{
                Navigator.of(context).pop();
                await  LoginTeacher(PasswordController.text,IdTeacher,context);
              },
              child: Text("Enter Teacher Dashboard", style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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




  TextEditingController _PasswordControllerTeacher = new TextEditingController();
  void showQRBottomSheetTeacher(BuildContext context,
      TextEditingController PasswordController, int IdStudent) {
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
              "Please Enter Teacher Password",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(horizontal: 12), // Inner padding
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => TextField(
                      controller: PasswordController,
                      obscureText: isObscure.value,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        hintText: "Enter Teacher Password",
                        border: InputBorder.none, // Removes borders
                      ),
                    )),
                  ),
                  Obx(() => IconButton(
                    onPressed: toggleObscure, // Toggle password visibility
                    icon: Icon(
                      isObscure.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.blue,
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async{
                Navigator.of(context).pop();
                await  SignUpTeacher(PasswordController.text,IdStudent,context);
              },
              child: Text("Set Teacher Password", style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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

  Future<void> SignUpTeacher(String PasswordTeacher,int IdTeacher,BuildContext c) async {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 15),
        backgroundColor: Colors.grey,
        content: Row(
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                "Please wait ...",
                style: GoogleFonts.poppins(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
    print("fjgkdkhdfjhkjgfdjk");


    final Uri url = Uri.parse(
        'https://ganto-app.online/public/api/SignUpTeacher');

    final Map<String, dynamic> data = {
      "ID_Teacher": IdTeacher,

      "Password": PasswordTeacher,
      // Converts to YYYY-MM-DD
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


      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(c).clearSnackBars();
        // Get.offNamed("/Categories");
        Get.snackbar("Notification", data["message"],backgroundColor: Colors.green, duration: Duration(seconds: 7) );


      }  else {
        ScaffoldMessenger.of(c).clearSnackBars();
        final data = jsonDecode(response.body);

        Get.snackbar("Alert", data["message"],backgroundColor: Colors.red);

      }
    } catch (e) {
      ScaffoldMessenger.of(c).clearSnackBars();

      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, duration: Duration(seconds: 7));

    }


  }



  @override
  void onInit() {
    super.onInit();

  }











  Future<void> change_userReferalCode(String Referel_code) async {
    try {
      final response = await http.put(
          Uri.parse("https://ganto-app.online/public/api/users/update"),
          body: jsonEncode({"user_referal_code": Referel_code}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        this.Current_User.value!.userReferalCode = data["user_referal_code"];
        this.Current_User.refresh();

        Get.snackbar(
          "Notification".tr,
          "ReferalCode Changed successfully".tr,
          backgroundColor: Colors.green,
        );
      } else {
        final data = jsonDecode(response.body);

        Get.snackbar(
          "Notification".tr,
          "ReferalCode Already Used".tr,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error".tr, e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> change_userAdress(String userAddress) async {
    try {
      print(userAddress);
      print("jkgfdkhsjskjhgfdsjgfkjkj");
      final response = await http.put(
          Uri.parse("https://ganto-app.online/public/api/users/update"),
          body: jsonEncode({"user_adress": userAddress}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        this.Current_User.value!.userAddress = data["user_adress"];
        this.Current_User.refresh();

        Get.snackbar(
          "Notification".tr,
          "Adress Changed successfully".tr,
          backgroundColor: Colors.green,
        );
      } else {
        final data = jsonDecode(response.body);

        Get.snackbar(
          "Notification".tr,
          data.toString(),
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error".tr, e.toString(), backgroundColor: Colors.red);
    }
  }





  Future<void> changeUserLogo(String logo) async {
    // Show a dialog with a CircularProgressIndicator
    Get.defaultDialog(
      title: "Updating Logo".tr,
      barrierDismissible: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text("Please wait while your logo is being updated...".tr),
        ],
      ),
    );

    try {
      final response = await http.put(
          Uri.parse("https://ganto-app.online/public/api/users/update"),
          body: jsonEncode({"user_logo": logo}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        this.Current_User.value!.userPhotoUrl = data["user_logo"];
        this.Current_User.refresh();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar(
            "Notification".tr,
            "UserPhoto Changed successfully".tr,
            backgroundColor: Colors.green,
          );
        });
      } else {
        final data = jsonDecode(response.body);

        Get.snackbar(
          "Notification".tr,
          data.toString(),
          backgroundColor: Colors.red,
        );
      }

      // Perform the actual logo change operation
      // Example: await apiService.updateUserLogo(imageBase64);

      // Success message (optional)
      Get.back(); // Close the dialog
    } catch (e) {
      // Handle errors
      Get.back(); // Close the dialog
      Get.snackbar("Error".tr, "Failed to update logo".tr + " : $e");
    }
  }

  Future<void> change_useremail(String Email) async {
    try {
      final response = await http.put(
          Uri.parse("https://ganto-app.online/public/api/users/update"),
          body: jsonEncode({"user_email": Email}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        this.Current_User.value!.userEmail = data["user_email"];
        this.Current_User.refresh();
        Get.snackbar(
          "Notification".tr,
          "Email Changed successfully".tr,
          backgroundColor: Colors.green,
        );
      } else {
        final data = jsonDecode(response.body);

        Get.snackbar(
          "Notification".tr,
          "Email Already Used".tr,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error".tr, e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> change_userphone(String Phone) async {
    try {
      final response = await http.put(
          Uri.parse("https://ganto-app.online/public/api/users/update"),
          body: jsonEncode({"user_phone": Phone}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        this.Current_User.value!.userPhone = data["user_phone"];
        this.Current_User.refresh();
        Get.snackbar(
          "Notification".tr,
          "Phone Changed successfully".tr,
          backgroundColor: Colors.green,
        );
      } else {
        final data = jsonDecode(response.body);

        Get.snackbar(
          "Notification".tr,
          "The Phone Already Used".tr,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error".tr, e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> change_username(String name) async {
    try {
      final response = await http.put(
          Uri.parse("https://ganto-app.online/public/api/users/update"),
          body: jsonEncode({"user_name": name}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("token")}',
          });

      print(response.body);
      print("khjghfkjkgfdkjfgkj");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        this.Current_User.value!.username = data["user_name"];
        this.Current_User.refresh();

        Get.snackbar(
          "Notification".tr,
          "UserName Changed successfully".tr,
          backgroundColor: Colors.green,
        );
      } else {
        final data = jsonDecode(response.body);

        Get.snackbar(
          "Notification".tr,
          "The username has been Used Before",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error".tr, e.toString(), backgroundColor: Colors.red);
    }
  }
















  Future<void> Logout() async {
    try {
      final response = await http.get(
        Uri.parse('https://ganto-app.online/public/api/user/logout'),
        headers: {
          'Authorization': 'Bearer ${prefs.getString("token")}',
        },
      );

      if (response.statusCode == 200) {
        prefs.remove('token');
        prefs.remove('type');
        prefs.remove('user');
        Get.delete<UserController>();

        Get.offNamed("/intro");

        Get.snackbar("Notification".tr, "Successfully logged out".tr,
            backgroundColor: Colors.green);
      } else {
        Get.snackbar("Alert", "Error with code : ${response.statusCode}",
            backgroundColor: Colors.red, duration: Duration(seconds: 6));
      }
    } catch (e) {
      Get.snackbar("Error", "${e.toString()}",
          backgroundColor: Colors.red, duration: Duration(seconds: 6));
    }
  }




}
