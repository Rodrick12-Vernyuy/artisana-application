import 'package:flutter/material.dart';

void main() {
  runApp(const CameroonCraftsApp());
}

// --- Configuration & Branding ---
const Color kPrimaryBlue = Color(0xFF1B2B3A);
const Color kAccentOrange = Color(0xFFD27C4B);
const Color kBackgroundBeige = Color(0xFFFDF7F0);
const Color kCardColor = Colors.white;

// --- 1. Models ---
class Comment {
  final String userName;
  final String text;
  final double rating;
  final DateTime date;
  Comment({
    required this.userName,
    required this.text,
    required this.rating,
    required this.date,
  });
}

class Product {
  final int id;
  final String name;
  final String price;
  final String category;
  final String imageUrl;
  final String description;
  final String artisan;
  final List<Comment> comments;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.artisan,
    required this.comments,
  });
}

// --- 2. State Management (Logic) ---
class ProductManager {
  static final ValueNotifier<List<Product>> products = ValueNotifier([
    // WOODWORK (8 Items)
    Product(
      id: 1,
      name: "Bamileke Elephant Stool",
      price: "55,000",
      category: "Woodwork",
      artisan: "Nfor Furniture",
      imageUrl:
          "https://images.unsplash.com/photo-1581553680321-4fffae59fccd?w=500",
      description:
          "Hand-carved from Iroko wood, representing strength and royalty.",
      comments: [],
    ),
    Product(
      id: 2,
      name: "Fang Ancestral Mask",
      price: "28,000",
      category: "Woodwork",
      artisan: "Beti Artisans",
      imageUrl:
          "https://images.unsplash.com/photo-1503174971373-b1f69850bbd6?w=500",
      description: "Classic elongated mask used in traditional ceremonies.",
      comments: [],
    ),
    Product(
      id: 3,
      name: "Foumban Bronze Wood Inlay",
      price: "42,000",
      category: "Woodwork",
      artisan: "Sultan's Gallery",
      imageUrl:
          "https://images.unsplash.com/photo-1590739290091-94fc8866743b?w=500",
      description: "Rare wood carving with intricate brass wire inlays.",
      comments: [],
    ),
    Product(
      id: 4,
      name: "Mahogany Mortar & Pestle",
      price: "12,500",
      category: "Woodwork",
      artisan: "Village Tools",
      imageUrl:
          "https://images.unsplash.com/photo-1615800098779-1be32e60cca3?w=500",
      description: "Durable kitchenware used for traditional spice grinding.",
      comments: [],
    ),
    Product(
      id: 5,
      name: "Iroko Wall Panel",
      price: "65,000",
      category: "Woodwork",
      artisan: "Coastal Carvers",
      imageUrl:
          "https://images.unsplash.com/photo-1599664989040-d88c11c97344?w=500",
      description: "Large decorative panel featuring Grassfields motifs.",
      comments: [],
    ),
    Product(
      id: 6,
      name: "Ceremonial Spear Stand",
      price: "19,000",
      category: "Woodwork",
      artisan: "Fons Guard",
      imageUrl:
          "https://images.unsplash.com/photo-1589882674326-951c820c7606?w=500",
      description: "Sleek stand for traditional regalia.",
      comments: [],
    ),
    Product(
      id: 7,
      name: "Carved Ebony Pipe",
      price: "8,000",
      category: "Woodwork",
      artisan: "Northern Pipes",
      imageUrl:
          "https://images.unsplash.com/photo-1632516643720-e7f5d7d6ec46?w=500",
      description: "Functional art piece carved from dense black ebony.",
      comments: [],
    ),
    Product(
      id: 8,
      name: "Wooden Bao Game Board",
      price: "15,000",
      category: "Woodwork",
      artisan: "Mancala Masters",
      imageUrl:
          "https://images.unsplash.com/photo-1616628188506-4ad99d63303c?w=500",
      description: "Hand-finished board for the popular African strategy game.",
      comments: [],
    ),

    // TEXTILE (8 Items)
    Product(
      id: 9,
      name: "Royal Toghu Gown",
      price: "95,000",
      category: "Textile",
      artisan: "Mama Esther",
      imageUrl:
          "https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=500",
      description: "Velvet fabric with heavy gold hand-embroidery.",
      comments: [],
    ),
    Product(
      id: 10,
      name: "Blue Ndop Runner",
      price: "22,000",
      category: "Textile",
      artisan: "Baham Weavers",
      imageUrl:
          "https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=500",
      description:
          "Indigo-dyed cotton representing nobility in the West Region.",
      comments: [],
    ),
    Product(
      id: 11,
      name: "Raffia Grass Hat",
      price: "7,500",
      category: "Textile",
      artisan: "Baka Crafts",
      imageUrl:
          "https://images.unsplash.com/photo-1590736969955-71cc69001019?w=500",
      description: "Woven sun hat made from sustainable raffia fibers.",
      comments: [],
    ),
    Product(
      id: 12,
      name: "Kaba Ngondo Dress",
      price: "35,000",
      category: "Textile",
      artisan: "Douala Styles",
      imageUrl:
          "https://images.unsplash.com/photo-1605819215529-092835699041?w=500",
      description: "Traditional Sawa flowing dress for ceremonies.",
      comments: [],
    ),
    Product(
      id: 13,
      name: "Woven Bamboo Basket",
      price: "12,000",
      category: "Textile",
      artisan: "Sanaga Weavers",
      imageUrl:
          "https://images.unsplash.com/photo-1597393428470-103e4323988c?w=500",
      description: "Durable storage basket with organic dye patterns.",
      comments: [],
    ),
    Product(
      id: 14,
      name: "Hand-painted Batik",
      price: "18,500",
      category: "Textile",
      artisan: "Yvette Batik",
      imageUrl:
          "https://images.unsplash.com/photo-1611176057441-2c8777007c25?w=500",
      description: "One-of-a-kind wax resist dyed fabric art.",
      comments: [],
    ),
    Product(
      id: 15,
      name: "Mudcloth Cushion",
      price: "14,000",
      category: "Textile",
      artisan: "Sahel Decor",
      imageUrl:
          "https://images.unsplash.com/photo-1579656381226-5fc460010311?w=500",
      description: "Cotton cushion cover dyed using traditional earth methods.",
      comments: [],
    ),
    Product(
      id: 16,
      name: "Embroidered Tablecloth",
      price: "25,000",
      category: "Textile",
      artisan: "Elite Stitch",
      imageUrl:
          "https://images.unsplash.com/photo-1612037924690-c5eb27733219?w=500",
      description: "Large cotton linen with regional embroidery.",
      comments: [],
    ),

    // JEWELRY (8 Items)
    Product(
      id: 17,
      name: "Brass Chieftain Ring",
      price: "5,000",
      category: "Jewelry",
      artisan: "Metal King",
      imageUrl:
          "https://images.unsplash.com/photo-1535633302703-9420414421cd?w=500",
      description: "Heavy brass ring with traditional insignia.",
      comments: [],
    ),
    Product(
      id: 18,
      name: "Multi-row Seed Beads",
      price: "15,000",
      category: "Jewelry",
      artisan: "Bead Queen",
      imageUrl:
          "https://images.unsplash.com/photo-1611085583191-a3b13b24424a?w=500",
      description: "Vibrant layered necklace popular in the North region.",
      comments: [],
    ),
    Product(
      id: 19,
      name: "Cowrie Shell Anklet",
      price: "3,500",
      category: "Jewelry",
      artisan: "Beachside Artisans",
      imageUrl:
          "https://images.unsplash.com/photo-1605236453806-6ff36851218e?w=500",
      description: "Natural cowrie shells on a leather cord.",
      comments: [],
    ),
    Product(
      id: 20,
      name: "Recycled Glass Earrings",
      price: "4,500",
      category: "Jewelry",
      artisan: "Eco Jewels",
      imageUrl:
          "https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?w=500",
      description: "Powdered glass beads shaped by hand.",
      comments: [],
    ),
    Product(
      id: 21,
      name: "Silver Twisted Bangle",
      price: "20,000",
      category: "Jewelry",
      artisan: "Njoya Silversmiths",
      imageUrl:
          "https://images.unsplash.com/photo-1597659853382-1c7113206811?w=500",
      description: "Pure silver bangle with ancestral engravings.",
      comments: [],
    ),
    Product(
      id: 22,
      name: "Copper Wire Pendant",
      price: "6,000",
      category: "Jewelry",
      artisan: "Wire Wizard",
      imageUrl:
          "https://images.unsplash.com/photo-1612041824524-31d95185630f?w=500",
      description:
          "Intricate copper wire work featuring a semi-precious stone.",
      comments: [],
    ),
    Product(
      id: 23,
      name: "Polished Wood Beads",
      price: "9,000",
      category: "Jewelry",
      artisan: "Forest Gems",
      imageUrl:
          "https://images.unsplash.com/photo-1611575870536-516504c53224?w=500",
      description: "Dark mahogany beads polished to a high shine.",
      comments: [],
    ),
    Product(
      id: 24,
      name: "Ankara Fabric Hoops",
      price: "2,500",
      category: "Jewelry",
      artisan: "Fabric Fun",
      imageUrl:
          "https://images.unsplash.com/photo-1606293926075-69a00dbfde97?w=500",
      description: "Lightweight earrings wrapped in colorful Ankara fabric.",
      comments: [],
    ),
  ]);

