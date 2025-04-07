import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Ganto/Controllers/User_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:intl_phone_field2/phone_number.dart';



class UserProfile extends StatelessWidget {
   UserController userController = Get.find<UserController>();




   UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() => Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "Profile".tr,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          margin: EdgeInsets.only(top: 40),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: Stack(
                            children: [

                              userController.Current_User.value!.userPhotoUrl!=null?   CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 80,
                                      backgroundImage: NetworkImage(
                                        userController.Current_User.value!.userPhotoUrl!,

                                      ),
                                    ):SizedBox.shrink()
                                  ,
                              Positioned(
                                top: 115,
                                left: 105,
                                child: IconButton(
                                  onPressed: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    final XFile? pickedFile = await _picker
                                        .pickImage(source: ImageSource.gallery);

                                    if (pickedFile != null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text("Preview Image".tr),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  radius:
                                                      75, // Adjust the radius of the circle
                                                  backgroundImage: FileImage(
                                                      File(pickedFile.path)),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Do you want to update the image".tr,
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog without updating
                                                },
                                                child: Text("Cancel".tr),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  // Handle the update action here
                                                  String? imageBase64;
                                                  if (pickedFile != null) {
                                                    imageBase64 = base64Encode(
                                                        await pickedFile
                                                            .readAsBytes());
                                                  }

                                                  if (imageBase64 != null) {
                                                    Get.back();
                                                    userController
                                                        .changeUserLogo(
                                                            imageBase64,
                                                            );

                                                    // Close the dialog after updating
                                                  }

                                                  // Close the dialog after updating

                                                },
                                                child: Text("Update".tr),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      Get.snackbar("Notification".tr,
                                          "You Didn't Select any Image".tr,
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 7));
                                    }
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "UserName : ".tr + userController.Current_User.value!.username!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 5),
                              IconButton(
                                onPressed: () {
                                  showEditDialog(
                                    context: context,
                                    title: "UserName".tr,
                                    initialValue:
                                        userController.Current_User.value!.username!,
                                    onSave: (value) {
                                      print(userController.Current_User.value!.username);
                                      if (value !=
                                          userController.Current_User.value!.username) {
                                        userController.change_username(value,
                                            );
                                      } else {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Notification".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                content: Text(
                                                    "You Didn't Change the Name".tr,
                                                    style:
                                                        GoogleFonts.poppins()),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 39, 157, 196),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          color: const Color
                                                              .fromARGB(255, 39,
                                                              157, 196),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      width: 50,
                                                      child: Center(
                                                        child: Text(
                                                          "OK".tr,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        });

                                        //Get.snackbar("gfjhd","uighrkfk",snackPosition: SnackPosition.BOTTOM);
                                      }
                                      // Optional: Save to backend if needed
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Balance : ".tr,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${userController.Current_User.value!.userBalance}"+"Points".tr,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /*InkWell(
                                  onTap: () {
                                    Get.toNamed("/contact_us");
                                  },
                                  child: Icon(
                                    Icons.add_circle_outlined,
                                    size: 30,
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          margin: EdgeInsets.only(top: 5, bottom: 10),
                        ),
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue, // Border color
                              width: 1, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            color: Colors
                                .white, // Background color of the container
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons
                                        .phone, // You can replace with any icon
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Space between the icon and the text
                                  Text(
                                    userController.Current_User.value!.userPhone != null
                                        ? userController.Current_User.value!.userPhone!
                                        : "No Phone2".tr,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  showEditPhoneDialog(
                                    context,
                                    title: "Phone2".tr,
                                    initialValue: userController
                                                .Current_User.value!.userPhone !=
                                            null
                                        ? userController.Current_User.value!.userPhone!
                                        : "No Phone2".tr,
                                    onSave: (newPhone) {
                                      userController.change_userphone(newPhone);
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
                                ),
                              ),
                            ],
                          ),
                        ),
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue, // Border color
                              width: 1, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            color: Colors
                                .white, // Background color of the container
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons
                                        .email, // You can replace with any icon
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Space between the icon and the text
                                  Text(
                                    userController.Current_User.value!.userEmail != null
                                        ? (userController.Current_User.value!.userEmail!)
                                        : "No Email2".tr, // Default value when userEmail is null
                                    style: GoogleFonts.poppins(
                                        fontSize: 11, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  showEditDialog(
                                    context: context,
                                    title: "Your Email".tr,
                                    initialValue: userController
                                                .Current_User.value!.userEmail !=
                                            null
                                        ? userController.Current_User.value!.userEmail!
                                        : "",
                                    onSave: (newEmail) {
                                      if (userController.Current_User.value!.userEmail !=
                                          null) {
                                        if (newEmail ==
                                            userController
                                                .Current_User.value!.userEmail!) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Notification".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  content: Text(
                                                      "You Didn't Change the Email".tr,
                                                      style: GoogleFonts
                                                          .poppins()),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 39, 157, 196),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                39, 157, 196),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        width: 50,
                                                        child: Center(
                                                          child: Text(
                                                            "OK".tr,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          });
                                        } else {
                                          userController.change_useremail(
                                              newEmail);
                                        }
                                      }
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
                                ),
                              ),
                            ],
                          ),
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
                          "Referel_code".tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue, // Border color
                              width: 1, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            color: Colors
                                .white, // Background color of the container
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.code, // You can replace with any icon
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Space between the icon and the text
                                  Text(
                                    userController.Current_User.value!.userReferalCode!
                                        , // Default value when userEmail is null
                                    style: GoogleFonts.poppins(
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  showEditDialog(
                                    context: context,
                                    title: "Your ReferelCode".tr,
                                    initialValue: userController
                                        .Current_User.value!.userReferalCode!,
                                    onSave: (NewCode) {
                                      if (NewCode.isEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Notification".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                content: Text(
                                                    "Do not Make Empty Code".tr,
                                                    style:
                                                        GoogleFonts.poppins()),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 39, 157, 196),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          color: const Color
                                                              .fromARGB(255, 39,
                                                              157, 196),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      width: 50,
                                                      child: Center(
                                                        child: Text(
                                                          "OK".tr,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        });
                                      } else {
                                        if (NewCode ==
                                            userController
                                                .Current_User.value!.userReferalCode!) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Notification".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  content: Text(
                                                      "You Didn't Change the ReferelCode".tr,
                                                      style: GoogleFonts
                                                          .poppins()),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 39, 157, 196),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                39, 157, 196),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        width: 50,
                                                        child: Center(
                                                          child: Text(
                                                            "OK".tr,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          });
                                        } else {
                                          if (NewCode.length != 8) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              Get.snackbar("Notification".tr,
                                                  "ReferelCode Must be exactly 8 caracters".tr,
                                                  backgroundColor: Colors.red,
                                                  duration:
                                                      Duration(seconds: 7));
                                            });
                                          } else {
                                            userController
                                                .change_userReferalCode(
                                                    NewCode);
                                          }
                                        }
                                      }
                                      /* */
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
                                ),
                              ),
                            ],
                          ),
                        ),
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
                          "Invite_Code".tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 60,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue, // Border color
                              width: 1, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            color: Colors
                                .white, // Background color of the container
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.code, // You can replace with any icon
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Space between the icon and the text
                                  Text(
                                    userController.Current_User.value!.userCodeInvite !=
                                          null
                                        ?     userController.Current_User.value!.userCodeInvite!
                                        : "No Invite Code".tr, // Default value when userEmail is null
                                    style: GoogleFonts.poppins(
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*Center(
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
                          "User Address".tr,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue, // Border color
                              width: 1, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            color: Colors
                                .white, // Background color of the container
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons
                                        .location_city_rounded, // You can replace with any icon
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Space between the icon and the text
                                  userController.Current_User.value.userAddress!=null?  Text(
                                    userController.Current_User.value.userAddress!, 
                                    style: GoogleFonts.poppins(
                                        color: Colors.black),
                                    maxLines: 3,
                                  ):Text("No Adress Found",style: GoogleFonts.poppins(),),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  showEditDialog(
                                    context: context,
                                    title: "Your Adress".tr,
                                    initialValue:
                                        userController.Current_User.value.userAddress!,
                                    onSave: (NewAdress) {
                                      if (NewAdress.isEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Notification".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                content: Text(
                                                    "Do not Make Empty Adress".tr,
                                                    style:
                                                        GoogleFonts.poppins()),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 39, 157, 196),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          color: const Color
                                                              .fromARGB(255, 39,
                                                              157, 196),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      width: 50,
                                                      child: Center(
                                                        child: Text(
                                                          "OK".tr,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        });
                                      } else {
                                        if (NewAdress ==
                                             userController.Current_User.value.userAddress!) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Notification".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  content: Text(
                                                      "You Didn't Change the Adress".tr,
                                                      style: GoogleFonts
                                                          .poppins()),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 39, 157, 196),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            color: const Color
                                                                .fromARGB(255,
                                                                39, 157, 196),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        width: 50,
                                                        child: Center(
                                                          child: Text(
                                                            "OK".tr,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          });
                                        } else {
                                          userController.change_userAdress(
                                              NewAdress);
                                        }
                                      }
                                      /* */
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            )),
      ),
    );
  }

  void showEditDialog({
    required BuildContext context,
    required String title,
    required String initialValue,
    required Function(String) onSave,
  }) {
    final TextEditingController textController = TextEditingController();
    textController.text = initialValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: "Enter".tr+" : $title",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child:
                  Text("Cancel".tr, style: GoogleFonts.poppins(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                onSave(textController.text.trim());

                Get.back(); // Close the dialog after saving
              },
              child:
                  Text("Save".tr, style: GoogleFonts.poppins(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  showEditPhoneDialog(
    BuildContext context, {
    required String title,
    required String initialValue,
    required Function(String) onSave,
  }) {
    final TextEditingController phoneController = TextEditingController();
    phoneController.text = "";
    String completeNumber = "";
    bool isValidNumber = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: IntlPhoneField(
            validator: (p0) {
              if (p0!.isValidNumber()) {
                isValidNumber = true;
              } else {
                isValidNumber = false;
              }
            },
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            initialCountryCode: 'US', // Change as per requirement
            onChanged: (phone) {
              print(phone.completeNumber);
              completeNumber =
                  (phone.completeNumber); // Debug: Full phone number
            },
            onCountryChanged: (country) {
              print('Country changed to: ${country.name}');
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the dialog without saving
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        "Cancel".tr,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (!isValidNumber) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Notification".tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                "Invalid Phone Number".tr,
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 39, 157, 196),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: const Color.fromARGB(
                                          255, 39, 157, 196),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        "OK".tr,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    } else {
                      String newPhone = completeNumber;
                      if (newPhone == initialValue) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Notification".tr,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  "You Didn't Change the Phone Number".tr,
                                  style: GoogleFonts.poppins(),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 39, 157, 196),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: const Color.fromARGB(
                                            255, 39, 157, 196),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 50,
                                      child: Center(
                                        child: Text(
                                          "OK".tr,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      } else {
                        onSave(newPhone); // Save the new phone number
                      }
                    }

                    Navigator.of(context).pop(); // Close the dialog after save
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        "Save".tr,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
