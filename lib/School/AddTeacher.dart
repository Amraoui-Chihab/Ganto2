import 'dart:io';
import 'package:ganto_shop/Controllers/SchoolController.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  File? _imageFile;

  final _formKey = GlobalKey<FormState>(); // Add form key


  SchoolController _schoolController = Get.find<SchoolController>();
  TextEditingController _namecontroller = new TextEditingController();
  TextEditingController _lastnamecontroller = new TextEditingController();
  TextEditingController _teacher_adress = new TextEditingController();
  TextEditingController _teacher_birthday = new TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        /*Get.snackbar("Notification", "Image Uploaded",
            backgroundColor: Colors.green);*/
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Add Teacher",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(child: KeyboardAvoider(

        child: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  // color: Colors.black,

                  width: Get.width * 9 / 10,
                  height:
                  200, // Increase the height manually or use a dynamic approach
                  child: Center(
                    child: Stack(
                      clipBehavior:
                      Clip.none, // Allow overflow of positioned widgets
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
                            radius: 20, // Add radius for a consistent size
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
                SizedBox(height: 20),
                BuildFieldData(
                    "Teacher Name", "Enter Teacher Name", _namecontroller,(p0) {
                      if(p0!.isEmpty)
                        {
                          return 'Please Enter Teacher Name';
                        }
                      return null;
                    },),
                SizedBox(height: 10),
                BuildFieldData("Teacher LastName", "Enter Teacher LastName",
                    _lastnamecontroller,(p0) {
                      if(p0!.isEmpty)
                      {
                        return 'Please Enter Teacher LastName';
                      }
                      return null;
                    }),
                SizedBox(height: 10),
                BuildFieldData(
                    "Teacher Adress", "Enter Teacher Adress", _teacher_adress,(p0) {
                  if(p0!.isEmpty)
                  {
                    return 'Please Enter Teacher Adress';
                  }
                  return null;
                }),
                SizedBox(height: 10),
                BuildDateChooser("Teacher BirthDate", "Enter Teacher BirthDate",
                    _teacher_birthday, context),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate())
                      {

                        FocusScope.of(context).requestFocus(
                            FocusNode()); // Remove focus from text fields
                        await Future.delayed(Duration(milliseconds: 100));
                        await _schoolController.Insert_Teacher(
                            _namecontroller.text,
                            _lastnamecontroller.text,
                            _teacher_adress.text,
                            _teacher_birthday.text,
                            context,
                            _imageFile);
                      }

                  },
                  child: Text("Add Teacher", style: GoogleFonts.poppins()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),

            width: screenWidth,
          ),
        ),
        autoScroll: true,
      ),key: _formKey,),
    );
  }

  void _showQRCode(BuildContext context) {
    var uuid = Uuid();
    String qrData = uuid.v1(); // Generate a unique ID

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your QR Code"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(height: 10),
              Text(qrData), // Display the QR data below the code
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
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

      ],
    );
  }

  Widget BuildFieldData(
      String labelText,
      String hintText,
      TextEditingController controller,
      String? Function(String?)? validator) {
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
            controller: controller,
            cursorColor: Colors.blue,
            validator: validator, // Added validator here
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
