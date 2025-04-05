
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../Controllers/StudentController.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/Absence.dart';
class ShowAbscences extends StatefulWidget {
  const ShowAbscences({super.key});

  @override
  State<ShowAbscences> createState() => _ShowAbscencesState();
}

class _ShowAbscencesState extends State<ShowAbscences> {

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  StudentController _studentController = Get.find<StudentController>();
  List<int> hours = List.generate(10, (index) => 8 + index);
  @override
  void initState() {
    // TODO: implement initState

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
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
  Widget _buildEditableCell(DateTime day, int hour) {
    // Find the course that matches the day and hour
    Absence? absence = _studentController.Abscences.value.firstWhereOrNull((c) {
      DateTime courseDate = DateFormat('yyyy-MM-dd').parse(c.dateCours);
      int courseStartHour =
      int.parse(c.heureDebutCours.split(':')[0]); // Extract hour

      return courseDate.year == day.year &&
          courseDate.month == day.month &&
          courseDate.day == day.day &&
          courseStartHour == hour;
    });


    return GestureDetector(

      onTap: () {
        if (absence != null)
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Abscence Details",
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
                            "Motif : ",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(absence.motif,
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Teacher Name : ",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(absence.nomEnseignant,
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
                          Text(absence.prenomEnseignant,
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
                          Text(absence.classeNom,
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
                          Text(absence.libSalle,
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
                          Text(absence.libMatiere,
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
                          Text(absence.libTrimestre,
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
                      style: GoogleFonts.poppins(color: Colors.blue),
                    ),
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
          color: absence != null
              ? Colors.red
              : Colors.white, // Highlight if course exists
          border: Border.all(color: Colors.black),
        ),
        child: absence != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text("Abscence",
                  style:
                  GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            )
          ],
        )
            : SizedBox.shrink(),
      ),
    );
  }


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

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildCell("Day/Hour", isHeader: true),
        ...hours.map((hour) => _buildCell("$hour:00", isHeader: true)).toList(),
      ],
    );
  }
}
