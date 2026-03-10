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
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: json['price'].toString(),
      image: json['image'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class ProductService {
  static const String apiUrl =
      'https://admin-panel-using-rest-api.onrender.com/api/products/';

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      // Print the response for debugging
      print('--- API DEBUG START ---');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('--- API DEBUG END ---');

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
      throw Exception('Error: $e');
    }
  }
}
