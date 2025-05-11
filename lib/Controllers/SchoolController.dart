import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:Ganto/Models/Class.dart';
import 'package:Ganto/Models/FullCourse.dart';
import 'package:Ganto/Models/School.dart';
import 'package:Ganto/Models/Speciality.dart';
import 'package:Ganto/Models/Student.dart';
import 'package:Ganto/Models/Trimester.dart';
import 'package:Ganto/main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../Models/Average.dart';
import '../Models/Company.dart';
import '../Models/Cours.dart';
import '../Models/Link.dart';
import '../Models/Module.dart';
import '../Models/Room.dart';
import '../Models/Teacher.dart';
import 'Company_controller.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SchoolController extends GetxController {
  var school = Rx<School?>(null); // Allow nullable value initially

  // Constructor initializes the school variable properly
  void updateSchool(School newSchool) {
    school.value = newSchool;
  }

  Future<bool> DeleteCourse(int IdCourse) async {
    try {
      final response = await http.post(
        Uri.parse('https://ganto-app.online/public/api/DeleteCourse'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
        body: jsonEncode({
          // Assume 1-hour courses
          "ID_COURS": IdCourse,
        }),
      );

      if (response.statusCode == 200) {
        Courses.removeWhere(
          (c) => c.idCours == IdCourse,
        );
        Courses.refresh();
        Get.snackbar("Notification", "Course Deleted Successefully",
            backgroundColor: Colors.green);

        return true;
      } else {
        print(response.statusCode);
        Get.snackbar("Error", "Error ${response.body}",
            backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
      Get.snackbar("Connection Error ", "Check You Connection Network Please",
          backgroundColor: Colors.red);
      return false;
    }
  }

  Future<FullCourse?> insertCourse(int idTeacher, int idClass, int IdRoom,
      int IdModule, int ID_TRIMESTER, DateTime day, int hour) async {
    final response = await http.post(
      Uri.parse('https://ganto-app.online/public/api/add_course'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.get("token2")}',
      },
      body: jsonEncode({
        // Assume 1-hour courses
        "CLASSE_ID": idClass,
        "ID_ENSEIGNANT": idTeacher,
        "ID_SALLE": IdRoom,
        "ID_MATIERE": IdModule,
        "ID_TRIMESTER": ID_TRIMESTER,
        "DATE_COURS": DateFormat('yyyy-MM-dd').format(day),
        "HEURE_DEBUT_COURS": "$hour:00:00",
        "HEURE_FIN_COURS": "${hour + 1}:00:00",
      }),
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      FullCourse c = FullCourse.fromJson(data["course"]);
      Get.snackbar("Notification", "Course added successfully!",
          backgroundColor: Colors.green);
      print("Course added successfully!");
      return c;
    } else {
      print(response.statusCode);
      print("Failed to add course: ${response.body}");
      return null;
    }
  }

  Future<List<FullCourse>> fetchCourses(int classId) async {
    final response = await http.get(
      Uri.parse(
          'https://ganto-app.online/public/api/CoursesByClassMonthYear?classe_id=$classId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${prefs.get("token2")}',
      },
    );

    if (response.statusCode == 200) {
      return FullCourse.listFromJson(response.body);
    } else {
      throw Exception("Failed to fetch courses");
    }
  }

  Future<Map<String, dynamic>?> getClassesForStudent() async {
    final Uri url =
        Uri.parse('https://ganto-app.online/public/api/GetClassesForStudent');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ${prefs.get("token2")}', // Replace with actual user token
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getDataForNewCourse() async {
    final Uri url =
        Uri.parse('https://ganto-app.online/public/api/GetDataForNewCourse');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer ${prefs.get("token2")}', // Replace with actual user token
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {


        return json.decode(response.body);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
  // Future<void> InsertStudent(String Name,String LastName,int IdClass , String )

  Future<void> InsertStduent(
      String Name,
      String LastName,
      int IdClass,
      String BirthDate,
      String StudentSexe,
      BuildContext c,
      File? _imageFile) async {
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

    String? base64LogoImage;

    List<int> logoBytes = await _imageFile!.readAsBytes();
    base64LogoImage = base64Encode(logoBytes);

    final String url = "https://ganto-app.online/public/api/InsertEleve";

    var uuid = Uuid();
    String qrData = uuid.v1();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({
          "CLASSE_ID": IdClass,
          "NOM_ELEVE": Name,
          "PRENOM_ELEVE": LastName,
          "DATE_NAISSANCE": BirthDate,
          "QR_CODE": qrData,
          "SEXE_ELEVE": StudentSexe,
          'QR_CODE_USED': 0,
          'Logo': base64LogoImage
        }),
      );
      print(response.statusCode);
      Get.back();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
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
            message: "Student Added Successefully",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        Get.back();
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

  RxList<Teacher> Teachers = RxList();

  Future<void> GetTeachers() async {
    final String url = "https://ganto-app.online/public/api/GetTeachers";

    try {
      Teachers.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['Teachers'] != null) {
          Teachers.value = (data['Teachers'] as List)
              .map((item) => Teacher.fromJson(item))
              .toList();

          Teachers.refresh();
        }
      } else {
        Teachers.value = [];
        Teachers.refresh();
      }
    } catch (e) {
      Teachers.value = [];
      Teachers.refresh();
      print("Error in: $e");
    }
  }

  RxList<Student> Stduents = RxList();

  Future<void> GetStudents() async {
    final String url = "https://ganto-app.online/public/api/GetStduents";

    try {
      Stduents.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['Stduents'] != null) {
          Stduents.value = (data['Stduents'] as List)
              .map((item) => Student.fromJson(item))
              .toList();

          Stduents.refresh();
        }
      } else {
        Stduents.value = [];
        Stduents.refresh();
      }
    } catch (e) {
      Stduents.value = [];
      Stduents.refresh();
      var snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          color: Colors.red,
          title: 'Error',
          message: "Connection Error",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  RxList<Class> Classes = RxList();
  Future<void> GetClasses() async {
    final String url = "https://ganto-app.online/public/api/GetClasses";

    try {
      Classes.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      print(jsonDecode(response.body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['Classes'] != null) {
          Classes.value = (data['Classes'] as List)
              .map((item) => Class.fromJson(item))
              .toList();

          Classes.refresh();
        }
      } else {
        Classes.value = [];
        Classes.refresh();
      }
    } catch (e) {
      Classes.value = [];
      Classes.refresh();
      var snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          color: Colors.red,
          title: 'Error',
          message: "Connection Error",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  RxList<Trimestre> Trimesters = RxList();
  Future<void> GetTrimesters() async {
    final String url = "https://ganto-app.online/public/api/GetTrimesters";

    try {
      Trimesters.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['Trimesters'] != null) {
          Trimesters.value = (data['Trimesters'] as List)
              .map((item) => Trimestre.fromJson(item))
              .toList();

          Trimesters.refresh();
        }
      } else {
        Trimesters.value = [];
        Trimesters.refresh();
      }
    } catch (e) {
      Trimesters.value = [];
      Trimesters.refresh();
      var snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          color: Colors.red,
          title: 'Error',
          message: "Connection Error",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  RxList<Room> Rooms = RxList();

  Future<void> GetRooms() async {
    final String url = "https://ganto-app.online/public/api/GetRooms";

    try {
      Rooms.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['Rooms'] != null) {
          Rooms.value = (data['Rooms'] as List)
              .map((item) => Room.fromJson(item))
              .toList();

          Rooms.refresh();
        }
      } else {
        Rooms.value = [];
        Rooms.refresh();
      }
    } catch (e) {
      Rooms.value = [];
      Rooms.refresh();
      Get.snackbar("Error", "Connection Error", backgroundColor: Colors.red);
    }
  }

  RxList<Specialite> Specialities = RxList();
  Future<void> GetSpecialities() async {
    final String url = "https://ganto-app.online/public/api/GetSpecialities";

    try {
      Specialities.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['Specialities'] != null) {
          Specialities.value = (data['Specialities'] as List)
              .map((item) => Specialite.fromJson(item))
              .toList();

          Specialities.refresh();
        }
      } else {
        Specialities.value = [];
        Specialities.refresh();
      }
    } catch (e) {
      Specialities.value = [];
      Specialities.refresh();
      var snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          color: Colors.red,
          title: 'Error',
          message: "Connection Error!",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  RxList<Module> modules = RxList();

  Future<void> GetModules() async {
    final String url = "https://ganto-app.online/public/api/GetModules";

    try {
      modules.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['modules'] != null) {
          modules.value = (data['modules'] as List)
              .map((item) => Module.fromJson(item))
              .toList();

          modules.refresh();
        }
      } else {
        modules.value = [];
        modules.refresh();
      }
    } catch (e) {
      modules.value = [];
      modules.refresh();
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

  RxList<Link> Links = RxList();

  Future<void> GetLinks() async {
    final String url = "https://ganto-app.online/public/api/GetLinks";

    try {
      Links.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);
      print(response.statusCode);

      print(jsonDecode(response.body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['Links'] != null) {
          Links.value = (data['Links'] as List)
              .map((item) => Link.fromJson(item))
              .toList();

          Links.refresh();
        }
      } else {
        Links.value = [];
        Links.refresh();
      }
    } catch (e) {
      print(e.toString());
      Links.value = [];
      Links.refresh();
      Get.snackbar("Error", "Connection Error", backgroundColor: Colors.red);
    }
  }

  RxList<FullCourse> Courses = RxList();
  Future<void> GetCourses(int IdTeacher) async {
    final String url =
        "https://ganto-app.online/public/api/GetCourses/${IdTeacher}";

    try {
      Courses.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);
      print(response.statusCode);

      print(jsonDecode(response.body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['Courses'] != null) {
          Courses.value = (data['Courses'] as List)
              .map((item) => FullCourse.fromJson(item))
              .toList();

          Courses.refresh();
        }
      } else {
        Courses.value = [];
        Courses.refresh();

        Get.snackbar("Error", "This Teacher Has No Course",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e.toString());
      Courses.value = [];
      Courses.refresh();
      Get.snackbar("Error", "Connection Error", backgroundColor: Colors.red);
    }
  }

  RxList<Average> Averages = RxList();
  Future<void> FetchAverages(int StudentId) async {
    final String url =
        "https://ganto-app.online/public/api/GetAverages/${StudentId}";

    try {
      Averages.clear();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      // print(response.statusCode);
      print(response.statusCode);

      print(jsonDecode(response.body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print(data["Averages"]);
        if (data['Averages'] != null) {
          Averages.value = (data['Averages'] as List)
              .map((item) => Average.fromJson(item))
              .toList();

          Averages.refresh();
        }
      } else {
        Averages.value = [];
        Averages.refresh();

        // Get.snackbar("Error", "This Teacher Has No Course",backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e.toString());
      Averages.value = [];
      Averages.refresh();
      var snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          color: Colors.red,
          title: 'Error',
          message: "Connection Error",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> PutAverage(
      int StudentId, int IdTrim, double Average, BuildContext c) async {

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

    final String url = "https://ganto-app.online/public/api/PutAverage";

    try {
      Averages.clear();
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${prefs.getString("token2")}',
          },
          body: jsonEncode(
              {"StudentId": StudentId, "IdTrim": IdTrim, "Average": Average}));
      // print(response.statusCode);
      print(response.statusCode);

      print(jsonDecode(response.body));

      Get.back();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var snackBar = SnackBar(
          elevation: 0,

          duration: Duration(seconds: 3),
          backgroundColor: Colors.transparent,

          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),
            color: Colors.green,
            title: 'Notification',
            message: "Average Added Successfully",
            contentType: ContentType.success,

          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Get.back();
      } else {
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

        // Get.snackbar("Error", "This Teacher Has No Course",backgroundColor: Colors.red);
      }
    } catch (e) {

      var snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          messageTextStyle: GoogleFonts.poppins(),
          titleTextStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
          color: Colors.red,
          title: 'Error',
          message: "Connection Error",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } finally {
      Navigator.of(c).pop();
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.get(
          Uri.parse('https://ganto-app.online/public/api/Director/logout'),
          headers: {
            'Authorization': 'Bearer ${prefs.getString("token2")}',
          });

      if (response.statusCode == 200) {
        /* Get.put(GeneralController());
        GeneralController _GeneralController = Get.find<GeneralController>();

        _GeneralController.Is_sub_Catgorgy.value = false;
        _GeneralController.Is_sub_Catgorgy.refresh();

        _GeneralController.categories.value = [
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
        _GeneralController.categories.refresh();*/

        await prefs.remove("token2");
        await prefs.remove("type2");
        await prefs.remove("director");
        Get.delete<SchoolController>();

        String? companyJson = prefs.getString("company");

        Map<String, dynamic> userMap = jsonDecode(companyJson!);
        Company company = Company.fromJson(userMap);
        if (Get.isRegistered<CompanyController>()) {
          // If controller already exists, update the existing school

          Get.find<CompanyController>().updateCompany(company);
        } else {
          // If controller does not exist, create and register it
          Get.put(CompanyController()..updateCompany(company), permanent: true);
        }

        Get.offNamed("/Company_Home");
        Get.snackbar("Notification".tr, "Successfully logged out".tr,
            backgroundColor: Colors.green);
      } else {
        print(response.body);
        Get.snackbar("Alert", "Error with code ${response.statusCode}",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Alert", "Error ${e.toString()}",
          backgroundColor: Colors.red);
    }
  }

  Future<void> Insert_Teacher(String Name, String LastName, String Adresse,
      String date, BuildContext context, File? Logo) async {
    if (Logo == null) {
      var snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: "Please Select Teacher Image",
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

      return;
    }
    if (date.isEmpty) {
      var snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: "Please Select Teacher BirthDate",
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

      return;
    }

    final String url = "https://ganto-app.online/public/api/insert_enseignant";

    String? base64LogoImage;

    List<int> logoBytes = await Logo!.readAsBytes();
    base64LogoImage = base64Encode(logoBytes);

    var uuid = Uuid();
    String qrData = uuid.v1();
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
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({
          "NOM_ENSEIGNANT": Name,
          "PRENOM_ENSEIGNANT": LastName,
          "ADRESSE_ENSEIGNANT": Adresse,
          "DATE_NAISSANCE_ENSEIGNANT": date,
          "QR_CODE": qrData,
          "QR_CODE_USED": false,
          "Logo": base64LogoImage
        }),
      );
      // print(response.statusCode);
      Get.back();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        var snackBar = SnackBar(
          elevation: 0,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.green,
            title: 'Notification',
            message: "Teacher Added Successefully",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Get.offNamed("/DirectorDashboard");
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
            message: jsonDecode(response.body)["error"],
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

      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> InsertModule(String Name, BuildContext c) async {
    final String url = "https://ganto-app.online/public/api/insert_matiere";
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
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({
          "LIB_MATIERE": Name,
        }),
      );

      print(response.body);
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
            message: "Module Added Succesefully",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Get.back();

        // Handle successful login (e.g., store token, navigate to home screen)
      } else {
        var data = jsonDecode(response.body);
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

  Future<void> InsertRoom(String Name, int Capacity, BuildContext c) async {
    final String url = "https://ganto-app.online/public/api/insert_salle";
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
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({"LIB_SALLE": Name, "CAPACITE_SALLE": Capacity}),
      );
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
            message: "Room Added Succesefully",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Get.back();

        // Handle successful login (e.g., store token, navigate to home screen)
      } else {
        var data = jsonDecode(response.body);
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

  Future<void> Insert_Speciality(String Name, BuildContext c) async {

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
        "https://ganto-app.online/public/api/insert_option"; // Update with actual API URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({
          "LIB_OPTION": Name,
        }),
      );
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
            message: "Speciality Added Succesefully",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);


        Get.back();

        // Handle successful login (e.g., store token, navigate to home screen)
      } else {
        var data = jsonDecode(response.body);
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

  Future<void> InsertClass(
      String Name, int SpecialityId, BuildContext c) async {
    final String url = "https://ganto-app.online/public/api/insert_class";
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
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({"ID_OPTION": SpecialityId, "CLASSE_NOM": Name}),
      );
      print(response.statusCode);
      print(response.body);
      Get.back();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
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
            message: data["message"],
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Get.back();

        // Handle successful login (e.g., store token, navigate to home screen)
      } else {
        var data = jsonDecode(response.body);
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

  Future<List> Get_Specilaities() async {
    final String url = "https://ganto-app.online/public/api/getSpecialites";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["options"]);
        return data["options"];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Module>> Get_Modules() async {
    modules.clear();  // Clear existing data
    modules.refresh(); // Refresh observable list (if RxList)

    final String url = "https://ganto-app.online/public/api/GetModules";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["modules"] is List) {
          List<Module> moduleList = (data["modules"] as List)
              .map((json) => Module.fromJson(json))
              .toList();

          modules.value = moduleList;  // Assign the properly typed list
          return moduleList;
        }
      }
    } catch (e) {
      print("Error fetching modules: $e");
    }

    return [];
  }



  Future<void> LinkModuleWithSpeciality(
      int idModule, int IdSpeciality, int Coefficient, BuildContext c) async {

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
        "https://ganto-app.online/public/api/LinkModuleWithSpeciality";


    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({
          "ID_MATIERE": idModule,
          "ID_OPTION": IdSpeciality,
          "COEFFICIENT_MATIERE": Coefficient
        }),
      );
      final data = jsonDecode(response.body);
      Get.back();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(c).clearSnackBars();


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
            message: "Link Created Succesefully",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

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

  Future<void> Insert_Trimester(
      int number, String label, BuildContext c) async {
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
        "https://ganto-app.online/public/api/insert_trimester"; // Update with actual API URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({"NUMBER_TRIMESTRE": number, "LIB_TRIMESTRE": label}),
      );
      Get.back();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
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
            message: "Trimester Added Succesefully",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(Get.context!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        Get.back();

        // Handle successful login (e.g., store token, navigate to home screen)
      } else {
        var data = jsonDecode(response.body);
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


  Future<void> deleteAccount(String Password) async {
    try {
      final url = Uri.parse('https://ganto-app.online/public/api/DeleteSchool');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
        body: jsonEncode({
          "password":Password
        })
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Account deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green
        );

        await prefs.remove("token2");
        await prefs.remove("type2");
        await prefs.remove("director");

        Get.delete<SchoolController>();
        Get.offNamed("/Company_Home");
      } else {
        print(response.body);
        var data = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          data["message"],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,

        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Exception',
        'Something went wrong: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,


      );
    }
  }
}
