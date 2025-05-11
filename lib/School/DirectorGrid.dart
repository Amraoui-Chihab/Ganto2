import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../Controllers/SchoolController.dart';

class DirectorGrid extends StatefulWidget {
  const DirectorGrid({super.key});

  @override
  State<DirectorGrid> createState() => _DirectorGridState();
}

class _DirectorGridState extends State<DirectorGrid> {
  SchoolController _schoolControler = Get.find<SchoolController>();
  //List<String> items = List.generate(20, (index) => 'Item $index');

  Widget _buildDrawerItem(String PhotoPath, String title, BuildContext context,
      Function()? _ontap) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(PhotoPath),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
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
                    "School Dashboard",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // List of Menu Items
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(
                    "assets/addteacher.png",
                    "View All Teachers",
                    context,
                    () async {
                      await _schoolControler.GetTeachers();
                      Get.toNamed("/ViewTeachers");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/addstudent.png",
                    "View All Students",
                    context,
                    () async {
                      await _schoolControler.GetStudents();
                      Get.toNamed("/ViewStudents");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/addclass.png",
                    "View All Classes",
                    context,
                    () async {
                      await _schoolControler.GetClasses();
                      //  print(_schoolControler.Classes.toJson());

                      Get.toNamed("/ViewClasses");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/addtrimester.png",
                    "View All Trimesters",
                    context,
                    () async {
                      await _schoolControler.GetTrimesters();

                      Get.toNamed("/ViewTrimesters");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/addroom.png",
                    "View All Rooms",
                    context,
                    () async {
                      await _schoolControler.GetRooms();
                      print(_schoolControler.Rooms);
                      Get.toNamed("/ViewRooms");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/addspeciality.png",
                    "View All Specialities",
                    context,
                    () async {
                      await _schoolControler.GetSpecialities();

                      print(_schoolControler.Specialities);
                      Get.toNamed("/ViewSpecialities");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/addmodule.png",
                    "View All Modules",
                    context,
                    () async {
                      await _schoolControler.GetModules();

                      Get.toNamed("/ViewModules");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/Link.png",
                    "View Links Between Modules And Specialities",
                    context,
                    () async {
                      await _schoolControler.GetLinks();
                      Get.toNamed("/ViewLinks");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/programcourse.png",
                    "View Courses",
                    context,
                    () async {
                      //await _schoolControler.GetCourses();

                      await _schoolControler.GetTeachers();

                      Get.toNamed("/ViewTeachersForCourses");
                    },
                  ),
                  _buildDrawerItem(
                    "assets/average.png",
                    "View Averages",
                    context,
                    () async {
                      //await _schoolControler.GetCourses();

                      await _schoolControler.GetClasses();
                      Get.toNamed("/Viewclassesforaverage");
                    },
                  )
                  /* _buildDrawerItem(Icons.settings, "Settings", context,() => print("hdghjkjgf"),),
                  _buildDrawerItem(Icons.notifications, "Notifications", context,() => print("hdghjkjgf"),),
                  _buildDrawerItem(Icons.help, "Help & Support", context,() => print("hdghjkjgf"),),*/
                ],
              ),
            ),

            // Logout Button
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: Text(
                'Delete Account'.tr,
                style: GoogleFonts.poppins(color: Colors.red),
              ),
              onTap: () {
                // Handle Logout
                Navigator.pop(context); // Close the drawer
                // Implement logout functionality
                TextEditingController passwordController = TextEditingController();

                showDialog(
                  context: context,
                  builder: (context) {
                    bool _obscurePassword = true;
                    return StatefulBuilder(
                      builder: (context, setState) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          'Delete'.tr,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Please Enter Your Password To Confirm Account Delete'.tr,
                              style: GoogleFonts.poppins(),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                hintText: 'Enter your password'.tr,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel'.tr,
                              style: GoogleFonts.poppins(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (passwordController.text.isEmpty) {
                                Get.snackbar("Alert", "Please Enter Your Password",
                                    backgroundColor: Colors.red);
                              } else {
                                Navigator.pop(context);
                                await _schoolControler.deleteAccount(passwordController.text);
                              }
                            },
                            child: Text(
                              'Delete'.tr,
                              style: GoogleFonts.poppins(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text("Logout",
                  style: GoogleFonts.poppins(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () async {
                await _schoolControler.logout();
              },
            ),
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
              onTap: () => Get.toNamed("/AddTeacher"),
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
                            "assets/addteacher.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Add Teacher",
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
              onTap: () {

                Get.toNamed("/AddStudent");
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
                            "assets/addstudent.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Add Student",
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
              onTap: () async {
                Get.dialog(
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(20), // Add padding for spacing
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Wraps content properly
                          children: [
                            Lottie.asset('assets/loading.json',
                                width: 100, height: 100, fit: BoxFit.fitHeight),
                            SizedBox(
                                width:
                                    10), // Add spacing between animation and text
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
                await _schoolControler.GetSpecialities();
                Get.back();
                Get.toNamed("/AddClass");
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
                            "assets/addclass.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Add Class",
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
              onTap: () {
                Get.toNamed("/AddTrimester");
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
                            "assets/addtrimester.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Add Trimester",
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
              onTap: () => Get.toNamed("/AddRoom"),
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
                            "assets/addroom.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Add Room",
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
              onTap: () => Get.toNamed("/AddOption"),
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
                            "assets/addspeciality.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Add Speciality",
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
              onTap: () => Get.toNamed("/AddModule"),
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
                            "assets/addmodule.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Add Module",
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
              onTap: () async {
                Get.dialog(
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(20), // Add padding for spacing
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Wraps content properly
                          children: [
                            Lottie.asset('assets/loading.json',
                                width: 100, height: 100, fit: BoxFit.fitHeight),
                            SizedBox(
                                width:
                                    10), // Add spacing between animation and text
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
                await _schoolControler.GetModules();
                await _schoolControler.GetSpecialities();
                Get.back();
                Get.toNamed("/LinkModuleSpeciality");
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
                            "assets/Link.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Link Module With Speciality",
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
              onTap: () => Get.toNamed("/AddCourse"),
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
                            "assets/programcourse.png",
                            fit: BoxFit
                                .contain, // Ensures image scales within space
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Program Course For Teacher",
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
              onTap: () async {
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
                await _schoolControler.GetClasses();
                Get.back();
                Get.toNamed("/Viewclassesforaverage");
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
                          "Add Average",
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
            )
          ],
        ),
      ),
    );
  }
}
