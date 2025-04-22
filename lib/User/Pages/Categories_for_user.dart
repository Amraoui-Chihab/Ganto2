

import 'package:flutter/material.dart';
import 'package:Ganto/Controllers/User_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class CategoriesForUser extends StatefulWidget {
  const CategoriesForUser({super.key});

  @override
  State<CategoriesForUser> createState() => _CategoriesForUserState();
}

class _CategoriesForUserState extends State<CategoriesForUser> {
  UserController userController = Get.find<UserController>();
 // GeneralController _GeneralController = Get.find<GeneralController>();
  String currentlanguage = "English";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                width: Get.width,
                color: Colors.blue,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      height: 40,
                      child: Center(
                          child: Text(
                        "UserDashboard",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                            fontWeight: FontWeight.bold, fontSize: 30),
                        overflow: TextOverflow.ellipsis,

                        textAlign: TextAlign.end,
                      )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              /*  ListTile(
                leading: Icon(
                  Icons.contact_support_rounded,
                  color: Colors.blue,
                ),
                title: Text(
                  'ContactUs'.tr,
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Get.toNamed("/contact_us");
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

                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        dropdownColor: Colors.white,
                        style: TextStyle(color: Colors.black),
                        underline: SizedBox(), // Remove default underline
                        onChanged: (String? newValue) {
                          currentlanguage = newValue!;
                          if (newValue == "English") {
                            Get.updateLocale(Locale('en'));
                          } else {
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
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: Text(
                  'Delete Account'.tr,
                  style: GoogleFonts.poppins(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Implement logout functionality
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        'Delete Account'.tr,
                        style: GoogleFonts.poppins(),
                      ),
                      content: Text('Are you sure you want to delete the account ?'.tr,
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
                            // Confirm logout
                            Navigator.pop(context); // Close dialog
                            // Redirect or clear user data
                            await userController.deleteAccount();

                          },
                          child:
                          Text('Delete'.tr, style: GoogleFonts.poppins(color: Colors.blue)),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text(
                  'Logout'.tr,
                  style: GoogleFonts.poppins(color: Colors.red),
                ),
                onTap: () {
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
                            // Confirm logout
                            Navigator.pop(context); // Close dialog
                            // Redirect or clear user data

                            try {
                              userController.Logout();
                            } catch (e) {
                              Get.snackbar(
                                  "Error".tr, "Error".tr + " ${e.toString()}",
                                  backgroundColor: Colors.red);
                            }
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
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Obx(() => userController.Is_sub_Catgorgy.value
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => userController.NavigateBack())
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
              itemCount: userController.categories.length,
              itemBuilder: (context, index) {
                return Obx(() => CategoryCard(

                      name: userController.categories.value[index]['name']!,
                      imagePath: userController.categories.value[index]
                          ['image']!,
                    ));
              },
            ),
          )),
    );
  }
}


class CategoryCard extends StatelessWidget {
  final String name;
  final String imagePath;
  UserController userController = Get.find<UserController>();
  CategoryCard({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () => userController.Navigate_Between_Categories(name),
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
