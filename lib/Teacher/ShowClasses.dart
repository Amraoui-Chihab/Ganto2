

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/TeacherController.dart';
import '../Models/Class.dart';
class ShowClasses extends StatefulWidget {
  const ShowClasses({super.key});

  @override
  State<ShowClasses> createState() => _ShowClassesState();
}

class _ShowClassesState extends State<ShowClasses> {

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
          "Your Classes",
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
                    Class classe = _teacherController.Classes[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () {

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      "Do You Want To View Students ?",
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                    ),


                                    actions: [
                                      TextButton(
                                        onPressed: () async{
                                          Get.back();
                                          await _teacherController.FetchStudentOfClass(classe.classId);
                                          Get.toNamed("/ShowStudentsOfClass");
                                         // await _teacherController.AddAbscence(IdCourse,student.id,motifcontroller.text);
                                          /*  await _teacherController.FetchStudentOfClass(course.classeId);
                                          Navigator.of(context).pop();

                                          Get.toNamed("/TeacherAddAbscence",arguments: {
                                            "IdCourse" : course.idCours,
                                          });*/
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
                              Icons.visibility_sharp,
                              color: Colors.blue,
                            )),
                        tileColor: Colors.grey[200],
                        title: Text(
                          "ClassId : "+ classe.classId.toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ClassName : "+ classe.className,
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            ),

                          ],
                        ),
                        leading: SizedBox.shrink(),
                      ),
                    );
                  },
                  itemCount: _teacherController.Classes.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
