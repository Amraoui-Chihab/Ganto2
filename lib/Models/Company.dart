class Company {
  int? companyId; // Primary key
  double? companyBalance; // Company balance
  String? companyName; // Company name
  String? companyDescription; // Company description
  String? companyEmail; // Company email
  String? companyPassword; // Company password
  String? companyPhone; // Company phone
  String? companyDomain; // Company domain
  String? companyInstagramUrl; // Company Instagram URL
  String? companyTiktokUrl; // Company TikTok URL
  String? companyLinkedinUrl; // Company LinkedIn URL
  String? companyLogo; // Company logo URL
  DateTime? createdAt; // Created timestamp
  DateTime? updatedAt; // Updated timestamp
  String? Company_status;
  // Constructor
  Company({
  
   this.companyId,
    this.companyBalance,
    this.companyName,
    this.companyDescription,
    this.companyEmail,
    this.companyPassword,
    this.companyPhone,
    this.companyDomain,
    this.companyInstagramUrl,
    this.companyTiktokUrl,
    this.companyLinkedinUrl,
    this.companyLogo,
    this.Company_status,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      Company_status: json['company_status'],
      companyId: json['company_id'],
      companyBalance: json['company_balance']?.toDouble(),
      companyName: json['company_name'],
      companyDescription: json['company_description'],
      companyEmail: json['company_email'],
      companyPassword: json['company_password'],
      companyPhone: json['company_phone'],
      companyDomain: json['company_domaine'],
      companyInstagramUrl: json['company_instagram_url'],
      companyTiktokUrl: json['company_tiktok_url'],
      companyLinkedinUrl: json['company_linkedin_url'],
      companyLogo: json['company_logo'],
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'company_status':Company_status,
      'company_id': companyId,
      'company_balance': companyBalance,
      'company_name': companyName,
      'company_description': companyDescription,
      'company_email': companyEmail,
      'company_password': companyPassword,
      'company_phone': companyPhone,
      'company_domain': companyDomain,
      'company_instagram_url': companyInstagramUrl,
      'company_tiktok_url': companyTiktokUrl,
      'company_linkedin_url': companyLinkedinUrl,
      'company_logo': companyLogo,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
