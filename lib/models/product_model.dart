class ProductModel {
  final String id; // Assuming ObjectId is stored as a string
  // final String owner; // Owner ID as a string
  final String title;
  final double price;
  final List<String> images;
  final String? description;
  final double latitude;
  final double longitude;
  // final String governorate;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    // required this.owner,
    required this.title,
    required this.price,
    required this.images,
    this.description,
    required this.latitude,
    required this.longitude,
    // required this.governorate,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a new ProductModel instance from a JSON map
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] as String,
      // owner: json['owner'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      // governorate: json['governorate'] as String,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Method to convert a ProductModel instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      // 'owner': owner,
      'title': title,
      'price': price,
      'images': images,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      // 'governorate': governorate,
      'category': category,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
