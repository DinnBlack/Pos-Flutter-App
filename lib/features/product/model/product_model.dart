class ProductModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imageUrl;
  final bool isActive;

  //<editor-fold desc="Data Methods">
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    this.isActive = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ProductModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              price == other.price &&
              description == other.description &&
              categoryId == other.categoryId &&
              createdAt == other.createdAt &&
              updatedAt == other.updatedAt &&
              imageUrl == other.imageUrl &&
              isActive == other.isActive);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      description.hashCode ^
      categoryId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      imageUrl.hashCode ^
      isActive.hashCode;

  @override
  String toString() {
    return 'ProductModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' price: $price,' +
        ' description: $description,' +
        ' categoryId: $categoryId,' +
        ' createdAt: $createdAt,' +
        ' updatedAt: $updatedAt,' +
        ' imageUrl: $imageUrl,' +
        ' isActive: $isActive,' +
        '}';
  }

  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
    bool? isActive,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'].toDouble(),
      description: map['description'] as String,
      categoryId: map['categoryId'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      imageUrl: map['imageUrl'] as String,
      isActive: map['isActive'] ?? true, // Nếu không có thì mặc định true
    );
  }

//</editor-fold>
}
