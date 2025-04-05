import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ganto_shop/Controllers/SchoolController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Models/Teacher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
class ViewTeachers extends StatefulWidget {
  const ViewTeachers({super.key});

  @override
  State<ViewTeachers> createState() => _ViewTeachersState();
}

class _ViewTeachersState extends State<ViewTeachers> {
  SchoolController _schoolControler = Get.find<SchoolController>();

  Future<void> shareQRCode(String qrData,String Name,String LastName) async {
    try {
      // Create a QR painting area
      final qrPainter = QrPainter(
        data: qrData,
        version: QrVersions.auto,
        gapless: false,
        color: Colors.black,
        emptyColor: Colors.white,
      );

      // Define the size of the QR code
      final size = 200.0;

      // Create a picture recorder to capture the QR code
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Draw white background
      canvas.drawRect(
        Rect.fromPoints(Offset.zero, Offset(size, size)),
        Paint()..color = Colors.white,
      );

      // Draw the QR code on the canvas
      qrPainter.paint(canvas, Size(size, size));

      // Convert to image
      final picture = recorder.endRecording();
      final img = await picture.toImage(size.toInt(), size.toInt());
      final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

      if (pngBytes == null) {
        throw Exception("Failed to generate QR code image");
      }

      // Save to file
      final tempDir = await getTemporaryDirectory();
      final qrFile = File('${tempDir.path}/qr_code.png');
      await qrFile.writeAsBytes(pngBytes.buffer.asUint8List());

      // Share the QR code
      await Share.shareXFiles([XFile(qrFile.path)], text: "This QRCODE for ${Name} ${LastName}!");
    } catch (e) {
      print("Error generating QR code: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "View All Teachers",
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
                  if (_schoolControler.Teachers.isEmpty) {
                    return Center(
                      child: Text("No Teacher Found"),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                    itemCount: _schoolControler.Teachers.length,
                    itemBuilder: (context, index) {
                      Teacher teacher = _schoolControler.Teachers[index];
                      return ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              Get.dialog(
                                Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "QR Code for ${teacher.nom}",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        QrImageView(
                                          data: teacher.qrCode,
                                          size: 200,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                            onPressed: () => shareQRCode(teacher.qrCode,teacher.nom,teacher.prenom),
                                              child: Text("Share",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                  )),
                                            ),
                                            TextButton(
                                              onPressed: () => Get.back(),
                                              child: Text("Close",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.qr_code_2_outlined,
                              color: Colors.blue,
                            )),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(teacher.Logo),
                          backgroundColor: Colors.white,
                        ),
                        tileColor: Colors.grey[300],
                        title: Text(
                          teacher.nom + " " + teacher.prenom,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Adresse : ${teacher.adresse}",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "BirthDate : ${teacher.dateNaissance}",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
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
