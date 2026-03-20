import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataSeeder {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Seed all data
  static Future<void> seeAllData() async {
    await seedProducts();
  }

  //Add sample products to Firestore
  static Future<void> seedProducts() async {
    final sampleProducts = [
      {
        'name': 'Nike Air Max 270',
        'description':
            'Confortable running shoes whit cushioning and modern desing. Perfect for daily wear and light exercise.',
        'category': 'Footwear',
        'subCategory': 'Running Shoes',
        'price': 129.99,
        'oldPrice': 179.99,
        'currency': 'USD',
        'images': ['assets/images/shoe.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Nike',
        'sku': 'NIKE-AM270-001',
        'stock': 25,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.5,
        'reviewCount': 89,
        'tags': ['popular', 'trending', 'confortable'],
        'specifications': {
          'color': 'White/Blue',
          'material': 'Synthetic',
          'weight': '0.8kg',
          'sizes': ['7', '8', '9', '10', '11'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'nike',
          'air',
          'max',
          '270',
          'shoes',
          'running',
          'footwear',
          'white',
          'blue',
        ],
      },
      {
        'name': 'MacBook Pro 13',
        'description':
            'High performance laptop with M2 chip, perfect for professionals and creative work. Features stunning Retina display.',
        'category': 'Electronics',
        'subCategory': 'Laptop',
        'price': 1299.99,
        'oldPrice': 1499.99,
        'currency': 'USD',
        'images': ['assets/images/laptop.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Apple',
        'sku': 'APLE-MBP13-001',
        'stock': 15,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.8,
        'reviewCount': 159,
        'tags': ['premium', 'professional', 'powerful'],
        'specifications': {
          'screen': '13-inch Retina',
          'processor': 'Apple M2',
          'memory': '8GB',
          'storage': '259GB SSD',
          'color': 'Space Gray',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'macbook',
          'pro',
          'laptop',
          'apple',
          'electronics',
          'm2',
          'retina',
        ],
      },
      {
        'name': 'Air Jordan 1 Retro',
        'description':
            'Classic basketball shoe with iconic design. A timeless sneaker that combines style and performance.',
        'category': 'Footwear',
        'subCategory': 'Basketball Shoes',
        'price': 170.00,
        'currency': 'USD',
        'images': ['assets/images/shoe2.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Jordan',
        'sku': 'JORDAN-AJ1-001',
        'stock': 30,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.7,
        'reviewCount': 203,
        'tags': ['classic', 'basketball', 'iconic'],
        'specifications': {
          'color': 'Black/red',
          'material': 'Leather',
          'weight': '0.9kg',
          'sizes': ['7', '8', '9', '10', '11', '12'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'jordan',
          'air',
          'retro',
          'basketball',
          'shoes',
          'black',
          'red',
        ],
      },
      {
        'name': 'iPhone 15 Pro',
        'description':
            'latest iPhone with titanium design, advanced camera system, and A17 Pro chip for ultimate performance.',
        'category': 'Electronics',
        'subCategory': 'Smartphones',
        'price': 999.99,
        'currency': 'USD',
        'images': ['assets/images/phone.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Apple',
        'sku': 'APPLE-IP15P-001',
        'stock': 20,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.9,
        'reviewCount': 324,
        'tags': ['premium', 'latest', 'flagship'],
        'specifications': {
          'screen': '6.1-inch Super Retina XDR',
          'processor': 'A17 Pro',
          'storage': '128GB',
          'color': 'Titanium Blue',
          'camera': '48MP Main',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'iphone',
          '15',
          'apple',
          'smartphone',
          'titanium',
          'camera',
        ],
      },
      {
        'name': 'Samsung Galaxy Watch',
        'description':
            'Smart fitness watch with health ,onitoring, GPS, and long battery life. perfect companion for active lifestyle.',
        'category': 'Electronics',
        'subCategory': 'Wearables',
        'price': 249.99,
        'oldPrice': 299.99,
        'currency': 'USD',
        'images': ['assets/images/watch.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'samsung',
        'sku': 'SAMSUNG-GW-001',
        'stock': 35,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.4,
        'reviewCount': 142,
        'tags': ['fitness', 'smart', 'health'],
        'specifications': {
          'display': '1.4-inch AMOLED',
          'battery': '40 hours',
          'waterproof': 'IP68',
          'color': 'black',
          'connectivity': 'Bluetooth 5.0',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'samsung',
          'galaxy',
          'watch',
          'smart',
          'fitnes',
          'health',
          'wearable',
        ],
      },
      {
        'name': 'Nike Dri-FIT T-Shirt',
        'description':
            'Confortable athletic t-shirt with moisture-wicking technology. Perfect for workouts and casual wear.',
        'category': 'Clothing',
        'subCategory': 'T-Shirts',
        'price': 29.99,
        'oldPrice': 39.99,
        'currency': 'USD',
        'images': ['assets/images/tshirt.jpg'],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzSOrIHIncvVwcn86Yj1lG2no3rymRPhF1AQ&s',
        'brand': 'Nike',
        'sku': 'NIKE-TSHIRT-001',
        'stock': 50,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.2,
        'reviewCount': 76,
        'tags': ['athletic', 'confortable', 'moisture-wicking'],
        'specifications': {
          'color': 'Black',
          'material': 'Polyester',
          'fit': 'Regular',
          'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'nike',
          'dri-fit',
          'tshirt',
          'shirt',
          'clothing',
          'athetic',
          'black',
        ],
      },
      {
        'name': 'Wireless Blueooth Headphones',
        'description':
            'Premium wireless headphones with noise cancellation and long battery life. Perfect for music and calls.',
        'category': 'Electronics',
        'subCategory': 'Audio',
        'price': 199.99,
        'oldPrice': 249.99,
        'currency': 'USD',
        'images': ['assets/images/headphones.jpg'],
        'primaryImage': 'assets/images/headphones.jpg',
        'brand': 'Sony',
        'sku': 'SONY-WH-001',
        'stock': 30,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': true,
        'rating': 4.6,
        'reviewCount': 234,
        'tags': ['wireless', 'noise-cancelling', 'premium'],
        'specifications': {
          'color': 'Black',
          'processor': 'A17 Pro',
          'battery': '30 hours',
          'connectivity': 'Bluetooth  5.0',
          'weight': '0.3kg',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'sony',
          'headphones',
          'wireless',
          'bluetooth',
          'audio',
          'electronics',
          'noise',
        ],
      },
      {
        'name': 'Designer Leather Handbag',
        'description':
            'Elegant leather handbag with premium craftsmanship. Perfect for professional and casual occasions.',
        'category': 'Accessories',
        'subCategory': 'Bags',
        'price': 149.99,
        'currency': 'USD',
        'images': ['assets/images/handbag.jpg'],
        'primaryImage': 'assets/images/handbag.jpg',
        'brand': 'Coach',
        'sku': 'COACH-BAG-001',
        'stock': 15,
        'isActive': true,
        'isFeatured': true,
        'isOnSale': false,
        'rating': 4.7,
        'reviewCount': 89,
        'tags': ['lyxury', 'leather', 'designer'],
        'specifications': {
          'color': 'Brow',
          'material': 'Genuine Leather',
          'dimensions': '30x25x15 cm',
          'weight': '0.8kg',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'coach',
          'handbag',
          'bag',
          'leather',
          'accessories',
          'designer',
          'brow',
        ],
      },
      {
        'name': 'Yoga Mat Premium',
        'description':
            'High-quality yoga mat with excellent grip and cushioning. Perfect for yoga, pilates, and fitness exercises.',
        'category': 'Sport',
        'subCategory': 'Fitness Equioment',
        'price': 39.99,
        'oldPrice': 59.99,
        'currency': 'USD',
        'images': ['assets/images/yoga_mat.jpg'],
        'primaryImage': 'assets/images/yoga_mat.jpg',
        'brand': 'Manduka',
        'sku': 'MANDUKA-MAT-001',
        'stock': 25,
        'isActive': true,
        'isFeatured': false,
        'isOnSale': true,
        'rating': 4.4,
        'reviewCount': 156,
        'tags': ['yoga', 'fitness', 'exercise'],
        'specifications': {
          'color': 'Purple',
          'material': 'Natural Rubber',
          'dimensions': '183x61x0.6 cm',
          'weight': '2.5kg',
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'searchKeywords': [
          'yoga',
          'mat',
          'fitness',
          'exercise',
          'sports',
          'manduka',
          'purple',
        ],
      },
    ];

    try {
      //Check if products already exist
      final existingProducts = await _firestore
          .collection('products')
          .limit(1)
          .get();

      if (existingProducts.docs.isEmpty) {
        //Add sample products only if collection is empty
        for (var product in sampleProducts) {
          await _firestore.collection('products').add(product);
        }
        print('Sample products added to Firestore successfully');
      } else {
        print('Products alreadly exist in Firestore. Skipping seed data.');
      }
    } catch (e) {
      print('Error seeding products:$e');
    }
  }
}
