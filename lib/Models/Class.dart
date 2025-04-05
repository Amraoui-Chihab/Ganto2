
class Class {
  final int classId;
  final String className;
  final String OptionName;

  Class({required this.classId, required this.className, required this.OptionName});

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'classId': classId,
      'className': className,
      'OptionName':OptionName
    };
  }

  // Create from JSON
  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      classId: json['CLASSE_ID'],
      className: json['CLASSE_NOM'],
      OptionName: json['option']['LIB_OPTION'],
    );
  }

  // Convert a list of JSON objects to a List<Class>
  static List<Class> listFromJson(dynamic jsonList) {
    if (jsonList is List) {

      return jsonList.map((json) {
        print(json);
       return Class.fromJson(json);
      }).toList();
    }
    return [];
  }
}
