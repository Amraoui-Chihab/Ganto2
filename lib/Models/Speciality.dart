

class Specialite {
  final int? id;
  final String libelle;
  final int schoolId;

  Specialite({
    this.id,
    required this.libelle,
    required this.schoolId,
  });

  // Convert JSON to Specialite object
  factory Specialite.fromJson(Map<String, dynamic> json) {
    return Specialite(
      id: json['ID_OPTION'],
      libelle: json['LIB_OPTION'],
      schoolId: json['SCHOOL_ID'],
    );
  }

  // Convert Specialite object to JSON
  Map<String, dynamic> toJson() {
    return {
      'ID_OPTION': id,
      'LIB_OPTION': libelle,
      'SCHOOL_ID': schoolId,
    };
  }
}
