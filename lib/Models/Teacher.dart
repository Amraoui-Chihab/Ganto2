class Teacher {
  int id;
  String nom;
  String prenom;
  String adresse;
  String dateNaissance;
  String qrCode;
  bool qrCodeUsed;
  int schoolId;
  String Logo;

  Teacher({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.adresse,
    required this.dateNaissance,
    required this.qrCode,
    required this.qrCodeUsed,
    required this.schoolId,
    required this.Logo
  });

  // Factory constructor to create an instance from JSON
  factory Teacher.fromJson(Map<String, dynamic> json) {
    print(json);
    print("uiruijbkjhjhgfjd");
    return Teacher(
      id: json['ID_ENSEIGNANT'],
      nom: json['NOM_ENSEIGNANT'],
      prenom: json['PRENOM_ENSEIGNANT'],
      adresse: json['ADRESSE_ENSEIGNANT'],
      dateNaissance: json['DATE_NAISSANCE_ENSEIGNANT'],
      qrCode: json['QR_CODE'],
      qrCodeUsed: json['QR_CODE_USED'] == 1, // Assuming 1 means true
      schoolId: json['school_id'],
      Logo: json['Teacher_Logo']
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'Teacher_Logo':Logo,
      'ID_ENSEIGNANT': id,
      'NOM_ENSEIGNANT': nom,
      'PRENOM_ENSEIGNANT': prenom,
      'ADRESSE_ENSEIGNANT': adresse,
      'DATE_NAISSANCE_ENSEIGNANT': dateNaissance,
      'QR_CODE': qrCode,
      'QR_CODE_USED': qrCodeUsed ? 1 : 0, // Convert bool to int
      'school_id': schoolId,
    };
  }
}
