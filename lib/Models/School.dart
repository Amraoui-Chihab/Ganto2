class School {
  final int schoolId;
  final String schoolName;
  final String schoolEmail;
  final String schoolPhone;
  final String directorName;
  final String directorLastname;
  final DateTime creationDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String Logo;

  School({
    required this.schoolId,
    required this.schoolName,
    required this.schoolEmail,
    required this.schoolPhone,
    required this.directorName,
    required this.directorLastname,
    required this.creationDate,
    required this.createdAt,
    required this.updatedAt,
    required this.Logo
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      schoolId: json['school_id'],
      schoolName: json['school_name'],
      schoolEmail: json['school_email'],
      schoolPhone: json['school_phone'],
      directorName: json['director_name'],
      directorLastname: json['director_lastname'],
      creationDate: DateTime.parse(json['creation_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      Logo: json['school_logo']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'school_logo':Logo,
      'school_id': schoolId,
      'school_name': schoolName,
      'school_email': schoolEmail,
      'school_phone': schoolPhone,
      'director_name': directorName,
      'director_lastname': directorLastname,
      'creation_date': creationDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
