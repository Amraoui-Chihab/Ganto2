class Absence {
  final String motif;
  final int idCours;
  final String dateCours;
  final String heureDebutCours;
  final String heureFinCours;
  final String nomEnseignant;
  final String prenomEnseignant;
  final String classeNom;
  final String libSalle;
  final String libMatiere;
  final String libTrimestre;
  final int idEleve;
  final String nomEleve;
  final String prenomEleve;
  
  Absence({
    required this.motif,
    required this.idCours,
    required this.dateCours,
    required this.heureDebutCours,
    required this.heureFinCours,
    required this.nomEnseignant,
    required this.prenomEnseignant,
    required this.classeNom,
    required this.libSalle,
    required this.libMatiere,
    required this.libTrimestre,
    required this.idEleve,
    required this.nomEleve,
    required this.prenomEleve,
  });

  // Factory constructor to create an Absence from JSON
  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      motif: json['MOTIF'],
      idCours: json['COURS']['ID_COURS'],
      dateCours: json['COURS']['DATE_COURS'],
      heureDebutCours: json['COURS']['HEURE_DEBUT_COURS'],
      heureFinCours: json['COURS']['HEURE_FIN_COUR'],
      nomEnseignant: json['Teacher']['NOM_ENSEIGNANT'],
      prenomEnseignant: json['Teacher']['PRENOM_ENSEIGNANT'],
      classeNom: json['Class']['CLASSE_NOM'],
      libSalle: json['Salle']['LIB_SALLE'],
      libMatiere: json['Module']['LIB_MATIERE'],
      libTrimestre: json['Trimester']['LIB_TRIMESTRE'],
      idEleve: json['ELEVE']['ID_ELEVE'],
      nomEleve: json['ELEVE']['NOM'],
      prenomEleve: json['ELEVE']['PRENOM'],
    );
  }

  // Convert an Absence object to JSON
  Map<String, dynamic> toJson() {
    return {
      'MOTIF': motif,
      'COURS': {
        'ID_COURS': idCours,
        'DATE_COURS': dateCours,
        'HEURE_DEBUT_COURS': heureDebutCours,
        'HEURE_FIN_COUR': heureFinCours,
      },
      'Teacher': {
        'NOM_ENSEIGNANT': nomEnseignant,
        'PRENOM_ENSEIGNANT': prenomEnseignant,
      },
      'Class': {
        'CLASSE_NOM': classeNom,
      },
      'Salle': {
        'LIB_SALLE': libSalle,
      },
      'Module': {
        'LIB_MATIERE': libMatiere,
      },
      'Trimester': {
        'LIB_TRIMESTRE': libTrimestre,
      },
      'ELEVE': {
        'ID_ELEVE': idEleve,
        'NOM': nomEleve,
        'PRENOM': prenomEleve,
      },
    };
  }
}
