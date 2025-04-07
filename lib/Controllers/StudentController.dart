import 'package:Ganto/Models/Student.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Models/Absence.dart';
import '../Models/Average.dart';
import '../Models/Exam.dart';
import '../Models/FullCourse.dart';
import 'package:http/http.dart' as http;

import '../Models/User.dart';
import '../main.dart';
import 'dart:convert';

import 'User_controller.dart';
class StudentController extends GetxController {


  var student = Rx<Student?>(null);


  void updateSTudent(Student newstudent) {
    student.value = newstudent;
  }

  RxList<FullCourse> Courses = RxList();



  Future<void> fetchCourses() async {
    try {
      Courses.clear();
      Courses.refresh();
      final response = await http.get(
        Uri.parse('https://ganto-app.online/public/api/FetchStudentCourses'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
      );
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
  RxList<Absence> Abscences = RxList();
  Future<void> FetchAbscences() async {
    try {
      Abscences.clear();
      Abscences.refresh();
      final response = await http.get(
        Uri.parse('https://ganto-app.online/public/api/getAbsencesByEleve'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final data =  json.decode(response.body);;
        List<dynamic> jsonData = data["data"]["absences"];

        // Convert JSON list to List<Absence>
        Abscences.value =   jsonData.map((item) => Absence.fromJson(item)).toList();
        Abscences.refresh();
      } else {
        Abscences.value = [];
        Abscences.refresh();
       // Get.snackbar("Error", "Failed to load absences", backgroundColor: Colors.red);

      }
    } catch (e) {
      Abscences.value = [];
      Abscences.refresh();

      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);

    }
  }

  RxList<Average> averages = RxList();
  Future<void> FetchAverages()async
  {
    try {
      averages.clear();
      averages.refresh();
      final response = await http.get(
        Uri.parse('https://ganto-app.online/public/api/FetchStudentAverages'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ;
        List<dynamic> jsonData = data["averages"];

        // Convert JSON list to List<Absence>
        averages.value =
            jsonData.map((item) => Average.fromJson(item)).toList();
        averages.refresh();
      } else {
        averages.value = [];
        averages.refresh();
        //Get.snackbar("Error", "Failed to load absences", backgroundColor: Colors.red);

      }
    } catch (e) {
      averages.value = [];
      averages.refresh();

      Get.snackbar("Error", "Connection Error", backgroundColor: Colors.red);
    }
    finally{
      print(averages);
    }
  }

  Future<void> logout() async {

    try {
      final response = await http.get(
          Uri.parse('https://ganto-app.online/public/api/Parent/logout'),
          headers: {
            'Authorization': 'Bearer ${prefs.getString("token2")}',
          });

      if (response.statusCode == 200) {
        /*Get.put(GeneralController());
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
        await  prefs.remove("student");
        await  prefs.remove("token2");


        Get.delete<StudentController>();

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
        Get.snackbar("Alert", "Error with code ${response.statusCode}",
            backgroundColor: Colors.red);

      }
    } catch (e) {
      Get.snackbar("Alert", "Error ${e.toString()}",
          backgroundColor: Colors.red);

    }
  }
  RxList<Exam> exams = RxList();
  Future<void> FetchExams()async{
    try
        {
          exams.clear();
          exams.refresh();

          final response = await http.get(
            Uri.parse('https://ganto-app.online/public/api/GetStudentExams'),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer ${prefs.get("token2")}',
            },
          );

          if(response.statusCode == 200)
            {

              exams.value = Exam.listFromJson(response.body);
              exams.refresh();

            }
          else
            {
              Get.snackbar("Notification", "There Is No Exam",backgroundColor: Colors.red);
              exams.value = [];
              exams.refresh();
            }



        }
        catch(e)
    {

      exams.value = [];
      exams.refresh();
      Get.snackbar("Error", "Connection Error",backgroundColor: Colors.red);
    }


  }


  Future<double?> FetchNoteInExam(int IdExam)async{
    try
    {


      final response = await http.get(
        Uri.parse('https://ganto-app.online/public/api/GetStudentNoteInExam/${IdExam}'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${prefs.get("token2")}',
        },
      );
      final data = jsonDecode(response.body);
      print("******");
      print((data["note"] as num?)?.toDouble());

      if(response.statusCode == 200)
      {

        return (data["note"] as num?)?.toDouble();


      }
      else
      {
        Get.snackbar("Notification", "There Is No Note Yet",backgroundColor: Colors.red);
        return null;
      }



    }
    catch(e)
    {
      print(e);
      Get.snackbar("Error", "Connection Error",backgroundColor: Colors.red);
      return null;


    }
  }


}
