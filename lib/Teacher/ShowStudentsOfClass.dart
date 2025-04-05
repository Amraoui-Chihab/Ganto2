

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/TeacherController.dart';
import '../Controllers/TeacherController.dart';
import '../Models/Student.dart';

class Showstudentsofclass extends StatefulWidget {
  const Showstudentsofclass({super.key});

  @override
  State<Showstudentsofclass> createState() => _ShowstudentsofclassState();
}

class _ShowstudentsofclassState extends State<Showstudentsofclass> {
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
          "Class Students",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Obx(
                  () => Expanded(
                // Makes ListView take the remaining space
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Student student = _teacherController.Students[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: ListTile(

                        tileColor: Colors.grey[200],
                        title: Text(
                          "Name : "+ student.nom,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LastName : "+ student.prenom,
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Sexe : "+ student.sexe,
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "BirthDate : "+ student.dateNaissance,
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                        leading: CircleAvatar(),
                      ),
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
