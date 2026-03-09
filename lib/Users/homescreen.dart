import 'package:farm/Models/product.dart';
import 'package:farm/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ChickenDashboard extends StatefulWidget {
  const ChickenDashboard({super.key});

  @override
  State<ChickenDashboard> createState() => _ChickenDashboardState();
}

class _ChickenDashboardState extends State<ChickenDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: const Text(
          "Natural Farming",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 18),

                const SizedBox(width: 4),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Singanallur,",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      "Coimbatore",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = 16.0;
          if (constraints.maxWidth > 600) {
            padding = 32.0;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const PromoBannerWidget(),
                  const SizedBox(height: 24),
                  const CategoriesSection(),
                  const SizedBox(height: 24),
                  const PopularItemsSection(),
                  const SizedBox(height: 24),
                  const TopDealsSection(),
                  const SizedBox(height: 16),
                  const FirstOrderPromo(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset('assets/promo.png', fit: BoxFit.cover, height: 180),
      ),
    );
  }
}

// 3. CATEGORIES SECTION
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "View All",
                style: TextStyle(color: Color(0xFFE92A2C)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              CategoryCard(
                title: "Chicken",
                image: 'assets/chicken.png',
                isPopular: true,
              ),
              CategoryCard(title: "Boneless", image: 'assets/boneless.png'),
              CategoryCard(title: "Leg Piece", image: 'assets/legpiece.png'),
              CategoryCard(title: "Skin Less", image: 'assets/skinless.png'),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final bool isPopular;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: isPopular ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class PopularItemsSection extends StatefulWidget {
  const PopularItemsSection({super.key});

  @override
  State<PopularItemsSection> createState() => _PopularItemsSectionState();
}

class _PopularItemsSectionState extends State<PopularItemsSection> {
  List<Product> products = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final data = await ProductService.fetchProducts();
      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Popular Items",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : products.isEmpty
              ? const Center(child: Text('No products available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    // Parse price to remove '.00' if it ends with it
                    String priceStr = product.price;
                    if (priceStr.endsWith('.00')) {
                      priceStr = priceStr.substring(0, priceStr.length - 3);
                    }

                    // For emulator, 127.0.0.1 might need to be replaced with 10.0.2.2 for image URL as well
                    // But keeping it as provided by the user format
                    String imageUrl = product.image.isNotEmpty
                        ? product.image
                        : 'https://via.placeholder.com/150';

                    return ItemCard(
                      image: imageUrl,
                      name: product.name,
                      price: priceStr,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String? originalPrice;

  const ItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Image.network(
                  image,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -1,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE92A2C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "+",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "₹$price",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (originalPrice != null) ...[
                      const SizedBox(width: 4),
                      Text(
                        "₹$originalPrice",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 5. TOP DEALS SECTION
class TopDealsSection extends StatelessWidget {
  const TopDealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's top deals",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              DealCard(
                image:
                    'https://media.istockphoto.com/id/1149793144/photo/raw-chicken-carcass-and-chicken-parts-and-products-top-view-on-a-cutting-board.jpg?s=612x612&w=0&k=20&c=qY6oMh5bB7O_YfG7YqH3zK3H2Gk5IuX1xRkP_G3q_20=',
                name: "Chicken Big piece - 500g",
                price: "255",
                originalPrice: "300",
                discount: "7% off",
                dealTag: "Today Great Deal",
                tagColor: Color(0xFF32C71C),
              ),
              DealCard(
                image:
                    'https://media.istockphoto.com/id/1149793144/photo/raw-chicken-carcass-and-chicken-parts-and-products-top-view-on-a-cutting-board.jpg?s=612x612&w=0&k=20&c=qY6oMh5bB7O_YfG7YqH3zK3H2Gk5IuX1xRkP_G3q_20=',
                name: "Chicken Breast & Leg piece - 500g",
                price: "255",
                originalPrice: "300",
                discount: "7% off",
                dealTag: "Today Top Deal",
                tagColor: Color(0xFFFF9E01),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DealCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String originalPrice;
  final String discount;
  final String dealTag;
  final Color tagColor;

  const DealCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.dealTag,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              image,
              height: 90,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "₹$price",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "₹$originalPrice",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          discount,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF32C71C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.favorite_border,
                      color: Color(0xFFE92A2C),
                      size: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    dealTag,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 6. BOTTOM PROMO BANNER (YELLOW)
class FirstOrderPromo extends StatelessWidget {
  const FirstOrderPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC33),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "₹50 OFF",
                  style: TextStyle(
                    color: Color(0xFFE92A2C),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "ON FIRST CHICKEN ORDER",
                  style: TextStyle(
                    color: Color(0xFFE92A2C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9E01),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("ORDER NOW", style: TextStyle(color: Colors.white)),
                      Icon(Icons.arrow_right, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://media.istockphoto.com/id/1149793144/photo/raw-chicken-carcass-and-chicken-parts-and-products-top-view-on-a-cutting-board.jpg?s=612x612&w=0&k=20&c=qY6oMh5bB7O_YfG7YqH3zK3H2Gk5IuX1xRkP_G3q_20=',
                  height: 100,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF32C71C),
                      shape: BoxShape.circle,
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "LIMITED",
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                        Text(
                          "TIME",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "OFFER",
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
