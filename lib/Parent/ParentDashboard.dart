import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/StudentController.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentdashboardState();
}

class _ParentdashboardState extends State<ParentDashboard> {
  String currentlanguage ="English";
  StudentController _studentController = Get.find<StudentController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(

            children: [
              // Drawer Header with a Gradient Background

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [

                    SizedBox(height: 10),
                    Text(
                      "Parent Dashboard",
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.change_circle, color: Colors.blue),
                // Adjust padding for indentation
                title: Text(
                  'Change Language'.tr,
                  style: GoogleFonts.poppins(),
                ),
                onTap: () async {
                  Navigator.pop(context); // Close the drawer
                  // Implement logout functionality
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        'Choose the language you want to use '.tr,
                        style: GoogleFonts.poppins(),
                      ),
                      content: DropdownButton<String>(
                        value: currentlanguage,

                        icon: Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        dropdownColor: Colors.white,
                        style: TextStyle(color: Colors.black),
                        underline:
                        SizedBox(), // Remove default underline
                        onChanged: (String? newValue) {
                          currentlanguage = newValue!;
                          if(newValue=="English")
                          {

                            Get.updateLocale(Locale('en'));
                          }
                          else
                          {

                            Get.updateLocale(Locale('ar'));
                          }
                          Navigator.pop(context);


                        },
                        items: <String>[
                          'English',
                          'Arabic',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      /* actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, // Cancel logout
                              child:
                                  Text('Cancel', style: GoogleFonts.poppins()),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Confirm logout
                                Navigator.pop(context); // Close dialog
                                // Redirect or clear user data


                              },
                              child:
                                  Text('Ok', style: GoogleFonts.poppins()),
                            ),
                          ],*/
                    ),
                  );
                },
              ),

              // List of Menu Items


              // Logout Button
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text("Logout", style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold)),
                onTap: () async{
                  await _studentController.logout();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(

          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            "Home",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            children: [
              InkWell(
                onTap: () async{
                  await _studentController.FetchAbscences();
                  Get.toNamed("/ShowAbscences");
                } ,
                child: Card(
                  // color: Colors.green,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.2),
                          Colors.blue.withOpacity(0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Constrained Image to prevent overflow
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset(
                              "assets/absent.png",
                              fit: BoxFit
                                  .contain, // Ensures image scales within space
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Show Abscences",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async{

                  await _studentController.FetchAverages();
                 Get.toNamed("/ShowAveragesofStudent");
                },
                child: Card(
                  //color: Colors.green,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.2),
                          Colors.blue.withOpacity(0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Constrained Image to prevent overflow
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset(
                              "assets/average.png",
                              fit: BoxFit
                                  .contain, // Ensures image scales within space
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Show Averages",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                 onTap: () async{
                   await _studentController.fetchCourses();
                   Get.toNamed("/StudentCourses");
                 } ,
                child: Card(
                  // color: Colors.green,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.2),
                          Colors.blue.withOpacity(0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Constrained Image to prevent overflow
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset(
                              "assets/showcourses.png",
                              fit: BoxFit
                                  .contain, // Ensures image scales within space
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Show Courses",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  await _studentController.FetchExams();
                  Get.toNamed("/StudentExams");

                } ,
                child: Card(
                  // color: Colors.green,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.2),
                          Colors.blue.withOpacity(0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Constrained Image to prevent overflow
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image.asset(
                              "assets/exam.png",
                              fit: BoxFit
                                  .contain, // Ensures image scales within space
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Show Exams",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),





            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
