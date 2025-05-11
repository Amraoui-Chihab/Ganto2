import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/SchoolController.dart';


class SchoolProfile extends StatelessWidget {
  SchoolController _schoolController = Get.find<SchoolController>();
  SchoolProfile({super.key});

  @override
  Widget build(BuildContext context) {
    print(_schoolController.school.value!.Logo);
    print("*************");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
              height: Get.height * 0.4,
              width: Get.width,
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
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        _schoolController.school.value!.Logo,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            "School Name : " +
                                _schoolController.school.value!.schoolName,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                      SizedBox(
                        width: 15,
                      ),
                     /* Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit, color: Colors.blue),
                            iconSize: 25, // Adjust icon size if needed
                            padding: EdgeInsets.zero, // Removes default padding
                            constraints:
                                BoxConstraints(), // Removes default constraints
                          ),
                        ),
                      )*/
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
                child: Container(
              width: Get.width * 9 / 10,
              //color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Obx(() => BuildFieldData("School Email",
                      _schoolController.school.value!.schoolEmail)),*/
                  Obx(() => BuildFieldData("School Phone",
                      _schoolController.school.value!.schoolPhone)),
                  Obx(() => BuildFieldData("Director Name",
                      _schoolController.school.value!.directorName)),
                  Obx(() => BuildFieldData("Director LastName",
                      _schoolController.school.value!.directorLastname)),
                  Obx(() => BuildFieldData(
                    "Creation Date",_schoolController.school.value!.creationDate.toIso8601String()),
                  )

                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget BuildFieldData(String labelText, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Light grey background
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          padding: EdgeInsets.symmetric(horizontal: 12), // Inner padding
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    hintText: hintText,
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
        SizedBox(height: 10), // Space below field
      ],
    );
  }
}
