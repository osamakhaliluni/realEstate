class UserModel {
  final String? id; // Optional, in case you want to store MongoDB _id
  final String fName;
  final String? lName;
  final String? phone;
  final String email;
  final String? image;

  UserModel({
    this.id,
    required this.fName,
    this.lName,
    this.phone,
    required this.email,
    this.image,
  });

  // Factory constructor to create a UserModel from JSON (e.g., from a MongoDB document)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      fName: json['fName'] as String,
      lName: json['lName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String,
      image: json['image'] as String?,
    );
  }

  // Method to convert a UserModel instance to JSON (e.g., to send to your backend)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fName': fName,
      'lName': lName,
      'phone': phone,
      'email': email,
      'image': image,
    };
  }
}
