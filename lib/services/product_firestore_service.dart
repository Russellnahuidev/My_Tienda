import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_tienda/models/product.dart';

class ProductFirestoreService {
  static final FirebaseFirestore _firestoreServices =
      FirebaseFirestore.instance;
  static final _productsCollection = 'products';

  //Get all products
  static Future<List<Product>> getAllProducts() async {
    try {
      final querySnapshot = await _firestoreServices
          .collection(_productsCollection)
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  //Get products by category
  static Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final querySnapshot = await _firestoreServices
          .collection(_productsCollection)
          .where('isActive', isEqualTo: true)
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }
  }

  //Get featured products
  static Future<List<Product>> getFeaturedProducts() async {
    try {
      final querySnapshot = await _firestoreServices
          .collection(_productsCollection)
          .where('isActive', isEqualTo: true)
          .where('isFeatured', isEqualTo: true)
          .limit(10)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching featured products: $e');
      return [];
    }
  }

  //Get sale products
  static Future<List<Product>> getSaleProducts() async {
    try {
      final querySnapshot = await _firestoreServices
          .collection(_productsCollection)
          .where('isActive', isEqualTo: true)
          .where('isOnSale', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching sale products: $e');
      return [];
    }
  }

  //Search products
  static Future<List<Product>> searchProducts(String seachTerm) async {
    try {
      final querySnapshot = await _firestoreServices
          .collection(_productsCollection)
          .where('isActive', isEqualTo: true)
          .where('searchKeywords', arrayContains: seachTerm.toLowerCase())
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  //Get products by ID
  static Future<Product?> getProductById(String productId) async {
    try {
      final doc = await _firestoreServices
          .collection(_productsCollection)
          .doc(productId)
          .get();

      if (doc.exists) {
        return Product.fromFirestore(doc.data()!, doc.id);
      }

      return null;
    } catch (e) {
      print('Error fetching products by ID: $e');
      return null;
    }
  }

  // Get products stream for ral-time updates
  static Stream<List<Product>> getProductsStream() {
    return _firestoreServices
        .collection(_productsCollection)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snapshots) {
          return snapshots.docs.map((doc) {
            return Product.fromFirestore(doc.data(), doc.id);
          }).toList();
        });
  }

  //Get products by price range
  static Future<List<Product>> getProductsbyPriceRange({
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      final querySnapshot = await _firestoreServices
          .collection(_productsCollection)
          .where('isActive', isEqualTo: true)
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice)
          .orderBy('price')
          .get();

      return querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching products by price range: $e');
      return [];
    }
  }

  //Get all categories
  static Future<List<String>> getallCategories() async {
    try {
      final querySnapshot = await _firestoreServices
          .collection(_productsCollection)
          .where('isActive', isEqualTo: true)
          .get();

      final categories = <String>{};
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data['category'] != null) {
          categories.add(data['category'] as String);
        }
      }
      return categories.toList()..sort();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