  static void deleteProduct(int id) {
    products.value = List.from(products.value)..removeWhere((p) => p.id == id);
  }

  static void addComment(int productId, Comment comment) {
    List<Product> newList = List.from(products.value);
    int idx = newList.indexWhere((p) => p.id == productId);
    if (idx != -1) {
      // Create a new product instance to trigger the ValueNotifier correctly
      Product oldP = newList[idx];
      newList[idx] = Product(
        id: oldP.id,
        name: oldP.name,
        price: oldP.price,
        category: oldP.category,
        imageUrl: oldP.imageUrl,
        description: oldP.description,
        artisan: oldP.artisan,
        comments: List.from(oldP.comments)..insert(0, comment),
      );
      products.value = newList;
    }
  }
}

class CartManager {
  static final ValueNotifier<Map<int, int>> cartItems = ValueNotifier({});

  static void addToCart(int productId) {
    var newMap = Map<int, int>.from(cartItems.value);
    newMap[productId] = (newMap[productId] ?? 0) + 1;
    cartItems.value = newMap;
  }

  static void removeFromCart(int productId) {
    var newMap = Map<int, int>.from(cartItems.value);
    if (newMap.containsKey(productId)) {
      if (newMap[productId]! > 1) {
        newMap[productId] = newMap[productId]! - 1;
      } else {
        newMap.remove(productId);
      }
      cartItems.value = newMap;
    }
  }

