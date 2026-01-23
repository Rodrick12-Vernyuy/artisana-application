import 'package:flutter/material.dart';

void main() {
  runApp(const CameroonCraftsApp());
}

// --- Theme & Constants ---
const Color kPrimaryBlue = Color(0xFF1B2B3A);
const Color kAccentOrange = Color(0xFFD27C4B);
const Color kBackgroundBeige = Color(0xFFFDF7F0);
const Color kCardColor = Color(0xFFF5EFE7);

// --- 1. State Management (Products, Profile, Cart & Ratings) ---

class UserData {
  String name;
  String location;
  String imageUrl;
  UserData({
    required this.name,
    required this.location,
    required this.imageUrl,
  });
}

class UserManager {
  static final ValueNotifier<UserData> currentUser = ValueNotifier(
    UserData(
      name: "Jean-Pierre Douala",
      location: "Yaoundé, Cameroon",
      imageUrl:
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200",
    ),
  );

  static void updateProfile(String name, String loc, String img) {
    currentUser.value = UserData(name: name, location: loc, imageUrl: img);
  }
}

class ProductManager {
  static final ValueNotifier<List<Product>> products = ValueNotifier([
    Product(
      id: 0,
      name: "Bamileke Stool",
      price: "25,000",
      category: "Woodwork",
      imageUrl:
          "https://images.unsplash.com/photo-1581553680321-4fffae59fccd?q=80&w=400",
      description: "Hand-carved traditional stool from the West Region.",
    ),
    Product(
      id: 1,
      name: "Carved Mask",
      price: "15,000",
      category: "Woodwork",
      imageUrl:
          "https://images.unsplash.com/photo-1503174971373-b1f69850bbd6?q=80&w=400",
      description: "Authentic mahogany wood mask.",
    ),
    Product(
      id: 2,
      name: "Toghu Royal Attire",
      price: "45,000",
      category: "Textile",
      imageUrl:
          "https://images.unsplash.com/photo-1523381210434-271e8be1f52b?q=80&w=400",
      description: "Premium hand-stitched Toghu fabric.",
    ),
    Product(
      id: 3,
      name: "Ndop Table Runner",
      price: "12,000",
      category: "Textile",
      imageUrl:
          "https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?q=80&w=400",
      description: "Traditional blue and white indigo dyed textile.",
    ),
    Product(
      id: 4,
      name: "Maasai-style Beads",
      price: "5,000",
      category: "Jewelry",
      imageUrl:
          "https://images.unsplash.com/photo-1611085583191-a3b13b24424a?q=80&w=400",
      description: "Vibrant beadwork necklace.",
    ),
    Product(
      id: 5,
      name: "Brass Cuff",
      price: "8,500",
      category: "Jewelry",
      imageUrl:
          "https://images.unsplash.com/photo-1535633302703-9420414421cd?q=80&w=400",
      description: "Hand-hammered brass bracelet.",
    ),
  ]);

  static void addProduct(Product p) {
    products.value = List.from(products.value)..add(p);
  }

  static void deleteProduct(int id) {
    products.value = List.from(products.value)..removeWhere((p) => p.id == id);
  }
}

// NEW: Rating Manager to handle product ratings
class RatingManager {
  static final ValueNotifier<Map<int, double>> ratings = ValueNotifier({
    0: 4.5,
    1: 4.0,
    2: 5.0,
  });

  static void updateRating(int productId, double rating) {
    var newMap = Map<int, double>.from(ratings.value);
    newMap[productId] = rating;
    ratings.value = newMap;
  }

  static double getRating(int productId) => ratings.value[productId] ?? 0.0;
}

class CartManager {
  static final ValueNotifier<Map<int, int>> cartItems = ValueNotifier({0: 1});

  static void addToCart(int index) {
    var newMap = Map<int, int>.from(cartItems.value);
    newMap[index] = (newMap[index] ?? 0) + 1;
    cartItems.value = newMap;
  }

  static void increment(int index) {
    var newMap = Map<int, int>.from(cartItems.value);
    newMap[index] = (newMap[index] ?? 0) + 1;
    cartItems.value = newMap;
  }

  static void decrement(int index) {
    var newMap = Map<int, int>.from(cartItems.value);
    if (newMap[index]! > 1) {
      newMap[index] = newMap[index]! - 1;
      cartItems.value = newMap;
    } else {
      newMap.remove(index);
      cartItems.value = newMap;
    }
  }

