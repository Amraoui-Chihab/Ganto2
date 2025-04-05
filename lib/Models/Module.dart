

class Module {
  final int? id;
  final String libelle;
  final int schoolId;

  Module({
    this.id,
    required this.libelle,
    required this.schoolId,
  });

  // Convert JSON to Matiere object
  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['ID_MATIERE'],
      libelle: json['LIB_MATIERE'],
      schoolId: json['school_id'],
    );
  }

  // Convert Matiere object to JSON
  Map<String, dynamic> toJson() {
    return {
      'ID_MATIERE': id,
      'LIB_MATIERE': libelle,
      'school_id': schoolId,
    };
  }
}