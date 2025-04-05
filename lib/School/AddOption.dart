import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/SchoolController.dart';

class AddOption extends StatefulWidget {
  const AddOption({super.key});

  @override
  State<AddOption> createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {
  final TextEditingController _controller = TextEditingController();


  SchoolController _schoolController = Get.find<SchoolController>();

  @override
  void initState() {
    // TODO: implement initState

    print("hjfgjfgdjdfgjkgfdkjlkdfgjkld");
    super.initState();
  }

  final _formKey = GlobalKey<FormState>(); // Add form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Add Speciality",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: Get.width*9/10,
                        // color: Colors.red,
                        height: Get.height*2.5/10,
                        child: Image.asset("assets/addspeciality.png"),
                      ),
                      SizedBox(height: 20),
                      BuildFieldData("Speciality Name", "Enter speciality"),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async{
                          if(_formKey.currentState!.validate())
                            {
                              FocusScope.of(context).requestFocus(
                                  FocusNode()); // Remove focus from text fields
                              await Future.delayed(Duration(milliseconds: 100));
                              await _schoolController.Insert_Speciality(_controller.text,context);
                            }
                          // Action when button is pressed

                        },
                        child: Text("Add Speciality",
                            style: GoogleFonts.poppins()),
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
      ),key: _formKey,)
    );
  }

  Widget BuildFieldData(String labelText, String hintText) {
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
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            validator: (value) {
              if(value!.isEmpty)
                {
                  return 'Please Enter A Speciality Name';
                }
              return null;
            },
            controller: _controller,
            //focusNode: _focusNode,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
