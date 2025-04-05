import 'package:flutter/material.dart';
import 'package:ganto_shop/About_Us.dart';
import 'package:ganto_shop/Company/CompanyHome.dart';
import 'package:ganto_shop/Company/company_login.dart';
import 'package:ganto_shop/Company/company_signup.dart';
import 'package:ganto_shop/Intro/intro_page2.dart';
import 'package:ganto_shop/Onboarding/Onboarding.dart';
import 'package:ganto_shop/School/AddClass.dart';
import 'package:ganto_shop/School/AddModule.dart';
import 'package:ganto_shop/School/AddOption.dart';
import 'package:ganto_shop/School/AddTeacher.dart';
import 'package:ganto_shop/School/AddTrimester.dart';
import 'package:ganto_shop/School/ScheduleGrid.dart';
import 'package:ganto_shop/School/ViewClasses.dart';
import 'package:ganto_shop/School/ViewLinks.dart';
import 'package:ganto_shop/School/ViewStudents.dart';
import 'package:ganto_shop/Teacher/TeacheCourses.dart';
import 'package:ganto_shop/Translations/AppTranslations.dart';
import 'package:ganto_shop/User/User_Home.dart';
import 'package:ganto_shop/User/User_login.dart';
import 'package:ganto_shop/User/User_signup.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Company/CompanyLoginemail.dart';
import 'Company/CompanySignupemail.dart';
import 'Company/CompanySignupphone.dart';
import 'Company/Companyloginphone.dart';

