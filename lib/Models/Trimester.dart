class Trimestre {
  final int? id;
  final int schoolId;
  final String libelle;
  final int number;

  Trimestre({
    this.id,
    required this.schoolId,
    required this.libelle,
    required this.number,
  });

  // Convert JSON to Trimestre object
  factory Trimestre.fromJson(Map<String, dynamic> json) {
    return Trimestre(
      id: json['TRIMERSTRE_ID'],
      schoolId: json['school_id'],
      libelle: json['LIB_TRIMESTRE'],
      number: json['NUMBER_TRIMESTRE'],
    );
  }

  // Convert Trimestre object to JSON
  Map<String, dynamic> toJson() {
    return {
      'TRIMERSTRE_ID': id,
      'school_id': schoolId,
      'LIB_TRIMESTRE': libelle,
      'NUMBER_TRIMESTRE': number,
    };
  }
}