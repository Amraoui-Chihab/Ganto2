import 'dart:convert';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:ganto_shop/Controllers/Company_controller.dart';
import 'package:ganto_shop/Controllers/SchoolController.dart';
import 'package:ganto_shop/Controllers/StudentController.dart';
import 'package:ganto_shop/Controllers/TeacherController.dart';
import 'package:ganto_shop/Models/Company.dart';
import 'package:ganto_shop/Models/School.dart';
import 'package:ganto_shop/main.dart';
import 'package:get/get.dart';


import '../Controllers/User_controller.dart';
import '../Models/Student.dart';
import '../Models/Teacher.dart';
import '../Models/User.dart';

class initialMiddleware extends GetMiddleware {

  bool isnotAuthenticated = false;




  @override
  RouteSettings? redirect(String? route) {
    print(prefs.getString("type"));
    print(prefs.getString("type2"));


    if(prefs.getString("type2")=="teacher")
      {
        String? teacherJson = prefs.getString("teacher");

        Map<String, dynamic> userMap = jsonDecode(teacherJson!);
        Teacher teacher = Teacher.fromJson(userMap); // Convert to User object


        if (Get.isRegistered<TeacherController>()) {
          // If controller already exists, update the existing school
          print("registred teacher");
          Get.find<TeacherController>().updateTeacher(teacher);
        } else {
          print("not registred teacher");
          // If controller does not exist, create and register it
          Get.put(TeacherController()..updateTeacher(teacher), permanent: true);
        }

        return RouteSettings(name: "/TeacherDashboard");

      }
    if(prefs.getString("type2")=="parent")
    {
      String? StudentJson = prefs.getString("student");

      Map<String, dynamic> userMap = jsonDecode(StudentJson!);
      Student student = Student.fromJson(userMap); // Convert to User object


      if (Get.isRegistered<StudentController>()) {
        // If controller already exists, update the existing school
        print("registred student");
        Get.find<StudentController>().updateSTudent(student);
      } else {
        print("not registred student");
        // If controller does not exist, create and register it
        Get.put(StudentController()..updateSTudent(student), permanent: true);
      }

      return RouteSettings(name: "/ParentDashboard");

    }
    if( prefs.getString("type")=="user")
    {

      String? userJson = prefs.getString("user");

      Map<String, dynamic> userMap = jsonDecode(userJson!);
      User user = User.fromJson(userMap); // Convert to User object


      if (Get.isRegistered<UserController>()) {
        // If controller already exists, update the existing school
        print("registred user");
        Get.find<UserController>().updateUser(user);
      } else {
        print("not registred user");
        // If controller does not exist, create and register it
        Get.put(UserController()..updateUser(user), permanent: true);
      }

      return RouteSettings(name: "/User_Home");
    }


    if(prefs.getString("type2")=="director")
      {
        String? directorJson = prefs.getString("director");

        Map<String, dynamic> DirectorMap = jsonDecode(directorJson!);
        School school = School.fromJson(DirectorMap);

        if (Get.isRegistered<SchoolController>()) {
          // If controller already exists, update the existing school
          print("registred School");
          Get.find<SchoolController>().updateSchool(school);
        } else {
          print("not registred School");
          // If controller does not exist, create and register it
          Get.put(SchoolController()..updateSchool(school), permanent: true);
        }

        return RouteSettings(name: "/DirectorDashboard");
      }

    if( prefs.getString("type")=="company")
    {


      String? companyJson = prefs.getString("company");

      Map<String, dynamic> userMap = jsonDecode(companyJson!);
      Company company = Company.fromJson(userMap);
      if (Get.isRegistered<CompanyController>()) {
        // If controller already exists, update the existing school
        print("registred company");
        Get.find<CompanyController>().updateCompany(company);
      } else {
        print("not registred company");
        // If controller does not exist, create and register it
        Get.put(CompanyController()..updateCompany(company), permanent: true);
      }
      return RouteSettings(name: "/Company_Home");
    }

  }
  
}
