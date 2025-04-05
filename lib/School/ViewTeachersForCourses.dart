

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/SchoolController.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/Teacher.dart';
class ViewTeachersForCourses extends StatefulWidget {
  const ViewTeachersForCourses({super.key});

  @override
  State<ViewTeachersForCourses> createState() => _ViewTeachersForCoursesState();
}

class _ViewTeachersForCoursesState extends State<ViewTeachersForCourses> {

  SchoolController _schoolControler = Get.find<SchoolController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Select Teacher",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (_schoolControler.Teachers.isEmpty) {
                    return Center(
                      child: Text("No Teacher Found"),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.Teachers.length,
                    itemBuilder: (context, index) {
                      Teacher teacher = _schoolControler.Teachers[index];
                      return ListTile(
                        trailing: IconButton(
                            onPressed: () async{

                              await _schoolControler.GetCourses(teacher.id);
                              if(_schoolControler.Courses.isNotEmpty)
                              Get.toNamed("/Directorshowteachercourses");

                            },
                            icon: Icon(
                              Icons.visibility,
                              color: Colors.blue,
                            )),
                        leading: CircleAvatar(),
                        tileColor: Colors.grey[300],
                        title: Text(
                          teacher.nom + " " + teacher.prenom,
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Adresse : ${teacher.adresse}",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "BirthDate : ${teacher.dateNaissance}",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
