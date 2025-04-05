

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../Controllers/SchoolController.dart';
import '../Models/Class.dart';import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';


class Viewclassesforaverage extends StatefulWidget {
  const Viewclassesforaverage({super.key});

  @override
  State<Viewclassesforaverage> createState() => _ViewclassesforaverageState();
}

class _ViewclassesforaverageState extends State<Viewclassesforaverage> {

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
                        leading: CircleAvatar(backgroundImage: AssetImage("assets/addclass.png"),),
                        trailing: IconButton(
                            onPressed: () async{
                              Get.dialog(
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.all(20), // Add padding for spacing
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min, // Wraps content properly
                                        children: [
                                          Lottie.asset('assets/loading.json',
                                              width: 100, height: 100, fit: BoxFit.fitHeight),
                                          SizedBox(width: 10), // Add spacing between animation and text
                                          Text(
                                            "Please Wait ...",
                                            style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                decoration: TextDecoration.none,
                                                color: Colors.blue),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  barrierDismissible: false, // Prevents dismissing the dialog
                                  useSafeArea: true);
                              await _schoolControler.GetStudents();
                              Get.back();
                              if(_schoolControler.Stduents.any((element) => element.classeId==classe.classId,)!=false)
                                Get.toNamed("/AddStudentLeverage",arguments:
                                  classe.classId.toString()
                                );
                              else
                                {
                                  var snackBar = SnackBar(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      messageTextStyle: GoogleFonts.poppins(),
                                      titleTextStyle:
                                      GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
                                      color: Colors.red,
                                      title: 'Error',
                                      message: "No Student In This Class",
                                      contentType: ContentType.warning,
                                    ),
                                  );

                                  ScaffoldMessenger.of(Get.context!)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                }



                            },
                            icon: Icon(
                              Icons.visibility,
                              color: Colors.blue,
                            )),
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
