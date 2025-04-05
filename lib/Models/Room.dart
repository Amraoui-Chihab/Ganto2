

class Room {
  final int? id;
  final int schoolId;
  final String libelle;
  final int? capacite;

  Room({
    this.id,
    required this.schoolId,
    required this.libelle,
    this.capacite,
  });

  // Convert JSON to SalleCours object
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['ID_SALLE'],
      schoolId: json['school_id'],
      libelle: json['LIB_SALLE'],
      capacite: json['CAPACITE_SALLE'],
    );
  }

  // Convert SalleCours object to JSON
  Map<String, dynamic> toJson() {
    return {
      'ID_SALLE': id,
      'school_id': schoolId,
      'LIB_SALLE': libelle,
      'CAPACITE_SALLE': capacite,
    };
  }
}