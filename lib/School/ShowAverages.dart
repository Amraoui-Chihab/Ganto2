import 'package:flutter/material.dart';
import 'package:Ganto/Models/Average.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/SchoolController.dart';

class ShowAverages extends StatefulWidget {
  const ShowAverages({super.key});

  @override
  State<ShowAverages> createState() => _ShowAveragesState();
}

class _ShowAveragesState extends State<ShowAverages> {
  SchoolController _schoolControler = Get.find<SchoolController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _schoolControler.GetTrimesters();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Form(child: AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Add Average",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Minimize space usage
                    children: [
                      BuildDropdownFieldDataTrim("Select Trimester"),
                      SizedBox(height: 10),
                      BuildFieldData("Average", "Please Enter Average"),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel",
                        style: GoogleFonts.poppins(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){

                        FocusScope.of(context).requestFocus(
                            FocusNode()); // Remove focus from text fields
                        await Future.delayed(Duration(milliseconds: 100));
                        Navigator.of(context).pop();
                        await _schoolControler.PutAverage(
                            int.parse(Get.parameters["StudentId"]!),
                            int.parse(SelectedTrimester!),
                            double.parse(AverageController.text),
                            context);

                      }


                    },
                    child: Text("Add",
                        style: GoogleFonts.poppins(color: Colors.blue)),
                  ),
                ],
              ),key: _formKey,);
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "View Averages",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (_schoolControler.Averages.isEmpty) {
                    return Center(
                      child: Text(
                        "No Average Yet",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.Averages.length,
                    itemBuilder: (context, index) {
                      Average average = _schoolControler.Averages[index];
                      return ListTile(
                          tileColor: Colors.grey[300],
                          title: Text(
                            "average : " + average.average_note.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TrimesterId : " +
                                    average.Trimester_Id.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Trimester Name : " +
                                    average.Trimester_lib.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ));
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? SelectedTrimester;

  Widget BuildDropdownFieldDataTrim(String labelText) {
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
        _schoolControler.Trimesters.isNotEmpty
            ? SizedBox(
                width: Get.width * 0.9, // 80% screen width
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if(value==null || value.isEmpty)
                      {
                        return 'Please Select Trimester';
                      }
                    return null;
                  },
                  dropdownColor: Colors.white,
                  value: SelectedTrimester,
                  items:
                      _schoolControler.Trimesters.map<DropdownMenuItem<String>>(
                          (Trim) {
                    return DropdownMenuItem<String>(
                      value: Trim.id.toString(),
                      child: Text(Trim.libelle ?? 'No Name'),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    SelectedTrimester = newValue;
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
                        "No Trimester Found",
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
                          Get.toNamed("/AddTrimester");
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

  TextEditingController AverageController = new TextEditingController();
  Widget BuildFieldData(String labelText, String hintText) {
     // Add form key

    return  Column(
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
              color: Colors.grey[200], // Light grey background
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 12), // Inner padding
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty || value!.isAlphabetOnly)
                        {
                          return 'Please Enter Valid Average';
                        }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: AverageController,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      hintText: hintText,
                      border: InputBorder.none, // Removes borders
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10), // Space below field
        ],
      )

    ;
  }
}
