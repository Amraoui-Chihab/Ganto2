


import 'package:flutter/material.dart';
import 'package:Ganto/Models/Module.dart';
import 'package:get/get.dart';

import '../Controllers/SchoolController.dart';
import 'package:google_fonts/google_fonts.dart';
class ViewModules extends StatefulWidget {
  const ViewModules({super.key});

  @override
  State<ViewModules> createState() => _ViewModulesState();
}

class _ViewModulesState extends State<ViewModules> {
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
                  if (_schoolControler.modules.isEmpty) {
                    return Center(
                      child: Text(
                        "No Module Found",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.modules.length,
                    itemBuilder: (context, index) {
                      Module module = _schoolControler.modules[index];
                      return ListTile(
                        tileColor: Colors.grey[300],
                        title: Text(
                          "Module : " + module.libelle,
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
          "View All Modules",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
