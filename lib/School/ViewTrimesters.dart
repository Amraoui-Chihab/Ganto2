


import 'package:flutter/material.dart';
import 'package:Ganto/Models/Trimester.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/SchoolController.dart';

class ViewTrimesters extends StatefulWidget {
  const ViewTrimesters({super.key});

  @override
  State<ViewTrimesters> createState() => _ViewTrimestersState();
}

class _ViewTrimestersState extends State<ViewTrimesters> {

  SchoolController _schoolControler = Get.find<SchoolController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "View All Trimesters",
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
                  if (_schoolControler.Trimesters.isEmpty) {
                    return Center(
                      child: Text(
                        "No Trimester Found",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.Trimesters.length,
                    itemBuilder: (context, index) {
                      Trimestre trimester = _schoolControler.Trimesters[index];
                      return ListTile(
                        tileColor: Colors.grey[300],
                        title: Text(
                          "TrimesterName : " + trimester.libelle,
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        subtitle:Text(
                          "TrimesterNumber : " + trimester.number.toString(),
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ) ,
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
