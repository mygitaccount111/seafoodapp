import 'package:flutter/material.dart';

void main() {
  runApp(SeafoodApp());
}

class SeafoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Seafood',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, String>> cart = [];

  void addToCart(Map<String, String> item) {
    setState(() {
      cart.add(item);
    });
  }

  void removeFromCart(Map<String, String> item) {
    setState(() {
      cart.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: Text('welcome to the Healthy Seafood'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Items'),
              Tab(text: 'Cart'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            ItemsPage(addToCart: addToCart),
            CartPage(cart: cart, removeFromCart: removeFromCart),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Healthy Seafood',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
//hello jhsdfjhsdgfjdsh
class ItemsPage extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'name': 'Fish Fry',
      'image': 'lib/assets/images/fish_curry.jpeg',
      'place': 'Coastal Area',
      'ingredients': 'Fish, Spices, Oil',
      'type': 'Non-Vegetarian',
      'healthy': 'Yes',
      'price': '\$10.00',
      'discount': '10%',
    },
    {
      'name': 'Prawns Fry',
      'image': 'lib/assets/images/fish_fry.jpeg',
      'place': 'River Area',
      'ingredients': 'Prawns, Garlic, Chili',
      'type': 'Non-Vegetarian',
      'healthy': 'Yes',
      'price': '\$12.00',
      'discount': '5%',
    },
    {
      'name': 'Shrimp Fry',
      'image': 'lib/assets/images/prawns_fry.jpeg',
      'place': 'Ocean',
      'ingredients': 'Shrimp, Lemon, Butter',
      'type': 'Non-Vegetarian',
      'healthy': 'No',
      'price': '\$15.00',
      'discount': '0%',
    },
    {
      'name': 'Seafood Soup',
      'image': 'lib/assets/images/seafood_soup.jpeg',
      'place': 'Coastal Area',
      'ingredients': 'Fish, Herbs, Olive Oil',
      'type': 'Non-Vegetarian',
      'healthy': 'Yes',
      'price': '\$8.00',
      'discount': '20%',
    },
  ];

  final Function(Map<String, String>) addToCart;

  ItemsPage({required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75, // Aspect ratio for each grid item
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate to detail page when tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailPage(
                  item: items[index],
                  addToCart: addToCart,
                ),
              ),
            );
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      items[index]['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index]['name']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text('Place: ${items[index]['place']}'),
                      Text('Ingredients: ${items[index]['ingredients']}'),
                      Text('Type: ${items[index]['type']}'),
                      Text('Healthy: ${items[index]['healthy']}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemDetailPage extends StatelessWidget {
  final Map<String, String> item;
  final Function(Map<String, String>) addToCart;

  ItemDetailPage({required this.item, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']!),
      ),
      body: Column(
        children: [
          Image.asset(item['image']!, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Place: ${item['place']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Ingredients: ${item['ingredients']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Type: ${item['type']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Healthy: ${item['healthy']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Price: ${item['price']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Discount: ${item['discount']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    addToCart(item);
                    Navigator.pop(context);

                    // Show SnackBar notification
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['name']} added to cart!'),
                        duration: Duration(seconds: 4),
                      ),
                    );
                  },
                  child: Text('Add to Cart',style: TextStyle(color: Colors.green,fontSize: 20),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, String>> cart;
  final Function(Map<String, String>) removeFromCart;

  CartPage({required this.cart, required this.removeFromCart});

  @override
  Widget build(BuildContext context) {
    return cart.isEmpty
        ? Center(
            child: Text('Your cart is empty', style: TextStyle(fontSize: 18)),
          )
        : ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.asset(cart[index]['image']!, fit: BoxFit.cover, width: 50),
                  title: Text(cart[index]['name']!),
                  subtitle: Text('Price: ${cart[index]['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      removeFromCart(cart[index]);
                    },
                  ),
                ),
              );
            },
          );
  }
}
