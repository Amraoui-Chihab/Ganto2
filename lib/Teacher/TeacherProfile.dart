import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/TeacherController.dart';

class TeacherProfile extends StatelessWidget {
  final TeacherController _teacherController = Get.find<TeacherController>();

  TeacherProfile({super.key}) {
    print("Profile of teacher");
    print(_teacherController.teacher.value!.toJson().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildTeacherInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60,
            backgroundImage: NetworkImage(_teacherController.teacher.value!.Logo),
          )),
          SizedBox(height: 15),
          Obx(() => Text(
            _teacherController.teacher.value!.nom,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTeacherInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField("Last Name", _teacherController.teacher.value!.prenom),
          _buildField("Address", _teacherController.teacher.value!.adresse),
          _buildField("Birth Date", _teacherController.teacher.value!.dateNaissance),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
             // Icon(Icons.edit, color: Colors.blue),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}