

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ganto_shop/Controllers/SchoolController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class AddTrimester extends StatefulWidget {
  const AddTrimester({super.key});

  @override
  State<AddTrimester> createState() => _AddTrimesterState();
}

class _AddTrimesterState extends State<AddTrimester> {
  final TextEditingController _controller_trimester_name = TextEditingController();
  final TextEditingController _controller_trimester_number = TextEditingController();

  SchoolController _schoolController = Get.find<SchoolController>();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Add Trimester",
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
                        child: Image.asset("assets/addtrimester.png"),
                      ),
                      SizedBox(height: 20),
                      BuildDropDownList("Trimester Number", "Enter Trimester Label"),
                      SizedBox(height: 10),
                      BuildFieldData("Trimester Label", "Enter Trimester Label"),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async{
                          if(_formKey.currentState!.validate())
                            {
                              FocusScope.of(context).requestFocus(
                                  FocusNode()); // Remove focus from text fields
                              await Future.delayed(Duration(milliseconds: 100));
                             await _schoolController.Insert_Trimester(int.parse(_controller_trimester_number.text),_controller_trimester_name.text,context);
                            }
                          // Action when button is pressed


                        },
                        child: Text("Add Trimester",
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
      ),key: _formKey,),
    );
  }

  Widget BuildDropDownList(String labelText, String hintText) {
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
              if(value==null || value.isEmpty)
                {
                  return 'Enter Trimester Number';
                }
              if(!value.isNumericOnly)
                {
                  return 'Enter a valid Trimester Number';
                }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: _controller_trimester_number,
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
              if(value==null || value.isEmpty)
              {
                return 'Enter Trimester Label';
              }
              return null;
            },
            controller: _controller_trimester_name,
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
