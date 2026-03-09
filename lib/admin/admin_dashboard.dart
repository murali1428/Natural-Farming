import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green.shade900,
        primaryColor: Colors.green.shade900,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade900,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AdminDashboard(),
    );
  }
}

class Product {
  String name;
  double price;
  double offer;
  double quantity;
  double minQty;
  bool enabled;
  String image;

  Product({
    required this.name,
    required this.price,
    required this.offer,
    required this.quantity,
    required this.minQty,
    required this.enabled,
    required this.image,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      price: double.parse(json['price'].toString()),
      offer: double.parse(json['offer'].toString()),
      quantity: double.parse(json['quantity'].toString()),
      minQty: double.parse(json['minQty'].toString()),
      enabled: json['enabled'] == 1 || json['enabled'] == true,
      image: json['image'] ?? '',
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<Product> products = [];

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final offerController = TextEditingController();
  final qtyController = TextEditingController();
  final minQtyController = TextEditingController();
  final imageController = TextEditingController();

  void addProduct() {
    setState(() {
      products.add(Product(
        name: nameController.text,
        price: double.parse(priceController.text),
        offer: double.parse(offerController.text),
        quantity: double.parse(qtyController.text),
        minQty: double.parse(minQtyController.text),
        enabled: true,
        image: imageController.text,
      ));
    });

    nameController.clear();
    priceController.clear();
    offerController.clear();
    qtyController.clear();
    minQtyController.clear();
    imageController.clear();
    Navigator.pop(context);
  }

  void showAddProductDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.green.shade800,
        title: const Text("Add New Product"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              buildField(nameController, "Product Name"),
              buildField(priceController, "Price"),
              buildField(offerController, "Offer %"),
              buildField(qtyController, "Quantity (kg)"),
              buildField(minQtyController, "Minimum Quantity"),
              buildField(imageController, "Image URL"),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade900),
            onPressed: addProduct,
            child: const Text("Add Product"),
          )
        ],
      ),
    );
  }

  Widget buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.green.shade700,
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void stockIn(Product product) {
    setState(() {
      product.quantity += 1;
    });
  }

  void stockOut(Product product) {
    setState(() {
      if (product.quantity > 0) product.quantity -= 1;
    });
  }

  void deleteProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📊 Full Admin Dashboard"),
        backgroundColor: Colors.green.shade900,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: showAddProductDialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            bool lowStock = product.quantity <= product.minQty;

            return Card(
              color: Colors.green.shade800,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(product.image),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("Price: ₹${product.price}"),
                              Text("Offer: ${product.offer}%"),
                              Text(
                                  "Stock: ${product.quantity} kg (${lowStock ? "Low Stock" : "In Stock"})",
                                  style: TextStyle(
                                      color: lowStock
                                          ? Colors.red
                                          : Colors.greenAccent)),
                            ],
                          ),
                        ),
                        Switch(
                          value: product.enabled,
                          onChanged: (val) {
                            setState(() {
                              product.enabled = val;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: () => stockIn(product),
                          child: const Text("📦 Stock In"),
                        ),
                        ElevatedButton(
                          onPressed: () => stockOut(product),
                          child: const Text("📦 Stock Out"),
                        ),
                        ElevatedButton(
                          onPressed: () => deleteProduct(product),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: const Text("Delete"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
