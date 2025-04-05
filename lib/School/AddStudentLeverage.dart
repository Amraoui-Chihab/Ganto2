import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../Controllers/SchoolController.dart';
import '../Models/Student.dart';

class AddStudentLeverage extends StatefulWidget {
  const AddStudentLeverage({super.key});

  @override
  State<AddStudentLeverage> createState() => _AddStudentLeverageState();
}

class _AddStudentLeverageState extends State<AddStudentLeverage> {
  SchoolController _schoolControler = Get.find<SchoolController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "View All Students",
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
                  
                  List<Student> filteredStudents =
                      _schoolControler.Stduents.where((student) {
                        print(student.classeId);

                    return student.classeId == int.parse(Get.arguments[0]!);
                  }) // Change condition here
                          .toList();
                  print(filteredStudents);
                  if (filteredStudents.isEmpty) {
                    return Center(
                      child: Text(
                        "No Student Found",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      Student student = filteredStudents[index];
                      return ListTile(
                        
                        trailing: IconButton(
                            onPressed: () async{
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
                              await _schoolControler.FetchAverages(student.id);
                              Get.back();
                              Get.toNamed("/ShowAverages",parameters:{
                                "StudentId":student.id.toString(),

                              });
                            },
                            icon: Icon(
                              Icons.balance,
                              color: Colors.blue,
                            )),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(student.Logo),
                        ),
                        tileColor: Colors.grey[300],
                        title: Text(
                          student.nom + " " + student.prenom,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sexe : ${student.sexe}",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "BirthDate : ${student.dateNaissance}",
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
