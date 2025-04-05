class Link {
  final String moduleName;
  final String specialityName;
  final int coefficient;

  Link({
    required this.moduleName,
    required this.specialityName,
    required this.coefficient,
  });

  // Factory constructor for creating a Link object from JSON
  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      moduleName: json["matiere"]['LIB_MATIERE'],
      specialityName: json["option"]['LIB_OPTION'],
      coefficient: json['COEFFICIENT_MATIERE'],
    );
  }

  // Convert Link object to JSON
  Map<String, dynamic> toJson() {
    return {
      'moduleName': moduleName,
      'specialityName': specialityName,
      'coefficient': coefficient,
    };
  }
}
