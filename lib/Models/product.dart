import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String image;
  final String createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String imageUrl = json['image'] ?? '';
    // Fix image URL for Android Emulator if it contains 127.0.0.1
    if (imageUrl.contains('127.0.0.1')) {
      imageUrl = imageUrl.replaceAll('127.0.0.1', '10.0.2.2');
    }

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: imageUrl,
      createdAt: json['created_at'] ?? '',
    );
  }
}

class ProductService {
  // Use 10.0.2.2 to access localhost from Android Emulator
  static const String apiUrl = 'http://10.0.2.2:8000/api/products/';

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('API Response: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Error fetching products: $e');
    }
  }
}
