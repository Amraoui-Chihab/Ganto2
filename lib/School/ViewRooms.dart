

import 'package:flutter/material.dart';
import 'package:ganto_shop/Models/Room.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/SchoolController.dart';

class ViewRooms extends StatefulWidget {
  const ViewRooms({super.key});

  @override
  State<ViewRooms> createState() => _ViewRoomsState();
}

class _ViewRoomsState extends State<ViewRooms> {
  SchoolController _schoolControler = Get.find<SchoolController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "View All Rooms",
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
                  if (_schoolControler.Rooms.isEmpty) {
                    return Center(
                      child: Text(
                        "No Room Found",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.Rooms.length,
                    itemBuilder: (context, index) {
                      Room room = _schoolControler.Rooms[index];
                      return ListTile(
                        tileColor: Colors.grey[300],
                        title: Text(
                          "RoomName : " + room.libelle,
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        subtitle:Text(
                          "RoomCapacity : " + room.capacite.toString(),
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ) ,
                      );
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
}
