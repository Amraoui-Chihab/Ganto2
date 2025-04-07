import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Ganto/Controllers/SchoolController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  SchoolController _schoolControler = Get.find<SchoolController>();
  TextEditingController _classNameController = new TextEditingController();

  String? selectedSpeciality;
  final _formKey = GlobalKey<FormState>(); // Add form key




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Add Class",
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
                        width: Get.width * 9 / 10,
                        // color: Colors.red,
                        height: Get.height * 2.5 / 10,
                        child: Image.asset("assets/addclass.png"),
                      ),
                      SizedBox(height: 20),
                      BuildFieldData("Class Name", "Enter Class Name",_classNameController),
                      SizedBox(height: 5),
                      BuildDropdownFieldData("Speciality",),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async{
                          if(_formKey.currentState!.validate())
                            {
                              FocusScope.of(context).requestFocus(
                                  FocusNode()); // Remove focus from text fields
                              await Future.delayed(Duration(milliseconds: 100));
                              await _schoolControler.InsertClass(_classNameController.text, int.parse(selectedSpeciality!),context);
                            }

                          // Action when button is pressed
                          // _schoolController.Insert_Speciality(_controller.text,context);
                        },
                        child: Text("Add Class", style: GoogleFonts.poppins()),
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

  Widget BuildDropdownFieldData(String labelText) {
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
        const SizedBox(height: 5),
        _schoolControler.Specialities.isEmpty?Container(
    width: Get.width * 0.8, // 80% screen width
    decoration: BoxDecoration(
    color: Colors.red.shade200,
    borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
    children: [
    Expanded(
    child: Text(
    "No Specialities Found",
    style: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    ),
    ),
    ),
    CircleAvatar(
    backgroundColor: Colors.white,
    child: IconButton(
    onPressed: () {
    Get.toNamed("/AddOption");
    },
    icon: const Icon(Icons.add, color: Colors.blue),
    ),
    ),
    ],
    ),
    ):SizedBox(
          width: Get.width * 0.9, // 80% screen width
          child: DropdownButtonFormField<String>(

            validator: (value) {
              if(value==null || value.isEmpty)
              {
                return 'Please Enter Speciality';
              }
              return null;
            },
            dropdownColor: Colors.white,
            value: selectedSpeciality,

            items:_schoolControler.Specialities.map<DropdownMenuItem<String>>((speciality) {
              return DropdownMenuItem<String>(
                value: speciality.id.toString(),
                child: Text(speciality.libelle ?? 'No Name'),
              );
            }).toList(),
            onChanged: (newValue) {

              selectedSpeciality = newValue;


            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Grey border
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Grey border when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2), // Grey border when focused
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),

          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }


  Widget BuildFieldData(String labelText, String hintText,TextEditingController controller) {
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
                  return 'Please Enter Class Name';
                }
              return null;
            },
            controller: controller,
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
