import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganto_shop/Models/FullCourse.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/SchoolController.dart';
import '../Models/Cours.dart';

class MonthlyScheduleGrid extends StatefulWidget {
  @override
  _MonthlyScheduleGridState createState() => _MonthlyScheduleGridState();
}

class _MonthlyScheduleGridState extends State<MonthlyScheduleGrid> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  SchoolController _schoolControler = Get.find<SchoolController>();

  List<int> hours = List.generate(10, (index) => 8 + index); // 08:00 - 17:00

  late List<FullCourse> courses;

  late String idTeacher;
  late String idClass;
  late String idRoom;
  late String idModule;
  late String idTrim;

  @override
  void initState() {
    super.initState();
    idTeacher = Get.arguments['IdTeacher'] ?? "";
    idClass = Get.arguments['IdClass'] ?? "";
    idRoom = Get.arguments['IdRoom'] ?? "";
    idModule = Get.arguments['IdModule'] ?? "";
    idTrim = Get.arguments['IdTrim'] ?? "";

    print("IdTeacher: $idTeacher");
    print("IdClass: $idClass");
    print("IdRoom: $idRoom");
    print("IdModule: $idModule");
    print("IdTrim: $idTrim");

    if (Get.arguments["courses"] != null) {
      List<dynamic> decodedList = jsonDecode(Get.arguments["courses"]!);

      courses = decodedList.map((item) => FullCourse.fromJson(item)).toList();
    }

    print("Courses : ${courses.length}");

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Reset to default orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  List<DateTime> _generateMonthDays(int year, int month) {
    int daysInMonth = DateTime(year, month + 1, 0).day; // Get last day of month
    return List.generate(
        daysInMonth, (index) => DateTime(year, month, index + 1));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> monthDays = _generateMonthDays(selectedYear, selectedMonth);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildMonthSelector(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(width: 2),
                  columnWidths: {
                    0: FixedColumnWidth(120), // Date Column Width
                    for (int i = 1; i <= hours.length; i++)
                      i: FixedColumnWidth(80),
                  },
                  children: [
                    _buildHeaderRow(), // Header Row (Hours)
                    ...monthDays.map((day) => _buildDayRow(day)).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Header Row (Hours)**
  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell("Day/Hour", isHeader: true),
        ...hours.map((hour) => _buildCell("$hour:00", isHeader: true)).toList(),
      ],
    );
  }

  /// **Row for each day**
  TableRow _buildDayRow(DateTime day) {
    String formattedDay =
        DateFormat('EEEE, dd MMM').format(day); // Ex: Monday, 05 Feb
    return TableRow(
      children: [
        _buildCell(formattedDay, isHeader: true),
        ...hours.map((hour) => _buildEditableCell(day, hour)).toList(),
      ],
    );
  }

  /// **Editable Cells (Subjects)**
  Widget _buildEditableCell(DateTime day, int hour) {
    // Find the course that matches the day and hour
    FullCourse? course = courses.firstWhereOrNull((c) {
      DateTime courseDate = DateFormat('yyyy-MM-dd').parse(c.dateCours);
      int courseStartHour =
          int.parse(c.heureDebutCours.split(':')[0]); // Extract hour

      return courseDate.year == day.year &&
          courseDate.month == day.month &&
          courseDate.day == day.day &&
          courseStartHour == hour;
    });

    return GestureDetector(
      onLongPress: () {
        if (course != null)
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Course Details",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  // Wrap Column in SingleChildScrollView
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Ensure it takes minimum space
                    children: [
                      Row(
                        children: [
                          Text(
                            "Teacher Name : ",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(course.NOM_ENSEIGNANT,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Teacher LastName : ",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(course.PRENOM_ENSEIGNANT,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Class Name : ",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(course.CLASSE_NOM,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Room : ",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(course.LIB_SALLE,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Module Name : ",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(course.LIB_MATIERE,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Trimester : ",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(course.LIB_TRIMESTRE,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Ok",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ],
              );
            },
          );
      },
      onTap: () {
        print(courses);
        print(
            "Clicked on day : ${day.day} -  month : ${day.month} at $hour:00");

        course == null
            ? showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text("Add Course",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    content: Text(
                        "Do you want to schedule a course on ${DateFormat('yyyy-MM-dd').format(day)} at $hour:00?",
                        style: GoogleFonts.poppins()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel", style: GoogleFonts.poppins()),
                      ),
                      TextButton(
                        onPressed: () async {
                          FullCourse? newCourse =
                              await _schoolControler.insertCourse(
                            int.parse(idTeacher),
                            int.parse(idClass),
                            int.parse(idRoom),
                            int.parse(idModule),
                            int.parse(idTrim),
                            day,
                            hour,
                          );
                          if (newCourse != null) {
                            Navigator.pop(context);
                            setState(() {
                              courses.add(newCourse);
                              // courses =  _schoolControler.fetchCourses(int.parse(idClass), selectedMonth, selectedYear);
                            }); // Refresh UI
                          }
                        },
                        child: Text("Confirm", style: GoogleFonts.poppins()),
                      ),
                    ],
                  );
                },
              )
            : showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text("Delete Course",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    content: Text("Do you want to Delete This Course ?",
                        style: GoogleFonts.poppins()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel", style: GoogleFonts.poppins()),
                      ),
                      TextButton(
                        onPressed: () async {
                          bool iSDeleted = await _schoolControler.DeleteCourse(
                              course.idCours!);
                          if (iSDeleted) {
                            Navigator.pop(context);
                            setState(() {
                              courses.removeWhere(
                                (c) => c.idCours == course.idCours,
                              );
                            });
                          }
                          /*Cours? newCourse = await _schoolControler.insertCourse(
                      int.parse(idTeacher),
                      int.parse(idClass),
                      int.parse(idRoom),
                      int.parse(idModule),
                      int.parse(idTrim),
                      day,
                      hour,
                    );
                    if (newCourse!=null) {
                      Navigator.pop(context);
                      setState(() {
                        courses.add(newCourse);
                        // courses =  _schoolControler.fetchCourses(int.parse(idClass), selectedMonth, selectedYear);
                      }); // Refresh UI
                    }*/
                        },
                        child: Text("Confirm", style: GoogleFonts.poppins()),
                      ),
                    ],
                  );
                },
              );
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.all(8),
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: course != null
              ? Colors.green[200]
              : Colors.white, // Highlight if course exists
          border: Border.all(color: Colors.black),
        ),
        child: course != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text("Course Number #${course.idCours}",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  )
                ],
              )
            : SizedBox.shrink(),
      ),
    );
  }

  /// **Helper: Build Cell**
  Widget _buildCell(String text, {bool isHeader = false}) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isHeader ? Colors.blueAccent : Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  /// **Year & Month Selector**
  Widget _buildMonthSelector() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<int>(
            value: selectedYear,
            items: List.generate(10, (index) => DateTime.now().year - 5 + index)
                .map((year) => DropdownMenuItem(
                      value: year,
                      child: Text(year.toString()),
                    ))
                .toList(),
            onChanged: (year) {
              setState(() {
                selectedYear = year!;
              });
            },
          ),
          SizedBox(width: 20),
          DropdownButton<int>(
            value: selectedMonth,
            items: List.generate(12, (index) => index + 1)
                .map((month) => DropdownMenuItem(
                      value: month,
                      child:
                          Text(DateFormat('MMMM').format(DateTime(0, month))),
                    ))
                .toList(),
            onChanged: (month) {
              setState(() {
                selectedMonth = month!;
              });
            },
          ),
        ],
      ),
    );
  }
}