  static String calculateTotal() {
    double total = 0;
    cartItems.value.forEach((id, qty) {
      final product = ProductManager.products.value
          .where((p) => p.id == id)
          .firstOrNull;
      if (product != null) {
        double price = double.parse(product.price.replaceAll(',', ''));
        total += price * qty;
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

// --- 3. Main App & Navigation ---
class CameroonCraftsApp extends StatelessWidget {
  const CameroonCraftsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundBeige,
        primaryColor: kPrimaryBlue,
        fontFamily: 'Georgia',
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      ),
    );
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [kPrimaryBlue, Color(0xFF2C3E50)]),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome_mosaic, size: 80, color: kAccentOrange),
            SizedBox(height: 20),
            Text(
              "CAMEROON CRAFTS",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isArtisan = false;
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kPrimaryBlue,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              child: const Center(
                child: Icon(Icons.person_pin, size: 100, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (c) => isArtisan
                            ? const ArtisanDashboard()
                            : const MainContainer(),
                      ),
                    ),
                    child: const Text(
                      "SIGN IN",
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
        ),
      ),
    );
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});
  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _index = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text("Search coming soon")),
    const CartScreen(),
    const Center(child: Text("Settings")),
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
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Shop"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Profile"),
        ],
      ),
    );
  }
}

