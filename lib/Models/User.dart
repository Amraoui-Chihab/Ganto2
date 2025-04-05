

class User {
  int? userId; 
  String? username;
  String? userEmail; // Nullable field
  String? userPassword;
  String? userPhone; // Nullable field
  String? userPhotoUrl; // Nullable field
  String? userReferalCode;
  double? userBalance; // Corrected from Double to double
  String? userCodeInvite; // Nullable field
  String? userAddress; // Nullable field
  DateTime? createdAt; // Nullable DateTime
  DateTime? updatedAt; // Nullable DateTime

  // Constructor
  User({
     this.userId,
     this.username,
    this.userEmail,
     this.userPassword,
    this.userPhone,
    this.userPhotoUrl,
     this.userReferalCode,
     this.userBalance,
    this.userCodeInvite,
    this.userAddress,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    
    return User(
      userId: json['user_id'] as int,
      username: json['user_name'] as String,
      userEmail: json['user_email'],
      userPassword: json['user_password'] as String,
      userPhone: json['user_phone'] ,
      userPhotoUrl: json['user_logo'],
      userReferalCode: json['user_referal_code'] as String,
      userBalance: (json['user_balance']).toDouble(), // Ensure double conversion
      userCodeInvite: json['user_code_invite'],
      userAddress: json['user_adress'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': username,
      'user_email': userEmail,
      'user_password': userPassword,
      'user_phone': userPhone,
      'user_photo_url': userPhotoUrl,
      'user_referal_code': userReferalCode,
      'user_balance': userBalance,
      'user_code_invite': userCodeInvite,
      'user_adress': userAddress,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
