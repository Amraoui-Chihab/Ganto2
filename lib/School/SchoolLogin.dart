import 'package:flutter/material.dart';
import 'package:Ganto/Controllers/Company_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import SVG package
import 'package:intl_phone_field2/intl_phone_field.dart';
class SchoolLoginPage extends StatefulWidget {
  @override
  _SchoolLoginPageState createState() => _SchoolLoginPageState();
}

class _SchoolLoginPageState extends State<SchoolLoginPage> {
 // GeneralController _generalController = Get.find<GeneralController>();
  CompanyController _companyController = Get.find<CompanyController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true; // Control password visibility
  String? _phoneNumber;
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _login() async{
    if (_formKey.currentState == null) {
      print("Form key is null!");
      return; // Prevent further execution
    }


    if (_formKey.currentState!.validate()) {
      if(_phoneNumber == null || _phoneNumber!.isEmpty)
        {
          Get.snackbar("Alert", "Please Enter Phone Number",backgroundColor: Colors.red);
          return ;
        }
      String password = _passwordController.text;

      FocusScope.of(context).requestFocus(
          FocusNode()); // Remove focus from text fields
      await Future.delayed(Duration(
          milliseconds:
          100));

    await  _companyController.SchoolLogin(_phoneNumber!,password,context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevent overflow when keyboard appears
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(

          "School Login",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(child: Padding(
          padding: EdgeInsets.all(20).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: Get.width * 0.9,
                height: Get.height * 0.3,
                child: Image.asset("assets/school.png", fit: BoxFit.contain),
              ),


              // Email Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


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

                ],
              ),
              const SizedBox(height: 15),

              // Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12), // Inner padding
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if(value!.isEmpty)
                                {
                                  return 'Please Enter Password';
                                }
                              if(value.length<6)
                                {

                                    return 'Your Password is too Short at least\n 6 characters';

                                }
                              return null;
                            },
                            cursorColor: Colors.blue,
                            decoration: InputDecoration(

                              hintStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              hintText: "Enter Your Password",
                              border: InputBorder.none, // Removes borders
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        }, icon: Icon(_obscurePassword?Icons.visibility:Icons.visibility_off,color: Colors.blue,))

                      ],
                    ),
                  ),
                  // Space below field
                ],
              ),
              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{

                  _login();
                  },
                  child: Text("Login to School", style: GoogleFonts.poppins()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ),
            ],
          ),
        ),key: _formKey,) ,
      ),
    );
  }
}