  static String calculateTotal() {
    double total = 0;
    cartItems.value.forEach((index, qty) {
      try {
        final product = ProductManager.products.value.firstWhere(
          (p) => p.id == index,
        );
        double price = double.parse(product.price.replaceAll(',', ''));
        total += price * qty;
      } catch (e) {
        /* Product might have been deleted */
      }
    });
    return total
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

// --- Data Model ---
class Product {
  final int id;
  final String name;
  final String price;
  final String category;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
  });
}

class CameroonCraftsApp extends StatelessWidget {
  const CameroonCraftsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundBeige,
        primaryColor: kPrimaryBlue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryBlue,
          secondary: kAccentOrange,
        ),
        fontFamily: 'Serif',
      ),
      home: const SplashScreen(),
    );
  }
}

// --- 1. SplashScreen ---
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: kPrimaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, size: 100, color: kAccentOrange),
            const SizedBox(height: 20),
            const Text(
              "CameroonCrafts\nConnect",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Discover Authentic Talents",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. LoginScreen ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isArtisan = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Invalid Email Format";
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isArtisan ? const ArtisanDashboard() : const MainContainer(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please check your credentials"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              const Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryBlue,
                ),
              ),
              const Text(
                "Sign in to continue",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _emailController,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email Address",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                validator: (v) => v!.length < 6 ? "Password too short" : null,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Customer"),
                  Switch(
                    value: isArtisan,
                    activeColor: kAccentOrange,
                    onChanged: (v) => setState(() => isArtisan = v),
                  ),
                  const Text("Artisan"),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryBlue,
                  padding: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _handleLogin,
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 3. MainContainer (Customer Side) ---
class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _index = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: kAccentOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "Shop",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// --- 4. Search Screen ---
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (v) => setState(() => query = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: "Search for crafts...",
                prefixIcon: const Icon(Icons.search, color: kAccentOrange),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: ProductManager.products,
              builder: (context, List<Product> all, _) {
                final results = all
                    .where(
                      (p) =>
                          p.name.toLowerCase().contains(query) ||
                          p.category.toLowerCase().contains(query),
                    )
                    .toList();

                if (results.isEmpty)
                  return const Center(child: Text("No crafts found."));

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: results.length,
                  itemBuilder: (context, i) =>
                      ProductItemCard(product: results[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- 5. HomeScreen ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "Woodwork";

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ProductManager.products,
      builder: (context, List<Product> allProducts, _) {
        List<Product> filteredProducts = allProducts
            .where((p) => p.category == selectedCategory)
            .toList();

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: UserManager.currentUser,
                      builder: (context, user, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, ${user.name.split(' ')[0]}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryBlue,
                            ),
                          ),
                          const Text(
                            "Handmade with love",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: kAccentOrange.withOpacity(0.1),
                      child: const Icon(
                        Icons.notifications_none,
                        color: kAccentOrange,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: ["Woodwork", "Textile", "Jewelry"].map((cat) {
                    bool isActive = selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isActive,
                        selectedColor: kAccentOrange,
                        labelStyle: TextStyle(
                          color: isActive ? Colors.white : Colors.black,
                        ),
                        onSelected: (val) =>
                            setState(() => selectedCategory = cat),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, i) =>
                      ProductItemCard(product: filteredProducts[i]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductItemCard extends StatelessWidget {
  final Product product;
  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailScreen(product: product)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (c, e, s) => const Icon(Icons.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "XAF ${product.price}",
                        style: const TextStyle(
                          color: kAccentOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: RatingManager.ratings,
                        builder: (context, ratings, _) {
                          double rate = ratings[product.id] ?? 0.0;
                          return Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              Text(
                                " $rate",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
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
  }
}

// --- 6. Artisan Dashboard ---
class ArtisanDashboard extends StatefulWidget {
  const ArtisanDashboard({super.key});

  @override
  State<ArtisanDashboard> createState() => _ArtisanDashboardState();
}

class _ArtisanDashboardState extends State<ArtisanDashboard> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imgController = TextEditingController();
  String _cat = "Woodwork";

  void _showAddDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Post New Craft",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: "Price (e.g. 10,000)",
              ),
            ),
            TextField(
              controller: _imgController,
              decoration: const InputDecoration(labelText: "Image URL"),
            ),
            DropdownButton<String>(
              value: _cat,
              isExpanded: true,
              onChanged: (v) => setState(() => _cat = v!),
              items: [
                "Woodwork",
                "Textile",
                "Jewelry",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kAccentOrange,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                ProductManager.addProduct(
                  Product(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: _nameController.text,
                    price: _priceController.text,
                    category: _cat,
                    imageUrl: _imgController.text.isEmpty
                        ? "https://images.unsplash.com/photo-1581553680321-4fffae59fccd?q=80&w=400"
                        : _imgController.text,
                    description: "Handmade craft added via Artisan Board.",
                  ),
                );
                Navigator.pop(context);
                _nameController.clear();
                _priceController.clear();
                _imgController.clear();
              },
              child: const Text(
                "POST TO SHOP",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Artisan Dashboard"),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (c) => const LoginScreen()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAccentOrange,
        onPressed: _showAddDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ValueListenableBuilder(
        valueListenable: ProductManager.products,
        builder: (context, List<Product> list, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: list.length,
            itemBuilder: (context, i) => Card(
              child: ListTile(
                leading: Image.network(
                  list[i].imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const Icon(Icons.image),
                ),
                title: Text(list[i].name),
                subtitle: Text("XAF ${list[i].price} | ${list[i].category}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => ProductManager.deleteProduct(list[i].id),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- 7. Profile Screen ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showEditProfile(BuildContext context) {
    final nameCtrl = TextEditingController(
      text: UserManager.currentUser.value.name,
    );
    final locCtrl = TextEditingController(
      text: UserManager.currentUser.value.location,
    );
    final imgCtrl = TextEditingController(
      text: UserManager.currentUser.value.imageUrl,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: locCtrl,
              decoration: const InputDecoration(labelText: "Location"),
            ),
            TextField(
              controller: imgCtrl,
              decoration: const InputDecoration(labelText: "Profile Image URL"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              UserManager.updateProfile(
                nameCtrl.text,
                locCtrl.text,
                imgCtrl.text,
              );
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: UserManager.currentUser,
        builder: (context, user, _) {
          return Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kPrimaryBlue,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.location,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: kPrimaryBlue),
                      title: const Text("Edit Profile"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showEditProfile(context),
                    ),
                    ListTile(
                      leading: const Icon(Icons.favorite, color: kPrimaryBlue),
                      title: const Text("Wishlist"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.payment, color: kPrimaryBlue),
                      title: const Text("Payment Methods"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (c) => const LoginScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// --- 8. Cart Screen ---
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: CartManager.cartItems,
        builder: (context, Map<int, int> items, _) {
          final keys = items.keys.toList();
          if (keys.isEmpty) return const Center(child: Text("Cart is Empty"));

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, i) {
                    try {
                      final prod = ProductManager.products.value.firstWhere(
                        (p) => p.id == keys[i],
                      );
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                prod.imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prod.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "XAF ${prod.price}",
                                    style: const TextStyle(
                                      color: kAccentOrange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CounterWidget(index: prod.id),
                          ],
                        ),
                      );
                    } catch (e) {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total:", style: TextStyle(fontSize: 18)),
                        Text(
                          "XAF ${CartManager.calculateTotal()}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kAccentOrange,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "PROCEED TO CHECKOUT",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// --- 9. Utility Widgets & Sub-Screens ---
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Orders"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (context, i) => Card(
          margin: const EdgeInsets.only(bottom: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: kPrimaryBlue,
              child: Icon(Icons.local_shipping, color: Colors.white),
            ),
            title: Text(
              "Order #CC-90$i",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("Status: Out for Delivery"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  product.imageUrl,
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: RatingManager.ratings,
                        builder: (context, ratings, _) {
                          double rate = ratings[product.id] ?? 0.0;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                Text(
                                  " $rate",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "XAF ${product.price}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: kAccentOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Rate this craft:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // NEW: Rating Bar Interaction
                  Row(
                    children: List.generate(5, (index) {
                      return ValueListenableBuilder(
                        valueListenable: RatingManager.ratings,
                        builder: (context, ratings, _) {
                          double currentRate = ratings[product.id] ?? 0.0;
                          return IconButton(
                            icon: Icon(
                              index < currentRate
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 32,
                            ),
                            onPressed: () => RatingManager.updateRating(
                              product.id,
                              index + 1.0,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "About this craft:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      CartManager.addToCart(product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Added to Cart"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text(
                      "ADD TO CART",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final int index;
  const CounterWidget({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CartManager.cartItems,
      builder: (context, Map<int, int> items, _) {
        return Row(
          children: [
            IconButton(
              onPressed: () => CartManager.decrement(index),
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              "${items[index] ?? 0}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => CartManager.increment(index),
              icon: const Icon(Icons.add_circle_outline, color: kAccentOrange),
            ),
          ],
        );
      },
    );
  }
}
