

import 'package:flutter/material.dart';
import 'package:Ganto/Controllers/StudentController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/Average.dart';
class ShowAveragesofStudent extends StatefulWidget {
  const ShowAveragesofStudent({super.key});

  @override
  State<ShowAveragesofStudent> createState() => _ShowAveragesofStudentState();
}

class _ShowAveragesofStudentState extends State<ShowAveragesofStudent> {

  StudentController _studentController = Get.find<StudentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "View Averages",
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
                    if (_studentController.averages.isEmpty) {
                      return Center(
                        child: Text(
                          "No Average Yet",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      );
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                      itemCount: _studentController.averages.length,
                      itemBuilder: (context, index) {
                        Average average = _studentController.averages[index];
                        return ListTile(
                            tileColor: Colors.grey[300],
                            title: Text(
                              "average : " + average.average_note.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TrimesterId : " +
                                      average.Trimester_Id.toString(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Trimester Name : " +
                                      average.Trimester_lib.toString(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ));
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
