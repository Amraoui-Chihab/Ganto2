import 'package:flutter/material.dart';
import 'package:ganto_shop/Controllers/SchoolController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LinkModuleSpeciality extends StatefulWidget {
  const LinkModuleSpeciality({super.key});

  @override
  State<LinkModuleSpeciality> createState() => _LinkModuleSpecialityState();
}

class _LinkModuleSpecialityState extends State<LinkModuleSpeciality> {
  SchoolController _schoolController = Get.find<SchoolController>();
  TextEditingController _coefficient = new TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add form key
  String? selectedSpeciality;
  String? SelectedModule;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Link Module With Options",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Form(
        child: SafeArea(
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
                          child: Image.asset("assets/Link.png"),
                        ),
                        SizedBox(height: 5),
                        BuildDropDownModules("Select Module"),
                        SizedBox(height: 5),
                        BuildDropdownFieldData(
                          "Select Speciality",
                        ),
                        SizedBox(height: 5),
                        BuildFieldData(
                            "Coefficient", "Enter Coefficient", _coefficient),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).requestFocus(
                                  FocusNode()); // Remove focus from text fields
                              await Future.delayed(Duration(milliseconds: 100));

                              await _schoolController.LinkModuleWithSpeciality(
                                  int.parse(SelectedModule!),
                                  int.parse(selectedSpeciality!),
                                  int.parse(_coefficient.text),
                                  context);
                            }

                            //  _schoolController.InsertModule(_modulenamecontroller.text, context);

                            // Action when button is pressed
                            // _schoolController.Insert_Speciality(_controller.text,context);
                          },
                          child: Text("Link Module With Speciality",
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
        ),
        key: _formKey,
      ),
    );
  }

  Widget BuildDropDownModules(String labelText) {
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
        (_schoolController.modules.isEmpty)?Container(
          width: Get.width * 0.9, // 80% screen width
          decoration: BoxDecoration(
            color: Colors.red.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "No Module Found",
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
                    //  Get.toNamed("/AddOption");
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
              if (value == null || value.isEmpty) {
                return 'Please Select Module';
              }
              return null;
            },
            dropdownColor: Colors.white,
            value: SelectedModule,
            items: _schoolController.modules.map<DropdownMenuItem<String>>((Module) {
              return DropdownMenuItem<String>(
                value: Module.id.toString(),
                child: Text( Module.libelle ?? 'No Name'),
              );
            }).toList(),
            onChanged: (newValue) {
              SelectedModule = newValue;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Grey border
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey), // Grey border when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2), // Grey border when focused
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
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
        (_schoolController.Specialities.isEmpty)?Container(
          width: Get.width * 0.9, // 80% screen width
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
              if (value == null || value.isEmpty) {
                return 'Please Select Speciality';
              }
              return null;
            },
            dropdownColor: Colors.white,
            value: selectedSpeciality,
            items: _schoolController.Specialities.map<DropdownMenuItem<String>>((speciality) {
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
                borderSide: BorderSide(
                    color: Colors.grey), // Grey border when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2), // Grey border when focused
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget BuildFieldData(
      String labelText, String hintText, TextEditingController _controller) {
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
              if (value!.isEmpty || !value.isNumericOnly)
                return 'Please Enter Valid Coefficient';

              return null;
            },
            controller: _controller,
            //focusNode: _focusNode,
            cursorColor: Colors.blue,
            keyboardType: TextInputType.number,
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
