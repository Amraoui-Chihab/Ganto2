import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../Controllers/SchoolController.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  File? _imageFile;

  TextEditingController StudentNameController = new TextEditingController();
  TextEditingController StudentLastNameController = new TextEditingController();

  TextEditingController _Student_birthday = new TextEditingController();

  SchoolController _schoolControler = Get.find<SchoolController>();

  String? SelectedSexe;

  String? SelectedClass;

  late List Classes = [];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchClasses();
  }

  Future<void> fetchClasses() async {
    try {
      final data = await _schoolControler.getClassesForStudent();
      print(data);

      if (data != null) {
        setState(() {
          Classes = data['Classes'] ?? [];
        });
      } else {
        print("Error: Received null response");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
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
          "Add Student",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
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
                          height:
                              200, // Increase the height manually or use a dynamic approach
                          child: Center(
                            child: Stack(
                              clipBehavior: Clip
                                  .none, // Allow overflow of positioned widgets
                              children: [
                                CircleAvatar(
                                  backgroundImage: _imageFile != null
                                      ? FileImage(_imageFile!)
                                      : null,
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 80,
                                ),
                                Positioned(
                                  top: 130, // Adjusted to position properly
                                  left: 85,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius:
                                        20, // Add radius for a consistent size
                                    child: IconButton(
                                      onPressed: () {
                                        _pickImage();
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Colors.white, size: 25),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        BuildStudentField("Student Name", "Enter Student Name",
                            StudentNameController,(p0){
                            if( p0 == null || p0.isEmpty)
                              {
                                return 'Please Enter Student Name';
                              }
                            return null;
                          },),
                        SizedBox(height: 5),
                        BuildStudentField(
                            "Student LastName",
                            "Enter Student LastName",
                            StudentLastNameController,(p0){
                          if( p0 == null || p0.isEmpty)
                          {
                            return 'Please Enter Student LastName';
                          }
                          return null;
                        }),
                        SizedBox(height: 5),
                        BuildDropdownFieldDataClasses("Select Student Class"),
                        SizedBox(height: 5),
                        BuildDateChooser(
                            "Student BirthDate",
                            "Enter Student BirthDate",
                            _Student_birthday,
                            context),
                        SizedBox(height: 5),
                        BuildStudentSexeDropdown("Select Student Sexe"),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate())
                              {
                                FocusScope.of(context).requestFocus(FocusNode()); // Remove focus from text fields
                                await Future.delayed(Duration(milliseconds: 100));
                                if(_imageFile == null)
                                  {
                                    var snackBar = SnackBar(
                                      /// need to set following properties for best effect of awesome_snackbar_content
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Error',
                                        message:
                                        "Please Enter Student Image",
                                        messageTextStyle: GoogleFonts.poppins(),
                                        titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),

                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.failure,

                                      ),
                                    );

                                    ScaffoldMessenger.of(Get.context!)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);

                                    return;
                                  }
                                if(_Student_birthday.text.isEmpty)
                                  {
                                    var snackBar = SnackBar(
                                      /// need to set following properties for best effect of awesome_snackbar_content
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Error',
                                        message:
                                        "Please Enter Student BirthDate",
                                        messageTextStyle: GoogleFonts.poppins(),
                                        titleTextStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),

                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.failure,

                                      ),
                                    );

                                    ScaffoldMessenger.of(Get.context!)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                    return;
                                  }

                                await _schoolControler.InsertStduent(
                                    StudentNameController.text,
                                    StudentLastNameController.text,
                                    int.parse(SelectedClass!),
                                    _Student_birthday.text,
                                    SelectedSexe!,
                                    context,
                                    _imageFile);
                              }

                            /* showDialog(
                            context: context,
                            builder: (context) => StepperDialog(),
                          );*/
                          },
                          child:
                              Text("Add Student", style: GoogleFonts.poppins()),
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
      ),
    );
  }

  Widget BuildDropdownFieldDataClasses(String labelText) {
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
        Classes.isNotEmpty
            ? SizedBox(
                width: Get.width * 0.9, // 80% screen width
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if(value == null)
                      {
                        return 'Please Select a Class';
                      }
                    return null;
                  },
                  dropdownColor: Colors.white,
                  value: SelectedClass,
                  items: Classes.map<DropdownMenuItem<String>>((Class) {
                    return DropdownMenuItem<String>(
                      value: Class['CLASSE_ID'].toString(),
                      child: Text(Class['CLASSE_NOM'] ?? 'No Name'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    SelectedClass = newValue;
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
              )
            : Container(
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "No Classes Found",
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
                          Get.toNamed("/AddClass");
                        },
                        icon: const Icon(Icons.add, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }

  Widget BuildDateChooser(String labelText, String hintText,
      TextEditingController _controller, BuildContext context) {
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
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(

              barrierColor: Colors.white,

              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              setState(() {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                _controller.text = formattedDate;
              });
              // Update controller text
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 12, vertical: 14), // Same padding as TextField
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _controller.text.isEmpty ? hintText : _controller.text,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.calendar_today, color: Colors.blue), // Calendar icon
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget BuildStudentSexeDropdown(String labelText) {
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
        SizedBox(
          width: Get.width * 0.9, // 90% of screen width
          child: DropdownButtonFormField<String>(
            validator: (value) {
              if(value == null)
              {
                return 'Please Select Sexe';
              }
              return null;
            },
            dropdownColor: Colors.white,
            value: SelectedSexe,
            items: [
              DropdownMenuItem(
                child: Text(
                  "Male",
                  style: GoogleFonts.poppins(),
                ),
                value: "Male",
              ),
              DropdownMenuItem(
                child: Text(
                  "Female",
                  style: GoogleFonts.poppins(),
                ),
                value: "Female",
              )
            ],
            onChanged: (value) {
              setState(() {
                SelectedSexe = value;
              });
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
                    color: Colors.grey, width: 2), // Grey border when focused
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget BuildStudentField(
      String labelText, String hintText, TextEditingController controller, String? Function(String?)? validator) {
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
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

}
