import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:intl_phone_field2/country_picker_dialog.dart';

import 'package:Ganto/Controllers/Company_controller.dart';

class CreateNewSchoolPage extends StatefulWidget {
  @override
  _CreateNewSchoolPageState createState() => _CreateNewSchoolPageState();
}

class _CreateNewSchoolPageState extends State<CreateNewSchoolPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  CompanyController _companyController = Get.find<CompanyController>();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _directorFirstNameController = TextEditingController();
  final TextEditingController _directorLastNameController = TextEditingController();
  String? _phoneNumber;
  DateTime? _creationDate;
  bool _isObscure = true;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_creationDate == null) {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: "please select a creation date",
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      }
      if (_phoneNumber == null) {
        var snackBar = SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            messageTextStyle: GoogleFonts.poppins(),
            titleTextStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
            color: Colors.red,
            title: 'Error',
            message: "Please select a Phone Number",
            contentType: ContentType.warning,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        return;
      }
      FocusScope.of(context).requestFocus(
          FocusNode()); // Remove focus from text fields
      await Future.delayed(Duration(
          milliseconds:
          100));
      await _companyController.createNewSchool(
        _schoolNameController.text,
        //_emailController.text,
        _passwordController.text,
        _phoneNumber!,
        _directorFirstNameController.text,
        _directorLastNameController.text,
        _creationDate!,
        context,
        _image,
      );
    }
  }

  Widget _buildLabeledTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String errorMsg,
    bool isPassword = false,
    bool isEmail = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword ? _isObscure : false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return errorMsg;
              }
              if (isEmail && !RegExp(
                  r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return "Enter a valid email";
              }
              if (isPassword && value.length < 6) {
                return "Password must be at least 6 characters long";
              }
              return null;
            },
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
              hintText: hint,
              border: InputBorder.none,
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Create New School", style: GoogleFonts.poppins()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null
                      ? Icon(Icons.camera_alt, size: 50, color: Colors.grey[700])
                      : ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(_image!, fit: BoxFit.cover)),
                ),
              ),
              SizedBox(height: 16),
              _buildLabeledTextField(label: "School Name", hint: "Enter school name", controller: _schoolNameController, errorMsg: "Enter school name"),
              SizedBox(height: 10),
              /*_buildLabeledTextField(label: "School Email", hint: "Enter email", controller: _emailController, errorMsg: "Enter email", isEmail: true),
              SizedBox(height: 10),*/
              _buildLabeledTextField(label: "Password", hint: "Enter password", controller: _passwordController, errorMsg: "Password too short", isPassword: true),
              SizedBox(height: 10),
              Text("Phone Number", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 5),
              IntlPhoneField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                ),
                initialCountryCode: 'US',
                onChanged: (phone) => setState(() => _phoneNumber = phone.completeNumber),
              ),
              SizedBox(height: 10),
              _buildLabeledTextField(label: "Director First Name", hint: "Enter first name", controller: _directorFirstNameController, errorMsg: "Enter first name"),
              SizedBox(height: 10),
              _buildLabeledTextField(label: "Director Last Name", hint: "Enter last name", controller: _directorLastNameController, errorMsg: "Enter last name"),
              SizedBox(height: 10),
          ListTile(
            title: Text(
              _creationDate == null ? "Select Creation Date" : "Creation Date: ${_creationDate!.year}-${_creationDate!.month}-${_creationDate!.day}",
              style: GoogleFonts.poppins(),
            ),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() => _creationDate = pickedDate);
              }
            },),

            SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Create School", style: GoogleFonts.poppins()),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
