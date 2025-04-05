
import 'package:ganto_shop/Models/Student.dart';

class Average
{
  final String Trimester_lib;
  final int Trimester_Id;
  final double average_note;


  Average({required this.Trimester_lib, required this.Trimester_Id, required this.average_note});

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Trimester_lib': Trimester_lib,
      'Trimester_Id': Trimester_Id,
      'average_note':average_note
    };
  }

  // Create from JSON
  factory Average.fromJson(Map<String, dynamic> json) {
    return Average(
      Trimester_lib: json['trimester']['LIB_TRIMESTRE'],
      Trimester_Id: json['Id_Trimester'],
      average_note: json['average'],
    );
  }

  // Convert a list of JSON objects to a List<Class>
  static List<Average> listFromJson(dynamic jsonList) {
    if (jsonList is List) {

      return jsonList.map((json) {
        print(json);
        return Average.fromJson(json);
      }).toList();
    }
    return [];
  }
}