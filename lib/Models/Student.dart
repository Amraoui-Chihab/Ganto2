

import 'dart:convert';

class Student {
  final int id;
  final int? idParent;
  final int classeId;
  final String qrCode;
  final String nom;
  final String prenom;
  final String dateNaissance;
  final String sexe;
  final String Logo;

  Student({
    required this.id,
    this.idParent,
    required this.classeId,
    required this.qrCode,
    required this.nom,
    required this.prenom,
    required this.dateNaissance,
    required this.sexe,
    required this.Logo
  });

  // Convert JSON to Student object
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      Logo: json["Student_Logo"],
      id: json['ID_ELEVE'],
      idParent: json['ID_PARENT'],
      classeId: json['CLASSE_ID'],
      qrCode: json['QR_CODE'],
      nom: json['NOM_ELEVE'],
      prenom: json['PRENOM_ELEVE'],
      dateNaissance: json['DATE_NAISSANCE'],
      sexe: json['SEXE_ELEVE'],
    );
  }

  // Convert Student object to JSON
  Map<String, dynamic> toJson() {
    return {
      'Student_Logo':Logo,
      'ID_ELEVE': id,
      'ID_PARENT': idParent,
      'CLASSE_ID': classeId,
      'QR_CODE': qrCode,
      'NOM_ELEVE': nom,
      'PRENOM_ELEVE': prenom,
      'DATE_NAISSANCE': dateNaissance,
      'SEXE_ELEVE': sexe,
    };
  }




  // Convert JSON list to a list of Students
  static List<Student> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Student.fromJson(json)).toList();
  }
}