// --- 4. Home Screen with Search ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCat = "Woodwork";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ProductManager.products,
      builder: (context, List<Product> allProducts, _) {
        final filtered = allProducts
            .where(
              (p) =>
                  p.category == selectedCat &&
                  p.name.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  onChanged: (v) => setState(() => searchQuery = v),
                  decoration: InputDecoration(
                    hintText: "Search crafts...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: ["Woodwork", "Textile", "Jewelry"]
                      .map(
                        (c) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(c),
                            selected: selectedCat == c,
                            onSelected: (v) => setState(() => selectedCat = c),
                            selectedColor: kAccentOrange,
                            labelStyle: TextStyle(
                              color: selectedCat == c
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      )
                      .toList(),
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
                  itemCount: filtered.length,
                  itemBuilder: (c, i) => ProductGridTile(product: filtered[i]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductGridTile extends StatelessWidget {
  final Product product;
  const ProductGridTile({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => DetailScreen(product: product)),
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "XAF ${product.price}",
                    style: const TextStyle(
                      color: kAccentOrange,
                      fontWeight: FontWeight.bold,
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

// --- 5. Detail Screen & Reviews ---
class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _rating = 5.0;
  final _comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: ProductManager.products,
        builder: (context, List<Product> list, _) {
          // Find the most updated version of this product (for comments)
          final p = list.firstWhere(
            (item) => item.id == widget.product.id,
            orElse: () => widget.product,
          );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      p.imageUrl,
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
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "By ${p.artisan}",
                        style: const TextStyle(
                          color: kAccentOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        p.description,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          CartManager.addToCart(p.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to Basket!")),
                          );
                        },
                        child: const Text(
                          "ADD TO BASKET",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Divider(height: 50),
                      const Text(
                        "Rate this Craft",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (i) => IconButton(
                            icon: Icon(
                              i < _rating ? Icons.star : Icons.star_border,
                              color: kAccentOrange,
                            ),
                            onPressed: () => setState(() => _rating = i + 1.0),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _comment,
                        decoration: InputDecoration(
                          hintText: "Add a comment...",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (_comment.text.isNotEmpty) {
                                ProductManager.addComment(
                                  p.id,
                                  Comment(
                                    userName: "User",
                                    text: _comment.text,
                                    rating: _rating,
                                    date: DateTime.now(),
                                  ),
                                );
                                _comment.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...p.comments
                          .map(
                            (c) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                c.userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(c.text),
                              trailing: Text("⭐ ${c.rating.toInt()}"),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- 6. Cart & Admin Screens ---
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Basket")),
      body: ValueListenableBuilder(
        valueListenable: CartManager.cartItems,
        builder: (context, Map<int, int> items, _) {
          final keys = items.keys.toList();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (c, i) {
                    final p = ProductManager.products.value
                        .where((prod) => prod.id == keys[i])
                        .firstOrNull;
                    if (p == null) return const SizedBox();
                    return ListTile(
                      leading: Image.network(
                        p.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(p.name),
                      subtitle: Text("XAF ${p.price}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => CartManager.removeFromCart(p.id),
                          ),
                          Text("${items[p.id]}"),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => CartManager.addToCart(p.id),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: XAF ${CartManager.calculateTotal()}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Checkout"),
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

class ArtisanDashboard extends StatelessWidget {
  const ArtisanDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Artisan Panel"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: ProductManager.products,
        builder: (context, List<Product> list, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: list.length,
            itemBuilder: (c, i) => Card(
              child: ListTile(
                leading: Image.network(list[i].imageUrl, width: 40),
                title: Text(list[i].name),
                subtitle: Text(list[i].category),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
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
