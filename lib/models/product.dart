import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final String? subCategory;
  final double price;
  final double? oldPrice;
  final String currency;
  final String description;
  final List<String> images;
  final String primaryImage;
  final String? brand;
  final String? sku;
  final int stock;
  final bool isActive;
  final bool isFeatured;
  final bool isOnSale;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final Map<String, dynamic> specifications;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    this.subCategory,
    required this.price,
    this.oldPrice,
    this.currency = 'USD',
    required this.description,
    required this.images,
    required this.primaryImage,
    this.brand,
    this.sku,
    this.stock = 0,
    this.isActive = true,
    this.isFeatured = false,
    this.isOnSale = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.tags = const [],
    this.specifications = const {},
    this.createdAt,
    this.updatedAt,
  });

  //Created product from Firestore document
  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      subCategory: data['subCategory'],
      price: (data['price'] ?? 0.0).toDouble(),
      oldPrice: data['oldPrice'] != null
          ? (data['oldPrice'] as num).toDouble()
          : null,
      currency: data['currency'] ?? 'USD',
      description: data['description'] ?? '',
      images: data['images'] is List ? List<String>.from(data['images']) : [],
      primaryImage:
          data['primaryImage'] ??
          (data['images'] != null && (data['images'] as List).isNotEmpty
              ? data['images'][0]
              : ''),
      brand: data['brand'],
      sku: data['sku'],
      stock: data['stock'] ?? 0,
      isActive: data['isActive'] ?? true,
      isFeatured: data['isFeatured'] ?? false,
      isOnSale: data['isOnSale'] ?? false,
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviewCount: data['reviewCount'] ?? 0,
      tags: data['tags'] is List ? List<String>.from(data['tags']) : [],
      specifications: data['specifications'] is Map
          ? Map<String, dynamic>.from(data['specifications'])
          : {},
      createdAt: data['createdAt'] is Timestamp
          ? (data['createdAt'] as Timestamp).toDate()
          : null,

      updatedAt: data['updatedAt'] is Timestamp
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  //Covert Product to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'subCategory': subCategory,
      'price': price,
      'oldPrice': oldPrice,
      'currency': currency,
      'images': images,
      'primaryImage': primaryImage,
      'brand': brand,
      'sku': sku,
      'stock': stock,
      'isActive': isActive,
      'isFeatured': isFeatured,
      'isOnSale': isOnSale,
      'rating': rating,
      'reviewCount': reviewCount,
      'tags': tags,
      'specifications': specifications,
      'description': description,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  //Backward compatibility getter form imageUrl
  String get imageUrl => primaryImage;

  //Check if product has discount
  bool get hasDiscount => oldPrice != null && oldPrice! > price;

  //Calculate discount percentage
  int get discountPercentage {
    if (!hasDiscount) return 0;
    return (((oldPrice! - price) / oldPrice!) * 100).round();
  }

  //Check if product is in stock
  bool get isInStock => stock > 0;

  //Get formatted price
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}

//Legacy dummy data for backward compatibility
final List<Product> products = [
  // Product(
  //   id: 'dummy-1',
  //   name: 'Shoes',
  //   category: 'Footwear',
  //   price: 69.00,
  //   description: 'This is a description of the product 1',
  //   images: ['assets/images/shoe.jpg'],
  //   primaryImage: 'assets/images/shoe.jpg',
  // ),
  // Product(
  //   id: 'dummy-2',
  //   name: 'Laptop',
  //   category: 'Electronics',
  //   price: 88.00,
  //   description: 'This is a description of the product 2',
  //   images: ['assets/images/laptop.jpg'],
  //   primaryImage: 'assets/images/laptop.jpg',
  // ),
  // Product(
  //   id: 'dummy-3',
  //   name: 'Jordan Shoe',
  //   category: 'Footwear',
  //   price: 129.00,
  //   description: 'This is a description of the product 3',
  //   images: ['assets/images/shoe2.jpg'],
  //   primaryImage: 'assets/images/shoe2.jpg',
  // ),
  // Product(
  //   id: 'dummy-4',
  //   name: 'Puma Shoe',
  //   category: 'Footwear',
  //   price: 99.00,
  //   description: 'This is a description of the product 4',
  //   images: ['assets/images/shoes2.jpg'],
  //   primaryImage: 'assets/images/shoes2.jpg',
  // ),
];
