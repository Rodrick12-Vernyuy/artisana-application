import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF1B2B3A),
        foregroundColor: Colors.white,
      ),
      body: Consumer2<CartProvider, ProductProvider>(
        builder: (context, cartProvider, productProvider, child) {
          final cartItems = cartProvider.cartItems;
          final products = productProvider.products;

          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final productId = cartItems.keys.elementAt(index);
                    final product = products.firstWhere(
                      (p) => p.id == productId,
                    );
                    final quantity = cartItems[productId]!;

                    return ListTile(
                      leading: Image.network(
                        product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image),
                      ),
                      title: Text(product.name),
                      subtitle: Text('XAF ${product.price} x $quantity'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => cartProvider.decrement(productId),
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => cartProvider.increment(productId),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: XAF ${cartProvider.calculateTotal(products)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
