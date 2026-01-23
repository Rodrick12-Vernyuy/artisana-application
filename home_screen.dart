import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cameroon Crafts'),
        backgroundColor: const Color(0xFF1B2B3A),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Woodwork'),
            Tab(text: 'Textile'),
            Tab(text: 'Jewelry'),
          ],
          indicatorColor: const Color(0xFFD27C4B),
          labelColor: const Color(0xFFD27C4B),
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ProductSection(category: 'Woodwork'),
          _ProductSection(category: 'Textile'),
          _ProductSection(category: 'Jewelry'),
        ],
      ),
    );
  }
}

class _ProductSection extends StatelessWidget {
  final String category;

  const _ProductSection({required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, CartProvider>(
      builder: (context, productProvider, cartProvider, child) {
        final products = productProvider.products
            .where((product) => product.category == category)
            .toList();

        if (products.isEmpty) {
          return const Center(
            child: Text('No products available in this category'),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final quantity = cartProvider.getQuantity(product.id);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('XAF ${product.price}'),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  cartProvider.addToCart(product.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product.name} added to cart!',
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                color: const Color(0xFFD27C4B),
                              ),
                              if (quantity > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD27C4B),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
