import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/SchoolController.dart';
import '../Models/Link.dart';

class ViewLinks extends StatefulWidget {
  const ViewLinks({super.key});

  @override
  State<ViewLinks> createState() => _ViewLinksState();
}

class _ViewLinksState extends State<ViewLinks> {
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
                  if (_schoolControler.Links.isEmpty) {
                    return Center(
                      child: Text(
                        "No Link Found",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.Links.length,
                    itemBuilder: (context, index) {
                      Link link = _schoolControler.Links[index];
                      return ListTile(
                        tileColor: Colors.grey[300],
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Module : " + link.moduleName,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Speciality : " + link.specialityName,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        subtitle: Text(
                          "Coefficient : " + link.coefficient.toString(),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold),
                        ),
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
          "View All Links",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
