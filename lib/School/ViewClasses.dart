import 'package:flutter/material.dart';
import 'package:ganto_shop/Models/Class.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/SchoolController.dart';

class ViewClasses extends StatefulWidget {
  const ViewClasses({super.key});

  @override
  State<ViewClasses> createState() => _ViewClassesState();
}

class _ViewClassesState extends State<ViewClasses> {
  SchoolController _schoolControler = Get.find<SchoolController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "View All Classes",
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
                  if (_schoolControler.Classes.isEmpty) {
                    return Center(
                      child: Text(
                        "No Class Found",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.Classes.length,
                    itemBuilder: (context, index) {
                      Class classe = _schoolControler.Classes[index];
                      return ListTile(
                        tileColor: Colors.grey[300],
                        title: Text(
                          "ClassName : " + classe.className,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Speciality : " + classe.OptionName,
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
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
    );
  }
}