import 'Middlewares/InitialMiddleware.dart';
import 'Parent/ShowAbscences.dart';
import 'Parent/ShowAveragesofStudent.dart';
import 'Parent/ShowStudentCourses.dart';
import 'School/AddCourse.dart';
import 'School/AddRoom.dart';
import 'School/AddStudent.dart';
import 'School/AddStudentLeverage.dart';
import 'School/CreateNewSchool.dart';
import 'School/DirectorDashboard.dart';
import 'School/DirectorShowTeacherCourses.dart';
import 'School/LinkModuleSpeciality.dart';
import 'Parent/ParentDashboard.dart';
import 'School/SchoolLogin.dart';
import 'School/ShowAverages.dart';
import 'Parent/ShowStudentExams.dart';
import 'School/ViewClassesForAverage.dart';
import 'School/ViewModules.dart';
import 'School/ViewRooms.dart';
import 'School/ViewSpecialities.dart';
import 'School/ViewTeachers.dart';
import 'School/ViewTeachersForCourses.dart';
import 'School/ViewTrimesters.dart';
import 'Teacher/MarkNoteForStudent.dart';
import 'Teacher/ShowClasses.dart';
import 'Teacher/ShowStudentsOfClass.dart';
import 'Teacher/TeacherAddAbscence.dart';
import 'Teacher/TeacherDashboard.dart';
import 'Teacher/TeacherExams.dart';
import 'Teacher/TeacherProgramExam.dart';
import 'User/User_Login_email.dart';
import 'User/User_Signup_phone.dart';
import 'User/User_signup_email.dart';
import 'User/userloginphone.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      translations: AppTranslations(), // Set the AppTranslations class
      locale: Locale('en', 'US'), // Set the initial locale

      initialRoute: "/",
      getPages: [

        GetPage(name: "/Company_Home", page: () => Companyhome()),

        GetPage(name: "/About_Us", page: () => AboutUsPage()),





        GetPage(
          name: "/User_Home",
          page: () => UserHome(),
        ),

        GetPage(
          name: "/",
          page: () => Onboarding(),
            middlewares: [initialMiddleware()]
        ),


        GetPage(name: "/Create_School", page: () => CreateNewSchoolPage()),
        GetPage(name: "/School_Login", page: () => SchoolLoginPage()),
        GetPage(name: "/DirectorDashboard", page: () => Directordashboard()),
        GetPage(name: "/ParentDashboard", page: () => ParentDashboard()),
        GetPage(name: "/TeacherDashboard", page: ()=>TeacherDashboard()),
        GetPage(name: "/Grid", page: () => MonthlyScheduleGrid()),
        GetPage(name: "/AddClass", page: () => AddClass()),
        GetPage(name: "/AddOption", page: () => AddOption()),
        GetPage(name: "/AddModule", page: () => AddModule()),
        GetPage(name: "/StudentExams", page: ()=>ShowStudentExams()),
        GetPage(name: "/StudentCourses", page: ()=>ShowStudentCourses()),
        GetPage(name: "/TeacherCourses", page: ()=>ShowTeacherCourses()),
        GetPage(name: "/TeacherAddAbscence", page: ()=>TeacherAddAbscence()),



        GetPage(name: "/TeacherProgramExam", page: ()=>TeacherProgramExam()),

        GetPage(name: "/TeacherExams", page: ()=>TeacherExams()),
        GetPage(name: "/MarkStduentNote", page: ()=>MarkNoteForStudent()),

        GetPage(
            name: "/LinkModuleSpeciality", page: () => LinkModuleSpeciality()),
        GetPage(name: "/AddRoom", page: () => AddRoom()),
        GetPage(name: "/AddTrimester", page: () => AddTrimester()),
        GetPage(name: "/AddTeacher", page: () => AddTeacher()),
        GetPage(name: "/AddCourse", page: () => AddCourse()),
        GetPage(name: "/AddStudent", page: () => AddStudent()),
        GetPage(name: "/ViewTeachers", page: () => ViewTeachers()),
        GetPage(name: "/ViewStudents", page: () => ViewStudents()),
        GetPage(name: "/ViewClasses", page: () => ViewClasses()),
        GetPage(name: "/ViewTrimesters", page: () => ViewTrimesters()),
        GetPage(name: "/ViewRooms", page: () => ViewRooms()),
        GetPage(name: "/ViewSpecialities", page: () => ViewSpecialities()),
        GetPage(name: "/ViewModules", page: () => ViewModules()),
        GetPage(name: "/ViewLinks", page: () => ViewLinks()),
        GetPage(name: "/ViewTeachersForCourses", page: () => ViewTeachersForCourses()),
        GetPage(name: "/Directorshowteachercourses", page: () => Directorshowteachercourses()),

        GetPage(name: "/Viewclassesforaverage", page: () => Viewclassesforaverage()),
        GetPage(name: "/AddStudentLeverage", page: () => AddStudentLeverage()),
        GetPage(name: "/ShowAverages", page: () => ShowAverages()),

        GetPage(name: "/ShowAveragesofStudent", page: ()=>ShowAveragesofStudent()),



        GetPage(name: "/ShowClasses", page: () => ShowClasses()),

        GetPage(name: "/ShowStudentsOfClass", page:() => Showstudentsofclass()),

        GetPage(name: "/ShowAbscences", page: () => ShowAbscences()),

        GetPage(
          name: "/user_signup",
          page: () => UserSignup(),
        ),
        GetPage(
          name: "/intro",
          page: () => IntroductionPage2(),
        ),
        GetPage(
          name: "/company_login",
          page: () => CompanyLogin(),
        ),
        GetPage(
          name: "/company_signup",
          page: () => CompanySignup(),
        ),
        GetPage(
          name: "/CompanyLoginEmail",
          page: () => Companyloginemail(),
        ),
        GetPage(
          name: "/CompanyLoginPhone",
          page: () => Companyloginphone(),
        ),
        GetPage(
          name: "/company_singup_email",
          page: () => CompanySignupemail(),
        ),
        GetPage(
          name: "/company_singup_phone",
          page: () => CompanySignupphone(),
        ),
        GetPage(
          name: "/user_login",
          page: () => UserLogin(),
        ),
        GetPage(name: "/UserLoginEmail", page: () => UserLoginEmail()),
        GetPage(name: "/userloginphone", page: () => userloginphone()),
        GetPage(
          name: "/user_singup_email",
          page: () => UserSignupemail(),
        ),
        GetPage(
          name: "/user_singup_phone",
          page: () => UserSignupphone(),
        )
      ],
      title: 'Ganto',
      debugShowCheckedModeBanner: false,
    );
  }
}
