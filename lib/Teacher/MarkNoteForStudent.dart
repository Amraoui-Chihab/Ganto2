import 'package:flutter/material.dart';
import 'package:ganto_shop/Controllers/TeacherController.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MarkNoteForStudent extends StatefulWidget {
  const MarkNoteForStudent({super.key});

  @override
  State<MarkNoteForStudent> createState() => _MarkNoteForStudentState();
}

class _MarkNoteForStudentState extends State<MarkNoteForStudent> {
  TeacherController _teacherController = Get.find<TeacherController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Mark Note For Students",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) => Container(
            child: ListTile(
              tileColor: Colors.grey[200],
              title: Text(
                "Name : " + _teacherController.StudentsForNotes[index].nom,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LastName : " +
                        _teacherController.StudentsForNotes[index].prenom,
                    style: GoogleFonts.poppins(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Sexe : " + _teacherController.StudentsForNotes[index].sexe,
                    style: GoogleFonts.poppins(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "BirthDate : " +
                        _teacherController
                            .StudentsForNotes[index].dateNaissance,
                    style: GoogleFonts.poppins(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width:
                        double.infinity, // Ensures the button takes full width
                    child: ElevatedButton(
                      onPressed: () async {
                        double? Note = await _teacherController.ShowNoteForStudent(
                            _teacherController.StudentsForNotes[index].id,
                            int.parse(Get.parameters["ExamId"]!));

                        if (Note != null) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actions: [
                                ActionChip(

                                  label: Text("Ok"),
                                  onPressed: () => Get.back(),
                                  color: MaterialStateProperty.all(Colors.blue),
                                )
                              ],
                              title: Text(
                                "Note : ${Note}",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          );
                        } else {
                          Get.snackbar("Notification", "No Note Yet",
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 7));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 30),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Centers content
                        mainAxisSize: MainAxisSize.min, // Prevents overflow
                        children: [
                          Text(
                            "Show Note",
                            style: GoogleFonts.poppins(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.visibility,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
              ),
              trailing: IconButton(
                  onPressed: () {
                    TextEditingController NoteController =
                        new TextEditingController();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Mark Note For This Student",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        content: TextFormField(
                          controller: NoteController,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            hintText: "Please Enter Note",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue), // Blue border
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .blue), // Blue border when not focused
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2), // Thicker blue border when focused
                            ),
                          ),
                        ),
                        actions: [
                          ActionChip(
                            onPressed: () async {
                              Get.back();
                              await _teacherController.MarkNoteForStudent(
                                  int.parse(Get.parameters["ExamId"]!),
                                  _teacherController.StudentsForNotes[index].id,
                                  double.parse(NoteController.text));
                            },
                            color: MaterialStateProperty.all(Colors.blue),
                            label: Text("Ok"),
                            backgroundColor: Colors.blue,
                          ),
                          ActionChip(
                            onPressed: () => Get.back(),
                            color: MaterialStateProperty.all(Colors.red),
                            label: Text("Cancel"),
                            backgroundColor: Colors.blue,
                          )
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          ),
          itemCount: _teacherController.StudentsForNotes.length,
        ),
      ),
    );
  }
}
