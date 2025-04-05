import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/TeacherController.dart';
import '../Models/Class.dart';

class TeacherProgramExam extends StatefulWidget {
  const TeacherProgramExam({super.key});

  @override
  State<TeacherProgramExam> createState() => _TeacherProgramExamState();
}

class _TeacherProgramExamState extends State<TeacherProgramExam> {
  String? selectedClass;
  String? selectedModule;
  String? selectedTrimester;
  String? selectedRoom;
  TextEditingController _LibExamController = new TextEditingController();
  String? examDetails;

  late List Classes = [];
  late List Rooms = [];
  late List Modules = [];
  late List Trimesters = [];

  int currentStep = 0;

  final TeacherController _teacherController = Get.find<TeacherController>();

  @override
  void initState() {
    super.initState();
    GetData();
  }

  Future<void> GetData() async {

    final data = await _teacherController.FetchData();
    if (data != null) {
      setState(() {
        Classes = data['classes'] ?? [];
        Rooms = data['rooms'] ?? [];
        Modules = data['modules'] ?? [];
        Trimesters = data['trimesters'] ?? [];
      });
    } else {
      print("Error: Received null response");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Program An Exam",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: Stepper(
                    physics: BouncingScrollPhysics(),
                    onStepContinue: () async{

                      if (currentStep < 4) {
                        setState(() {
                          currentStep++;
                        });
                      }
                      else if(currentStep == 4)
                        {
                       await   _teacherController.ProgramExam(int.parse(selectedClass!), int.parse(selectedModule!), int.parse(selectedTrimester!), int.parse(selectedRoom!), _LibExamController.text, Get.arguments["date"]);

                        }
                    },
                    onStepCancel: () {
                      if (currentStep > 0) {
                        setState(() {
                          currentStep--;
                        });
                      }
                    },
                    type: StepperType.vertical,
                    currentStep: currentStep,
                    steps: [
                      Step(
                        isActive: currentStep >= 0,
                        state: currentStep == 0
                            ? StepState.editing
                            : StepState.complete,
                        title:
                            Text("Select Class", style: GoogleFonts.poppins()),
                        content: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          value: selectedClass,
                          items: Classes.map<DropdownMenuItem<String>>((Class) {
                            return DropdownMenuItem<String>(
                              value: Class['CLASSE_ID'].toString(),
                              child: Text(Class['CLASSE_NOM'] ?? 'No Name'),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            selectedClass = newValue;
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
                      ),
                    Step(
                      isActive: currentStep >= 1,
                      state: currentStep == 1 ? StepState.editing : currentStep <1 ? StepState.indexed:StepState.complete,
                      title: Text("Select Module", style: GoogleFonts.poppins()),
                      content: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        value: selectedModule,
                        items: Modules.map<DropdownMenuItem<String>>((Module) {
                          return DropdownMenuItem<String>(
                            value: Module['ID_MATIERE'].toString(),
                            child: Text(Module['LIB_MATIERE'] ?? 'No Name'),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          selectedModule = newValue;
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
                    ),
                      Step(
                        isActive: currentStep >= 2,
                        state: currentStep == 2 ? StepState.editing : currentStep <2 ? StepState.indexed:StepState.complete,
                        title: Text("Select Trimester", style: GoogleFonts.poppins()),
                        content: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          value: selectedTrimester,
                          items: Trimesters.map<DropdownMenuItem<String>>((Trimester) {
                            return DropdownMenuItem<String>(
                              value: Trimester['TRIMERSTRE_ID'].toString(),
                              child: Text(Trimester['LIB_TRIMESTRE'] ?? 'No Name'),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            selectedTrimester = newValue;
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
                      ),
                      Step(
                        isActive: currentStep >= 3,
                        state: currentStep == 3? StepState.editing : currentStep <3 ? StepState.indexed:StepState.complete,
                        title: Text("Select Room", style: GoogleFonts.poppins()),
                        content: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          value: selectedRoom,
                          items: Rooms.map<DropdownMenuItem<String>>((Room) {
                            return DropdownMenuItem<String>(
                              value: Room['ID_SALLE'].toString(),
                              child: Text(Room['LIB_SALLE'] ?? 'No Name'),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            selectedRoom = newValue;
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
                      ),
                      Step(
                        isActive: currentStep >= 4,
                        state: currentStep == 4
                            ? StepState.editing
                            : StepState.indexed,
                        title: Text("Fill Exam Description",
                            style: GoogleFonts.poppins()),
                        content: TextFormField(
                          controller: _LibExamController,
                          decoration: inputDecoration()
                              .copyWith(hintText: "Enter Exam Description"),
                          onChanged: (value) {
                            setState(() {
                              examDetails = value;
                            });
                          },
                        ),
                      ),
                    ],
                    connectorColor: WidgetStateProperty.all<Color>(Colors.blue),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Step _buildStep(String title, String? value, List<String> items,
      ValueChanged<String?> onChanged, int indexactivated) {
    return Step(
      isActive: currentStep >= indexactivated,
      state:
          currentStep > indexactivated ? StepState.complete : StepState.indexed,
      title: Text(title, style: GoogleFonts.poppins()),
      content: DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: value,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        decoration: inputDecoration(),
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2)),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
