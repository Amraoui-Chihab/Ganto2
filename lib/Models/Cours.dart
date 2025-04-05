import 'dart:convert';

class Cours {
  final int? idCours;
  final int idEnseignant;
  final int classeId;
  final int idSalle;
  final int idMatiere;
  final int idTrimester;
  final String dateCours;
  final String heureDebutCours;
  final String heureFinCour;

  Cours({
    this.idCours,
    required this.idEnseignant,
    required this.classeId,
    required this.idSalle,
    required this.idMatiere,
    required this.idTrimester,
    required this.dateCours,
    required this.heureDebutCours,
    required this.heureFinCour,
  });

  /// Convert JSON to a Cours object
  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
      idCours: json['ID_COURS'],
      idEnseignant: json['ID_ENSEIGNANT'],
      classeId: json['CLASSE_ID'],
      idSalle: json['ID_SALLE'],
      idMatiere: json['ID_MATIERE'],
      idTrimester: json['ID_TRIMESTER'],
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
      "CLASSE_ID": classeId,
      "ID_SALLE": idSalle,
      "ID_MATIERE": idMatiere,
      "ID_TRIMESTER": idTrimester,
      "DATE_COURS": dateCours,
      "HEURE_DEBUT_COURS": heureDebutCours,
      "HEURE_FIN_COUR": heureFinCour,
    };
  }

  /// Convert a JSON list to a List<Cours>
  static List<Cours> listFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Cours>.from(data.map((item) => Cours.fromJson(item)));
  }

  /// Convert a List<Cours> to JSON
  static String listToJson(List<Cours> courses) {
    return json.encode(List<dynamic>.from(courses.map((c) => c.toJson())));
  }
}
