import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Ganto/Controllers/Company_controller.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl_phone_field2/intl_phone_field.dart';

import '../../main.dart';


class Companyprofile extends StatelessWidget {
  CompanyController companyController = Get.find<CompanyController>();
  Companyprofile({super.key});

  @override
  Widget build(BuildContext context) {
    print(prefs.getString("token"));
    print(prefs.getString("token2"));

    String phone_complete = "";

    return WillPopScope(
        child: Scaffold(


          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "Profile".tr,
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 25),
                          ),
                          margin: EdgeInsets.only(top: 40),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  Colors.white, // Set your desired border color
                              width: 5, // Set your desired border width
                            ),
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: Obx(
                            () => Stack(
                              children: [
                                CircleAvatar(
                                  radius: 80, // Adjust the radius as needed
                                  backgroundColor:
                                      Colors.white, // Avatar background color
                                  backgroundImage: companyController
                                              .company.value!.companyLogo !=
                                          null
                                      ? NetworkImage(companyController
                                          .company.value!.companyLogo!)
                                      : null, // Use the logo image if it's available, else set backgroundImage to null
                                  child: companyController
                                              .company.value!.companyLogo ==
                                          null
                                      ? Icon(
                                          Icons
                                              .business, // Default icon when companyLogo is null
                                          size:
                                              50, // Adjust the size of the icon as needed
                                          color: Colors.white, // Icon color
                                        )
                                      : null, // If companyLogo is not null, don't show the icon
                                ),
                                Positioned(
                                    top: 115,
                                    left: 105,
                                    child: IconButton(
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title:
                                                    Text("Change Company Logo".tr,style: GoogleFonts.poppins(),),

                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text(
                                                        "Pick".tr,style: GoogleFonts.poppins(color: Colors.blue),),
                                                    onPressed: () async {
                                                      File? _image;
                                                      final ImagePicker picker =
                                                          ImagePicker();
                                                      final XFile? pickedFile =
                                                          await picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                      if (pickedFile != null) {
                                                        _image = File(
                                                            pickedFile.path);
                                                        Navigator.pop(context);
                                                        await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Change Company Logo".tr),
                                                              content:
                                                                  CircleAvatar(
                                                                radius: 60,
                                                                backgroundImage:
                                                                    _image !=
                                                                            null
                                                                        ? FileImage(
                                                                            _image!)
                                                                        : null,
                                                                child: _image ==
                                                                        null
                                                                    ? Icon(
                                                                        Icons
                                                                            .person,
                                                                        size:
                                                                            60,
                                                                        color: Colors
                                                                            .grey,
                                                                      )
                                                                    : null, // Show an icon if no image is selected
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                      'Save'.tr,style: GoogleFonts.poppins(color: Colors.blue),),
                                                                  onPressed:
                                                                      () async {
                                                                    String?
                                                                        base64LogoImage;
                                                                    if (_image !=
                                                                        null) {
                                                                      List<int>
                                                                          logoBytes =
                                                                          await _image!
                                                                              .readAsBytes();
                                                                      base64LogoImage =
                                                                          base64Encode(
                                                                              logoBytes);
                                                                    }
                                                                    Navigator.pop(
                                                                        context);
                                                                    companyController
                                                                        .Change_Company_Logo(
                                                                            base64LogoImage!);
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: Text(
                                                                      "Cancel".tr,style: GoogleFonts.poppins(color: Colors.red),),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text("Cancel".tr,style: GoogleFonts.poppins(color: Colors.red),),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                        )))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                "Name : ".tr + companyController.company.value!.companyName!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                  onPressed: () {
                                    TextEditingController nameController = TextEditingController();
                                    final _formKey = GlobalKey<FormState>(); // Create a form key

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Text(
                                            'Change Company Name'.tr,
                                            style: GoogleFonts.poppins(),
                                          ),
                                          content: Form(
                                            key: _formKey, // Assign form key
                                            child: TextFormField(
                                              cursorColor: Colors.blue,
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                labelStyle: GoogleFonts.poppins(color: Colors.black),
                                                labelText: 'New Company Name'.tr,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blue), // Blue border
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blue), // Blue border when not focused
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.blue, width: 2), // Thicker blue border when focused
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.trim().isEmpty) {
                                                  return 'Company name cannot be empty'.tr;
                                                }
                                                if (value.length < 3) {
                                                  return 'Company name must be at least 3 characters long'.tr;
                                                }
                                                return null; // Valid input
                                              },
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: Text(
                                                'Cancel'.tr,
                                                style: GoogleFonts.poppins(color: Colors.red),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async{

                                                if (_formKey.currentState!.validate()) {
                                                  Navigator.of(context).pop();
                                                  FocusScope.of(context).requestFocus(FocusNode()); // Remove focus from text fields
                                                  await Future.delayed(Duration(milliseconds: 100));// Validate form
                                                  String newName = nameController.text.trim();

                                                 await companyController.Change_Company_Name(newName); // Update company name
                                                   // Close the dialog
                                                }
                                              },
                                              child: Text(
                                                'Save'.tr,
                                                style: GoogleFonts.poppins(color: Colors.blue),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Balance : ".tr+" ",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  companyController.company.value!.companyBalance
                                          .toString() +
                                      " Points".tr,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          margin: EdgeInsets.only(top: 5, bottom: 10),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone2".tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Obx(() => Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                    width: 1.0, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      8.0)), // Optional: add padding inside the container
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.account_circle,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                          width:
                                              8.0), // Add some spacing between the icon and text
                                      Text(
                                        companyController.company.value!
                                                    .companyPhone !=
                                                null
                                            ? companyController
                                                .company.value!.companyPhone!
                                            : "No Phone",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {


                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text('Change Company Phone'.tr,style: GoogleFonts.poppins(),),
                                            content: IntlPhoneField(
                                              decoration: InputDecoration(
                                                hintStyle:
                                                    GoogleFonts.poppins(),
                                                filled: true,
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width:
                                                        1, // Border when not focused
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors
                                                        .blue, // Same color as enabled to keep it consistent
                                                    width:
                                                        1, // Same width for a consistent look while typing
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                hintText: 'Phone2'.tr,
                                              ),
                                              style: GoogleFonts.poppins(),
                                              initialCountryCode:
                                                  'US', // Set default country code
                                              onChanged: (phone) {
                                                phone_complete =
                                                    phone.completeNumber;
                                              },
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text('Cancel'.tr,style: GoogleFonts.poppins(color: Colors.red),),
                                              ),
                                              TextButton(
                                                onPressed: () async{

                                                  FocusScope.of(context).requestFocus(FocusNode()); // Remove focus from text fields
                                                  await Future.delayed(Duration(milliseconds: 100));


                                                 await companyController
                                                      .Change_Company_Phone(
                                                          phone_complete);
                                                   // Close the dialog
                                                },
                                                child: Text('Save'.tr,style: GoogleFonts.poppins(color: Colors.blue)),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email".tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Obx(() => Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    8.0), // Optional: Rounded corners
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.account_circle,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                          width:
                                              8.0), // Add spacing between the icon and text
                                      Text(
                                        companyController.company.value!
                                                    .companyEmail !=
                                                null
                                            ? companyController
                                                .company.value!.companyEmail!
                                            : "No Email",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {

                                        TextEditingController emailController = TextEditingController();
                                        final _formKey = GlobalKey<FormState>(); // Create a form key

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: Text(
                                                'Change Company Email'.tr,
                                                style: GoogleFonts.poppins(),
                                              ),
                                              content: Form(
                                                key: _formKey, // Assign form key
                                                child: TextFormField(
                                                  controller: emailController,
                                                  decoration: InputDecoration(
                                                    labelStyle: GoogleFonts.poppins(color: Colors.black),
                                                    labelText: 'New Company Email'.tr,
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.blue), // Blue border
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.blue), // Blue border when not focused
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.blue, width: 2), // Thicker blue border when focused
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.trim().isEmpty) {
                                                      return 'Email cannot be empty'.tr;
                                                    }
                                                    // Regular expression for email validation
                                                    String emailPattern =
                                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                                    RegExp regex = RegExp(emailPattern);
                                                    if (!regex.hasMatch(value.trim())) {
                                                      return 'Enter a valid email address'.tr;
                                                    }
                                                    return null; // Valid input
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Close the dialog
                                                  },
                                                  child: Text(
                                                    'Cancel'.tr,
                                                    style: GoogleFonts.poppins(color: Colors.red),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async{
                                                    if (_formKey.currentState!.validate()) { // Validate form
                                                      Navigator.of(context).pop();

                                                      FocusScope.of(context).requestFocus(FocusNode()); // Remove focus from text fields
                                                      await Future.delayed(Duration(milliseconds: 100));

                                                      String newEmail = emailController.text.trim();
                                                      await companyController.Change_Company_Email(newEmail); // Update email
                                                      // Close the dialog
                                                    }
                                                  },
                                                  child: Text(
                                                    'Save'.tr,
                                                    style: GoogleFonts.poppins(color: Colors.blue),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );


                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
               /* Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Company Domain".tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Obx(() => Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    8.0), // Optional: Rounded corners
                              ),
                              // Optional: add padding inside the container
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.account_circle,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                          width:
                                              8.0), // Add spacing between the icon and text
                                      Text(
                                        companyController
                                                .company.value.companyDomain ??
                                            "No Domain",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          String? _selectedDomain;
                                          return AlertDialog(
                                            title:
                                                Text('Change Company Domain'.tr),
                                            content:
                                                DropdownButtonFormField<String>(
                                              value: _selectedDomain,
                                              items:
                                                  _domains.map((String domain) {
                                                return DropdownMenuItem<String>(
                                                  value: domain,
                                                  child: Text(domain),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                _selectedDomain = newValue!;
                                              },
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Select New Company Domain'.tr,
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text('Cancel'.tr),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if (_selectedDomain != null) {
                                                    companyController
                                                        .Change_Company_Domain(
                                                            _selectedDomain!);
                                                  }
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text('Save'.tr),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),*/
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "company Description".tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: Rounded corners
                          ),
                          padding: EdgeInsets.all(
                              8.0), // Add some padding inside the border
                          child: Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.account_circle,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                            width:
                                                8.0), // Add spacing between the icon and text
                                        Expanded(
                                          child: Text(
                                            companyController.company.value!
                                                    .companyDescription ??
                                                "No Description",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      TextEditingController companyDescriptionController = TextEditingController();
                                      final _formKey = GlobalKey<FormState>(); // Create a form key

                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text(
                                              'Change Company Description'.tr,
                                              style: GoogleFonts.poppins(),
                                            ),
                                            content: Form(
                                              key: _formKey, // Assign form key
                                              child: TextFormField(
                                                maxLines: 3,
                                                controller: companyDescriptionController,
                                                decoration: InputDecoration(
                                                  labelStyle: GoogleFonts.poppins(color: Colors.black,),
                                                  labelText: 'New Company Description'.tr,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue), // Blue border
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue), // Blue border when not focused
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue, width: 2), // Thicker blue border when focused
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return 'Description cannot be empty'.tr;
                                                  }
                                                  if (value.length < 10) {
                                                    return 'Description must be at least 10 characters long'.tr;
                                                  }
                                                  return null; // Valid input
                                                },
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                },
                                                child: Text(
                                                  'Cancel'.tr,
                                                  style: GoogleFonts.poppins(color: Colors.red),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async{
                                                  if (_formKey.currentState!.validate()) { // Validate form
                                                 Navigator.of(context).pop();
                                                    FocusScope.of(context).requestFocus(FocusNode()); // Remove focus from text fields
                                                    await Future.delayed(Duration(milliseconds: 100));
                                                    String newDescription = companyDescriptionController.text.trim();
                                                   await companyController.Change_Company_Description(newDescription); // Update description
                                                     // Close the dialog
                                                  }
                                                },
                                                child: Text(
                                                  'Save'.tr,
                                                  style: GoogleFonts.poppins(color: Colors.blue),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false; // Allow normal back navigation if not viewing products
        });
  }
}
