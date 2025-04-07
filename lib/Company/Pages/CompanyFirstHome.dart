import 'package:flutter/material.dart';

import 'package:Ganto/Controllers/Company_controller.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';




class Companyfirsthome extends StatefulWidget {
  const Companyfirsthome({super.key});

  @override
  State<Companyfirsthome> createState() => _CompanyfirsthomeState();
}

class _CompanyfirsthomeState extends State<Companyfirsthome> {





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // companyController.Get_Top_Selled_Products();
  }
  
  CompanyController companyController = Get.find<CompanyController>();
 // GeneralController _GeneralController = Get.find<GeneralController>();

  String currentlanguage ="English";
  
  @override
  Widget build(BuildContext context) {
  
    return WillPopScope(
        child: Scaffold(
          
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 40),
                      width: Get.width,
                      color: Colors.blue,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: companyController
                                        .company.value!.companyLogo !=
                                    null
                                ? NetworkImage(companyController
                                    .company.value!.companyLogo!)
                                : null, // Show image if userPhotoUrl is not null
                            child: companyController
                                        .company.value!.companyLogo ==
                                    null
                                ? Icon(Icons.account_circle,
                                    size: 50.0,
                                    color: Colors
                                        .white) // Default avatar icon when photo is null
                                : null, // If photo is not null, child is null
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "Name : ".tr +
                                  companyController.company.value!.companyName!,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              companyController.company.value!.companyEmail !=
                                      null
                                  ? "Email".tr +" : "+
                                      companyController
                                          .company.value!.companyEmail!
                                  : "No Email".tr,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                            
                              companyController.company.value!.companyPhone !=
                                      null
                                  ? "Phone : ".tr +
                                      companyController
                                          .company.value!.companyPhone!
                                  : "no phone".tr,
                                  textDirection: TextDirection.ltr,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  

                  // Functionalities
                 /* ListTile(
                    leading: Icon(Icons.factory, color: Colors.blue),
                    // Adjust padding for indentation
                    title: Text(
                        'Show All Companies'.tr,
                        style: GoogleFonts.poppins(),
                      ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => ShowCompaniesForCompany());
                    },
                  ),*/
                /*  ListTile(
                    leading: Icon(
                      Icons.inventory,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Show All Products'.tr,
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                      Get.to(() => ShowproductsCompany());
                    },
                  ),*/

                 /* ListTile(
                    leading: Icon(
                      Icons.contact_support_rounded,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'ContactUs'.tr,
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController messageController =
                              TextEditingController();

                          return AlertDialog(
                            title: Text(
                              'ContactUs'.tr,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            content: TextFormField(
                              controller: messageController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: 'Message Content'.tr,
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
                              ElevatedButton(
                                onPressed: () {
                                  String message =
                                      messageController.text.trim();
                                  if (message.isNotEmpty) {
                                    companyController.sendMessage(
                                        messageContent: message,
                                        receiverId: 1.toString(),
                                        ownerId: companyController
                                            .company.value.companyId
                                            .toString(),
                                        context: context);
                                  } else {
                                    Get.snackbar(
                                      'Error'.tr,
                                      'Message content cannot be empty.'.tr,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                child: Text('Save'.tr),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),*/
                  ListTile(
                    leading: Icon(Icons.change_circle, color: Colors.blue),
                    // Adjust padding for indentation
                    title: Text(
                        'Change Language'.tr,
                        style: GoogleFonts.poppins(),
                      ),
                    onTap: () async {
                      Navigator.pop(context); // Close the drawer
                      // Implement logout functionality
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            'Choose the language you want to use '.tr,
                            style: GoogleFonts.poppins(),
                          ),
                          content: DropdownButton<String>(
                                value: currentlanguage,
                               
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
                                dropdownColor: Colors.white,
                                style: TextStyle(color: Colors.black),
                                underline:
                                    SizedBox(), // Remove default underline
                                onChanged: (String? newValue) {
                                 currentlanguage = newValue!;
                                    if(newValue=="English")
                                    {
                                      
                                      Get.updateLocale(Locale('en'));
                                    }
                                    else
                                    {
                                      
                                      Get.updateLocale(Locale('ar'));
                                    }
                                    Navigator.pop(context);

                                  
                                },
                                items: <String>[
                                  'English',
                                  'Arabic',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                         /* actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, // Cancel logout
                              child:
                                  Text('Cancel', style: GoogleFonts.poppins()),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Confirm logout
                                Navigator.pop(context); // Close dialog
                                // Redirect or clear user data

                               
                              },
                              child:
                                  Text('Ok', style: GoogleFonts.poppins()),
                            ),
                          ],*/
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'About Us'.tr,
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                      Get.toNamed("/About_Us");
                    },
                  ),
                   /*ListTile(
                    leading: Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Delete Company'.tr,
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                     companyController.deleteCompany(companyController.company.value.companyId!);
                    },
                  ),*/

                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.blue,
                    ),
                    title: Text(
                      'Logout'.tr,
                      style: GoogleFonts.poppins(),
                    ),
                    onTap: () {
                      // Handle Logout
                      Navigator.pop(context); // Close the drawer
                      // Implement logout functionality
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            'Logout'.tr,
                            style: GoogleFonts.poppins(),
                          ),
                          content: Text('Are you sure you want to logout'.tr,
                              style: GoogleFonts.poppins()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, // Cancel logout
                              child:
                                  Text('Cancel'.tr, style: GoogleFonts.poppins(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () async {

                                Navigator.pop(context);


                                  await companyController.logout();

                              },
                              child:
                                  Text('Logout'.tr, style: GoogleFonts.poppins(color: Colors.blue)),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
          ),
          floatingActionButton: Obx(() => companyController.Is_sub_Catgorgy.value
              ? FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => companyController.NavigateBack())
              : SizedBox.shrink()),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Categories',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.blue,
          ),
          body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 16.0, // Spacing between columns
                mainAxisSpacing: 16.0, // Spacing between rows
              ),
              itemCount: companyController.categories.length,
              itemBuilder: (context, index) {
                return Obx(() => CategoryCardCompany(

                  name: companyController.categories.value[index]['name']!,
                  imagePath: companyController.categories.value[index]
                  ['image']!,
                ));
              },
            ),
          )),
          backgroundColor: Colors.white,
        ),
        onWillPop: () async {
          return false;
        });
  }
}

class CategoryCardCompany extends StatelessWidget {
  final String name;
  final String imagePath;
  CompanyController _companyController = Get.find<CompanyController>();
  CategoryCardCompany({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () => _companyController.Navigate_Between_Categories(name),
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.2),
                Colors.blue.withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Constrained Image to prevent overflow
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain, // Ensures image scales within space
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
