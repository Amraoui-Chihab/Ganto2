import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ganto_shop/Controllers/SchoolController.dart';
import 'package:ganto_shop/Models/Cours.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/FullCourse.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  SchoolController _schoolControler = Get.find<SchoolController>();
  String? SelectedTeacher;
  String? SelectedClass;
  String? SelectedRoom;
  String? SelectedModule;
  String? SelectedTrimester;
  late List Teachers = [];
  late List Classes = [];
  late List Rooms = [];
  late List Modules = [];
  late List Trimesters = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await _schoolControler.getDataForNewCourse();

      if (data != null) {
        setState(() {
          Teachers = data['Teachers'] ?? [];
          Classes = data['Classes'] ?? [];
          Rooms = data['Rooms'] ?? [];
          Modules = data['Modules'] ?? [];
          Trimesters = data['Trimesters'] ?? [];
        });
      } else {
        print("Error: Received null response");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Add Course",
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: Get.width * 9 / 10,
                        // color: Colors.red,
                        height: Get.height * 2.5 / 10,
                        child: Image.asset("assets/programcourse.png"),
                      ),
                      SizedBox(height: 10),
                      BuildDropdownFieldDataTeachers(
                        "Select Teacher",
                      ),
                      SizedBox(height: 5),
                      BuildDropdownFieldDataClasses("Select Class"),
                      SizedBox(height: 5),
                      BuildDropdownFieldDataRooms("Select Room"),
                      SizedBox(height: 5),
                      BuildDropdownFieldDataModules("Select Module"),
                      SizedBox(height: 5),
                      BuildDropdownFieldDataTrim("Select Trimester"),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async{
                          
                       List<FullCourse> courses =    await  _schoolControler.fetchCourses(int.parse(SelectedClass!));

                         Get.toNamed("/Grid",arguments: {
                            "IdTeacher":(SelectedTeacher!),
                            "IdClass":(SelectedClass!),
                            "IdRoom":(SelectedRoom!),
                            "IdModule":(SelectedModule!),
                           "IdTrim":(SelectedTrimester!),
                           "courses": jsonEncode(courses.map((course) => course.toJson()).toList()),
                          });
                         /* showDialog(
                            context: context,
                            builder: (context) => StepperDialog(),
                          );*/
                        },
                        child: Text("Add Course", style: GoogleFonts.poppins()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildDropdownFieldDataTeachers(String labelText) {
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
        const SizedBox(height: 5),
        Teachers.isNotEmpty
            ? SizedBox(
                width: Get.width * 0.9, // 80% screen width
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: SelectedTeacher,
                  items: Teachers.map<DropdownMenuItem<String>>((Teacher) {
                    return DropdownMenuItem<String>(
                      value: Teacher['ID_ENSEIGNANT'].toString(),
                      child: Text(Teacher['NOM_ENSEIGNANT'] +
                              " " +
                              Teacher['PRENOM_ENSEIGNANT'] ??
                          'No Name'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    SelectedTeacher = newValue;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Grey border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Grey border when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2), // Grey border when focused
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              )
            : Container(
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "No Teachers Found",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }

  Widget BuildDropdownFieldDataClasses(String labelText) {
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
        const SizedBox(height: 5),
        Classes.isNotEmpty
            ? SizedBox(
                width: Get.width * 0.9, // 80% screen width
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: SelectedClass,
                  items: Classes.map<DropdownMenuItem<String>>((Class) {
                    return DropdownMenuItem<String>(
                      value: Class['CLASSE_ID'].toString(),
                      child: Text(Class['CLASSE_NOM'] ?? 'No Name'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    SelectedClass = newValue;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Grey border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Grey border when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2), // Grey border when focused
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              )
            : Container(
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "No Classes Found",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }

  Widget BuildDropdownFieldDataRooms(String labelText) {
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
        const SizedBox(height: 5),
        Rooms.isNotEmpty
            ? SizedBox(
                width: Get.width * 0.9, // 80% screen width
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: SelectedRoom,
                  items: Rooms.map<DropdownMenuItem<String>>((Room) {
                    return DropdownMenuItem<String>(
                      value: Room['ID_SALLE'].toString(),
                      child: Text(Room['LIB_SALLE'] ?? 'No Name'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    SelectedRoom = newValue;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Grey border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Grey border when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2), // Grey border when focused
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              )
            : Container(
                width: Get.width * 0.9, // 80% screen width
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "No Rooms Found",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }

  Widget BuildDropdownFieldDataModules(String labelText) {
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
        const SizedBox(height: 5),
        Modules.isNotEmpty
            ? SizedBox(
                width: Get.width * 0.9, // 80% screen width
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: SelectedModule,
                  items: Modules.map<DropdownMenuItem<String>>((Module) {
                    return DropdownMenuItem<String>(
                      value: Module['ID_MATIERE'].toString(),
                      child: Text(Module['LIB_MATIERE'] ?? 'No Name'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    SelectedModule = newValue;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Grey border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Grey border when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2), // Grey border when focused
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              )
            : Container(
                width: Get.width * 0.9, // 80% screen width
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "No Modules Found",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }

  Widget BuildDropdownFieldDataTrim(String labelText) {
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
        const SizedBox(height: 5),


        Trimesters.isNotEmpty? SizedBox(
          width: Get.width * 0.9, // 80% screen width
          child: DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            value: SelectedTrimester,
            items: Trimesters.map<DropdownMenuItem<String>>((Trim) {
              return DropdownMenuItem<String>(
                value: Trim['TRIMERSTRE_ID'].toString(),
                child: Text(Trim['LIB_TRIMESTRE'] ?? 'No Name'),
              );
            }).toList(),
            onChanged: (newValue) {
              SelectedTrimester = newValue;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Grey border
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey), // Grey border when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2), // Grey border when focused
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ):Container(
          width: Get.width * 0.9, // 80% screen width
          decoration: BoxDecoration(
            color: Colors.red.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "No Trimester Found",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.add, color: Colors.blue),
                ),
              ),
            ],
          ),
        )


      ],
    );
  }
}


class StepperDialog extends StatefulWidget {
  @override
  _StepperDialogState createState() => _StepperDialogState();
}

class _StepperDialogState extends State<StepperDialog> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Course Setup"),
      content: Container(
        width: double.maxFinite,
        height: 300, // Adjust height as needed
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep += 1;
              });
            } else {
              Navigator.pop(context); // Close popup on last step
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          steps: [
            Step(
              title: Text("Step 1"),
              content: Text("Select Teacher"),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: Text("Step 2"),
              content: Text("Select Class"),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: Text("Step 3"),
              content: Text("Confirm & Save"),
              isActive: _currentStep >= 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close"),
        ),
      ],
    );
  }
}