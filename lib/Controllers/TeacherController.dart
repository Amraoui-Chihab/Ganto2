import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ganto_shop/Controllers/User_controller.dart';
import 'package:ganto_shop/Models/Absence.dart';
import 'package:ganto_shop/Models/FullCourse.dart';
import 'package:ganto_shop/Models/Student.dart';
import 'package:ganto_shop/Models/Teacher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import '../Models/Class.dart';
import '../Models/Exam.dart';
import '../Models/User.dart';
import '../main.dart';

class TeacherController extends GetxController {


  var teacher = Rx<Teacher?>(null);

  void updateTeacher(Teacher newTeacher) {
    teacher.value = newTeacher;
  }

  Future<void> ProgramExam(int ClassId, int ModuleId, int TrimesterId,
      int RoomId, String ExamDescription, DateTime ExamDate) async {
    try {
      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/ProgramExam'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${prefs.get("token2")}',
          },
          body: jsonEncode({
            "ClassId": ClassId,
            "ModuleId": ModuleId,
            "TrimesterId": TrimesterId,
            "RoomId": RoomId,
            "ExamDescription": ExamDescription,
            "ExamDate": ExamDate.toIso8601String(),
          }));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Notification", "Exam Programmed Successfully",
            backgroundColor: Colors.green);
        Get.toNamed("/TeacherDashboard");
      } else {
        Get.snackbar("Alert", data["error"],
            backgroundColor: Colors.red, duration: Duration(seconds: 10));
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<Map<String, dynamic>?> FetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://ganto-app.online/public/api/FetchTeacherDataForExam'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        Get.snackbar("Alert", "There Is No Exams", backgroundColor: Colors.red);

        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      return null;
    }
  }

  Future<void> AddAbscence(int CourseId, int IdStudent, String Motif) async {
    try {
      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/create_absence'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${prefs.get("token2")}',
          },
          body: jsonEncode({
            "ID_COURS": CourseId,
            "ID_ELEVE": IdStudent,
            "MOTIF": Motif,
          }));
      // print("hjgfhkjdgfkj");
      print(response.body);

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Notifiaction", data["message"],
            backgroundColor: Colors.green);
      } else {
        Get.snackbar("Alert", data["message"], backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  RxList<Class> Classes = RxList();
  Future<void> FetchClasses() async {
    try {
      final response = await http.get(
        Uri.parse('https://ganto-app.online/public/api/FetchTeacherClasses'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Classes.value = Class.listFromJson(data);

        Classes.refresh();
      } else {
        Classes.value = [];
        Classes.refresh();
        Get.snackbar("Alert", "Error For Fetching Classes",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Alert", e.toString(), backgroundColor: Colors.red);
    }
  }

  RxList<Student> Students = RxList();

  Future<void> FetchStudentOfClass(int Classid) async {
    try {
      Students.clear();
      Students.refresh();
      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/FetchStudentsOfClass'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${prefs.get("token2")}',
          },
          body: jsonEncode({"IdClass": Classid}));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Students.value = Student.fromJsonList(data["students"]);
        Students.refresh();
      } else {
        Students.value = [];
        Students.refresh();
        Get.snackbar("Alert", "Error For Fetching Courses",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  RxList<FullCourse> Courses = RxList();
  Future<void> fetchCourses() async {
    try {
      Courses.clear();
      Courses.refresh();
      final response = await http.get(
        Uri.parse('https://ganto-app.online/public/api/FetchTeacherCourses'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
      );
      print("jhgfhkjkgfdkjgfd");
      print(response.body);

      if (response.statusCode == 200) {
        Courses.value = FullCourse.listFromJson(response.body);
        Courses.refresh();
      } else {
        Courses.value = [];
        Courses.refresh();
        Get.snackbar("Alert", "Error For Fetching Courses",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<dynamic> GetAbscences(int StudentId, int IdCourse) async {
    try {
      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/GetAbscences'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${prefs.getString("token2")}',
          },
          body: jsonEncode({"StudentId": StudentId, "CourseId": IdCourse}));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data["abs"] != null)
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Motif For Absence",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                content: Text(data["abs"]["MOTIF"],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Get.back();
                    },
                    child: Text(
                      "Ok",
                      style: GoogleFonts.poppins(color: Colors.blue),
                    ),
                  ),
                ],
              );
            },
          );
        else
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "No Absence For This Student",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Get.back();
                    },
                    child: Text(
                      "Ok",
                      style: GoogleFonts.poppins(color: Colors.blue),
                    ),
                  ),
                ],
              );
            },
          );
      } else {
        Get.snackbar("Error", data.toString(), backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  RxList<Exam> Exams = RxList();
  Future<void> FetchExams() async {
    try {
      Exams.clear();
      Exams.refresh();
      final response = await http.get(
        Uri.parse('https://ganto-app.online/public/api/FetchTeacherExams'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        Exams.value = Exam.listFromJson(response.body);
        Exams.refresh();
      } else {
        Exams.value = [];
        Exams.refresh();
        Get.snackbar("Alert", "There Is No Exams", backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.get(
          Uri.parse('https://ganto-app.online/public/api/Teacher/logout'),
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

        await prefs.remove("type2");
        await  prefs.remove("teacher");
        await  prefs.remove("token2");
       Get.delete<TeacherController>();
        String? userJson = prefs.getString("user");

        Map<String, dynamic> userMap = jsonDecode(userJson!);
        User user = User.fromJson(userMap);
        if (Get.isRegistered<UserController>()) {
          // If controller already exists, update the existing school

          Get.find<UserController>().updateUser(user);
        } else {

          // If controller does not exist, create and register it
          Get.put(UserController()..updateUser(user), permanent: true);
        }

        Get.offNamed("/User_Home");
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

  RxList<Student> StudentsForNotes = RxList();
  Future<void> GetStudentsForMarkNoteOfExam(int ExamId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://ganto-app.online/public/api/GetStudentsForMarkNoteOfExam/${ExamId}'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.getString("token2")}',
        },
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        StudentsForNotes.value = Student.fromJsonList(data["students"]);
        StudentsForNotes.refresh();
      } else {
        Get.snackbar("Alert", data["error"], backgroundColor: Colors.red);
        StudentsForNotes.value = [];
        StudentsForNotes.refresh();
      }
    } catch (e) {
      StudentsForNotes.value = [];
      StudentsForNotes.refresh();
      Get.snackbar("Alert", "Error ${e.toString()}",
          backgroundColor: Colors.red);
    } finally {
      print("hgfhkjdfghjkfdkhj");
      print(StudentsForNotes);
    }
  }

  Future<void> MarkNoteForStudent(
      int ExamId, int Studentid, double Note) async {
    try {
      final response = await http.post(
          Uri.parse('https://ganto-app.online/public/api/saisir-note'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${prefs.getString("token2")}',
          },
          body: jsonEncode({"ID_EXAMEN": ExamId, "ID_ELEVE": Studentid,"NOTE_ELEVE":Note}));
      final data = jsonDecode(response.body);
      print(data);
      if(response.statusCode == 200)
        {
          Get.snackbar("Notification", data["message"],backgroundColor: Colors.green);
        }
      else{
        Get.snackbar("Error", data["error"],backgroundColor: Colors.red);
      }

    } catch (e) {
      Get.snackbar("Error", e.toString(),backgroundColor: Colors.red);
    }

  }
  Future<double?> ShowNoteForStudent(int StudentId,int ExamId)async
  {
    try
        {
          final response = await http.get(
              Uri.parse('https://ganto-app.online/public/api/GetStudentNote/$StudentId/$ExamId'),
              headers: {
                "Content-Type": "application/json",
                'Authorization': 'Bearer ${prefs.getString("token2")}',
              },

              );
          final data = jsonDecode(response.body);
          print(data);

          if(response.statusCode == 200)
            {
              return (data["note"] as num?)?.toDouble();

            }else
              {
              return null;
              }
        }
        catch(e)
    {

      Get.snackbar("Error", "Connection Error",backgroundColor: Colors.red);
      return null;

    }
  }
}
