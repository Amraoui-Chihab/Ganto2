import 'dart:convert';

class FullCourse {
  final int? idCours;
  final int idEnseignant;
  final String NOM_ENSEIGNANT;
  final String PRENOM_ENSEIGNANT;
  final int classeId;
  final String CLASSE_NOM;

  final int idSalle;
  final String LIB_SALLE;

  final int idMatiere;
  final String LIB_MATIERE;
  final int idTrimester;
  final String LIB_TRIMESTRE;

  final String dateCours;
  final String heureDebutCours;
  final String heureFinCour;

  FullCourse({
    this.idCours,
    required this.idEnseignant,
    required this.NOM_ENSEIGNANT,
    required this.PRENOM_ENSEIGNANT,
    required this.classeId,
    required this.CLASSE_NOM,
    required this.idSalle,
    required this.LIB_SALLE,
    required this.idMatiere,
    required this.LIB_MATIERE,
    required this.idTrimester,
    required this.LIB_TRIMESTRE,
    required this.dateCours,
    required this.heureDebutCours,
    required this.heureFinCour,
  });

  /// Convert JSON to a Cours object
  factory FullCourse.fromJson(Map<String, dynamic> json) {


    return FullCourse(
      idCours: json['ID_COURS'],
      idEnseignant: json['ID_ENSEIGNANT'],
      NOM_ENSEIGNANT: json['NOM_ENSEIGNANT'],
      PRENOM_ENSEIGNANT: json['PRENOM_ENSEIGNANT'],
      classeId: json['CLASSE_ID'],
      CLASSE_NOM: json["CLASSE_NOM"],
      idSalle: json['ID_SALLE'],
      LIB_SALLE : json["LIB_SALLE"],
      idMatiere: json['ID_MATIERE'],
      LIB_MATIERE : json["LIB_MATIERE"],
      idTrimester: json['ID_TRIMESTER'],
      LIB_TRIMESTRE : json["LIB_TRIMESTRE"],
      dateCours: json['DATE_COURS'],
      heureDebutCours: json['HEURE_DEBUT_COURS'],
      heureFinCour: json['HEURE_FIN_COUR'],
    );
  }

  /// Convert Cours object to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      "ID_COURS": idCours,
      "ID_ENSEIGNANT": idEnseignant,
      "NOM_ENSEIGNANT": NOM_ENSEIGNANT,
      "PRENOM_ENSEIGNANT":PRENOM_ENSEIGNANT,
      "CLASSE_ID": classeId,
      "CLASSE_NOM":CLASSE_NOM,
      "ID_SALLE": idSalle,
      "LIB_SALLE":LIB_SALLE,
      "ID_MATIERE": idMatiere,
      "LIB_MATIERE":LIB_MATIERE,
      "ID_TRIMESTER": idTrimester,
      "LIB_TRIMESTRE":LIB_TRIMESTRE,
      "DATE_COURS": dateCours,
      "HEURE_DEBUT_COURS": heureDebutCours,
      "HEURE_FIN_COUR": heureFinCour,
    };
  }

  /// Convert a JSON list to a List<Cours>
  static List<FullCourse> listFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<FullCourse>.from(data.map((item) => FullCourse.fromJson(item)));
  }

  /// Convert a List<Cours> to JSON
  static String listToJson(List<FullCourse> courses) {
    return json.encode(List<dynamic>.from(courses.map((c) => c.toJson())));
  }
}
