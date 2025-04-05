import 'dart:convert';

class Exam {
  final int idExam;
  final String libExam;
  final DateTime dateExam;
  final String teacherName;
  final String teacherLastName;
  final String libModule;
  final String libTrimester;

  final String className;
  final String RoomName;

  Exam({
    required this.idExam,
    required this.libExam,
    required this.dateExam,
    required this.teacherName,
    required this.teacherLastName,
    required this.libModule,
    required this.libTrimester,

    required this.className,
    required this.RoomName,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      idExam: json['ID_EXAMEN'],
      libExam: json['EXAM_DESCRIPTION'],
      dateExam: DateTime.parse(json['EXAM_DATE']),
      teacherName: json['teacher']['NOM_ENSEIGNANT'],
      teacherLastName: json['teacher']['PRENOM_ENSEIGNANT'],
      libModule: json['matiere']['LIB_MATIERE'],
      libTrimester: json['trimestre']['LIB_TRIMESTRE'],
      RoomName: json['room']['LIB_SALLE'],
      className: json['classe']['CLASSE_NOM'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idExam': idExam,
      'LibExam': libExam,
      'DateExam': dateExam.toIso8601String(),
      'TeacherName': teacherName,
      'TeacherLastName': teacherLastName,
      'LibModule': libModule,
      'LibTrimester': libTrimester,
      'RoomName':RoomName,
      'ClassName': className,
    };
  }

  static List<Exam> listFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Exam>.from(data.map((item) => Exam.fromJson(item)));
  }
}
