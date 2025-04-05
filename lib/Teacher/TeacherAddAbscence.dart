import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/TeacherController.dart';
import '../Models/Student.dart';

class TeacherAddAbscence extends StatefulWidget {
  const TeacherAddAbscence({super.key});

  @override
  State<TeacherAddAbscence> createState() => _TeacherAddAbscenceState();
}

class _TeacherAddAbscenceState extends State<TeacherAddAbscence> {
  late int IdCourse;

  @override
  void initState() {
    IdCourse = Get.arguments["IdCourse"];


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // TODO: implement dispose
    super.dispose();
  }

  TeacherController _teacherController = Get.find<TeacherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "AddAbscence",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Please Select A Student To Mark Absence",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              padding: EdgeInsets.symmetric(horizontal: 12), // Inner padding
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        hintText: "Filter Students",
                        border: InputBorder.none, // Removes borders
                      ),
                    ),
                  ),
                  /* IconButton(
                    onPressed: () {}, // Handle edit logic later
                    icon: Icon(Icons.edit, color: Colors.blue),
                  ),*/
                ],
              ),
            ),
            Obx(
              () => Expanded(
                // Makes ListView take the remaining space
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Student student =
                        _teacherController.Students[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            TextEditingController motifcontroller = TextEditingController();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    "Add Motif For Absence",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                  ),
                                  content: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: TextField(
                                      controller: motifcontroller,
                                      decoration: InputDecoration(
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        hintText: "Please Enter Motif",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        await _teacherController.AddAbscence(
                                            IdCourse, student.id, motifcontroller.text);
                                      },
                                      child: Text(
                                        "Ok",
                                        style: GoogleFonts.poppins(color: Colors.blue),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.poppins(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        tileColor: Colors.grey[200],
                        title: Text(
                          "Name: ${student.nom}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis, // Prevents text overflow
                          maxLines: 1,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
                          children: [
                            Text(
                              "LastName: ${student.prenom}",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              "Sexe: ${student.sexe}",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              "BirthDate: ${student.dateNaissance}",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: 5), // Adds spacing before the button
                            SizedBox(
                              width: double.infinity, // Ensures the button takes full width
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Handle button action
                                  _teacherController.GetAbscences(student.id,IdCourse);

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(double.infinity, 30),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // Centers content
                                  mainAxisSize: MainAxisSize.min, // Prevents overflow
                                  children: [
                                    Text(
                                      "Show Absences",
                                      style: GoogleFonts.poppins(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.visibility, size: 18,color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        leading: CircleAvatar(),
                      )
                        ,
                    );
                  },
                  itemCount: _teacherController.Students.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
