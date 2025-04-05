import 'package:ganto_shop/Controllers/TeacherController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  TeacherController _teacherController = Get.find<TeacherController>();

  String currentlanguage = "English";

  Widget _buildDrawerItem(
      IconData icon, String title, BuildContext context, Function()? _ontap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title,
          style:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: _ontap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Teacher Dashboard",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
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

                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      dropdownColor: Colors.white,
                      style: TextStyle(color: Colors.black),
                      underline: SizedBox(), // Remove default underline
                      onChanged: (String? newValue) {
                        currentlanguage = newValue!;
                        if (newValue == "English") {
                          Get.updateLocale(Locale('en'));
                        } else {
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
                  ),
                );
              },
            ),

            // List of Menu Items
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text("Logout",
                  style: GoogleFonts.poppins(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () async {
                // await _schoolControler.logout();

                await _teacherController.logout();
              },
            ),

            // Logout Button
          ],
        ),
      ),
      backgroundColor: Colors.white,
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
              onTap: () async {
                await _teacherController.fetchCourses();

                if (_teacherController.Courses.isEmpty) {
                  Get.snackbar("Alert", "You Do Not Have Courses",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 7));
                } else {
                  Get.toNamed("/TeacherCourses");
                }
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
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
            /* InkWell(
              //onTap: () => Get.toNamed("/AddTeacher"),
              child: Card(
                color: Colors.grey[200],
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Create Abscence",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),*/
            InkWell(
              onTap: ()async {
                //Get.toNamed("/AddStudent");


                await _teacherController.FetchExams();


               Get.toNamed("/TeacherExams");

              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
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
            InkWell(
              onTap: ()async {

                await _teacherController.FetchClasses();


                if (_teacherController.Classes.isEmpty) {
                  Get.snackbar("Alert", "You Do Not Have Classes",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 7));
                } else {
                  Get.toNamed("/ShowClasses");
                 // Get.toNamed("/TeacherCourses");
                }
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
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
                            "assets/class.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Show Classes",
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

            /*  InkWell(
              // onTap: () => Get.toNamed("/AddClass"),
              child: Card(
                color: Colors.grey[200],
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Show Classes",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Get.toNamed("/AddTrimester");
              },
              child: Card(
                color: Colors.grey[200],
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Show Students",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
