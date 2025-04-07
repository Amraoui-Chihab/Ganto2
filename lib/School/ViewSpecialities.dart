

import 'package:flutter/material.dart';
import 'package:Ganto/Models/Speciality.dart';
import 'package:get/get.dart';

import '../Controllers/SchoolController.dart';
import 'package:google_fonts/google_fonts.dart';
class ViewSpecialities extends StatefulWidget {
  const ViewSpecialities({super.key});

  @override
  State<ViewSpecialities> createState() => _ViewSpecialitiesState();
}

class _ViewSpecialitiesState extends State<ViewSpecialities> {
  SchoolController _schoolControler = Get.find<SchoolController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (_schoolControler.Specialities.isEmpty) {
                    return Center(
                      child: Text(
                        "No Speciality Found",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.Specialities.length,
                    itemBuilder: (context, index) {
                      Specialite specialite = _schoolControler.Specialities[index];
                      return ListTile(
                        tileColor: Colors.grey[300],
                        title: Text(
                          "Speciality : " + specialite.libelle,
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                       /* subtitle:Text(
                          "RoomCapacity : " + room.capacite.toString(),
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ) */
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "View All Specialities",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
