import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataSeeder {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Seed all data
  static Future<void> seedAllData() async {
    await seedProducts();
    await seedCategories();
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
        'images': [
          'https://media.istockphoto.com/id/1249496770/photo/running-shoes.jpg?s=1024x1024&w=is&k=20&c=pvn3pnD5rbSz7LT1zbCkgMd6PyEXeo7QdzjDCRNHunI=',
        ],
        'primaryImage':
            'https://media.istockphoto.com/id/1249496770/photo/running-shoes.jpg?s=1024x1024&w=is&k=20&c=pvn3pnD5rbSz7LT1zbCkgMd6PyEXeo7QdzjDCRNHunI=',
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
        'images': [
          'https://sm.pcmag.com/t/pcmag_me/review/a/apple-macb/apple-macbook-pro-14-inch-2024-m4_mjb1.1920.jpg',
        ],
        'primaryImage':
            'https://sm.pcmag.com/t/pcmag_me/review/a/apple-macb/apple-macbook-pro-14-inch-2024-m4_mjb1.1920.jpg',
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
        'images': [
          'https://www.manelsanchez.com/uploads/media/images/800x800/air-jordan-1-retro-high-rare-air-400-soar-blue-black-white-15.jpg',
        ],
        'primaryImage':
            'https://www.manelsanchez.com/uploads/media/images/800x800/air-jordan-1-retro-high-rare-air-400-soar-blue-black-white-15.jpg',
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
        'images': [
          'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-17-pro-max-1.jpg',
        ],
        'primaryImage':
            'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-17-pro-max-1.jpg',
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
        'images': [
          'https://unaluka.com/cdn/shop/files/81UQDoHG7pL._AC_SL1500_1200x1200.jpg?v=1745421065',
        ],
        'primaryImage':
            'https://unaluka.com/cdn/shop/files/81UQDoHG7pL._AC_SL1500_1200x1200.jpg?v=1745421065',
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
        'images': [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOpfi6vjE1c9avHLFsIhXn3CSmrEE1DQxTkw&s',
        ],
        'primaryImage':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOpfi6vjE1c9avHLFsIhXn3CSmrEE1DQxTkw&s',
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
        'images': [
          'https://i5.walmartimages.com/seo/VILINICE-Upgraded-Noise-Canceling-Headphones-Wireless-Bluetooth-Headphones-with-Microphone-ANC-Over-ear-Headphones-for-Travel-Sport_5cec40fc-4e49-445f-bf62-e29a0d5a1f39.e1737e94ee5402264512a2055e5cf5b8.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF',
        ],
        'primaryImage':
            'https://i5.walmartimages.com/seo/VILINICE-Upgraded-Noise-Canceling-Headphones-Wireless-Bluetooth-Headphones-with-Microphone-ANC-Over-ear-Headphones-for-Travel-Sport_5cec40fc-4e49-445f-bf62-e29a0d5a1f39.e1737e94ee5402264512a2055e5cf5b8.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF',
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
        'images': [
          'https://5.imimg.com/data5/ANDROID/Default/2023/5/304570839/AQ/JK/UW/15957788/product-jpeg-500x500.jpg',
        ],
        'primaryImage':
            'https://5.imimg.com/data5/ANDROID/Default/2023/5/304570839/AQ/JK/UW/15957788/product-jpeg-500x500.jpg',
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
        'images': [
          'https://sunnyhealthfitness.com/cdn/shop/files/7-sunny-health-fitness-premium-extra-thick-exercise-yoga-mat-blue-sf-em03-pk_750x.jpg?v=1740525793',
        ],
        'primaryImage':
            'https://sunnyhealthfitness.com/cdn/shop/files/7-sunny-health-fitness-premium-extra-thick-exercise-yoga-mat-blue-sf-em03-pk_750x.jpg?v=1740525793',
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

  //Add sample categories to Firestore
  static Future<void> seedCategories() async {
    final sampleCategories = [
      {
        'name': 'Electronics',
        'displayName': 'Electronics',
        'description': 'Electronics devices and gadgets',
        'isActive': true,
        'sortOrder': 1,
        'subcategories': [
          'Smartphones',
          'Laptops',
          'Tablets',
          'Wearables',
          'Audio',
        ],
        'metadata': {'color': '#2196F3', 'icon': 'Electronics'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Footwear',
        'displayName': 'Footwear',
        'description': 'Shoe and footwear for all occasions',
        'isActive': true,
        'sortOrder': 2,
        'subcategories': [
          'Running Shoes',
          'Basketball Shoes',
          'Lifestyle Shoes',
          'Bots',
          'sandals',
        ],
        'metadata': {'color': '#FF9800', 'icon': 'footwear'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Clothing',
        'displayName': 'Clothing',
        'description': 'Fashion and apparel for men and women',
        'isActive': true,
        'sortOrder': 3,
        'subcategories': [
          'T-Shirts',
          'Jeans',
          'Dresses',
          'Jaket',
          'Activewear',
        ],
        'metadata': {'color': '#E91E63', 'icon': 'clothing'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Accessories',
        'displayName': 'Accessories',
        'description': 'Fashion accessories and jewerly',
        'isActive': true,
        'sortOrder': 4,
        'subcategories': ['Watches', 'Jewerly', 'Bags', 'Sunglases', 'Belts'],
        'metadata': {'color': '#9C27B0', 'icon': 'accessries'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Home',
        'displayName': 'Home & Living',
        'description': 'Home decor and living essentials',
        'isActive': true,
        'sortOrder': 5,
        'subcategories': ['Furniture', 'Decor', 'Kitche', 'Bessing', 'Storage'],
        'metadata': {'color': '#4CAF50', 'icon': 'home'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Sports',
        'displayName': 'Sports & Fitnes',
        'description': 'Sports equipment and fitness gear',
        'isActive': true,
        'sortOrder': 6,
        'subcategories': [
          'Gym Equipment',
          'Outdoor Sports',
          'Team Sports',
          'Fitness Apparel',
        ],
        'metadata': {'color': '#FF5722', 'icon': 'sports'},
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];
    try {
      //Check if categories already exist
      final existingCategories = await _firestore
          .collection('categories')
          .limit(1)
          .get();

      if (existingCategories.docs.isEmpty) {
        //Add sample categories only if collection is empty
        for (var category in sampleCategories) {
          await _firestore.collection('categories').add(category);
        }
        print('Sample categories added to firestore succefully!');
      } else {
        print('Categories already exist in Firestore. Skipping seed data.');
      }
    } catch (e) {
      print('Error seeding categories: $e');
    }
  }
}
