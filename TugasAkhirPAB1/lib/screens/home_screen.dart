import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart';
import 'fav_screen.dart'; // Import FavScreen
import 'profile_screen.dart'; // Import ProfileScreen
import 'order_screen.dart'; // Import OrderScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> foods = [
    // Data makanan
    {
      'id': 1,
      'image': 'images/pizza.png',
      'name': 'Pizza',
      'rating': '7',
      'price': '50,000',
      'description': 'Pizza lezat dengan topping keju, daging, dan saus tomat.'
    },
    {
      'id': 2,
      'image': 'images/burger.png',
      'name': 'Burger',
      'rating': '7',
      'price': '30,000',
      'description': 'Burger juicy dengan patty daging sapi dan sayuran segar.'
    },
    {
      'id': 3,
      'image': 'images/sushi.png',
      'name': 'Sushi',
      'rating': '8',
      'price': '70,000',
      'description': 'Sushi tradisional Jepang dengan ikan segar dan nasi.'
    },
    {
      'id': 4,
      'image': 'images/naspad.png',
      'name': 'Nasi Padang',
      'rating': '9',
      'price': '30,000',
      'description':
          'Nasi dengan berbagai lauk seperti rendang, ayam gulai, dan sambal hijau.'
    },
    {
      'id': 5,
      'image': 'images/ayampop.png',
      'name': 'Ayam pop',
      'rating': '8',
      'price': '40,000',
      'description':
          'Ayam rebus khas Padang dengan santan, digoreng ringan dan disajikan dengan sambal merah.'
    },
    {
      'id': 6,
      'image': 'images/gado.png',
      'name': 'Gado-gado',
      'rating': '8',
      'price': '20,000',
      'description': 'Salad sayuran segar dengan bumbu kacang yang kaya rasa.'
    },
    {
      'id': 7,
      'image': 'images/mieayam.png',
      'name': 'Mie ayam',
      'rating': '8',
      'price': '15,000',
      'description':
          'Mie kuning dengan topping ayam kecap, kuah kaldu segar, dan sayuran hijau.'
    },
    {
      'id': 8,
      'image': 'images/sate.png',
      'name': 'Sate Madura',
      'rating': '8',
      'price': '25,000',
      'description': 'Tusukan daging panggang dengan bumbu kacang manis gurih.'
    },
    {
      'id': 9,
      'image': 'images/miecelor.png',
      'name': 'Mie Celor',
      'rating': '8',
      'price': '20,000',
      'description':
          'Mie kuning khas Palembang dengan kuah santan kental dan taburan udang.'
    },
    {
      'id': 10,
      'image': 'images/nasigoreng.png',
      'name': 'Nasi Goreng',
      'rating': '8',
      'price': '20,000',
      'description':
          'Nasi goreng gurih dengan campuran kecap manis, telur, dan ayam atau udang.'
    },
    {
      'id': 11,
      'image': 'images/airmineral.png',
      'name': 'Air Mineral',
      'rating': '10',
      'price': '10,000',
      'description':
          'Air Mineral yang bagus.'
    },
    {
      'id': 12,
      'image': 'images/kopi.png',
      'name': 'Kopi ',
      'rating': '10',
      'price': '10,000',
      'description':
          'Kopi Hitam khas sumatera.'
    },
    {
      'id': 13,
      'image': 'images/cocacola.png',
      'name': 'Coca-cola',
      'rating': '8',
      'price': '15,000',
      'description':
          'Minuman Soda yang menyegarkan.'
    },
    {
      'id': 14,
      'image': 'images/esteh.png',
      'name': 'Es Teh Manis',
      'rating': '10',
      'price': '10,000',
      'description':
          'Es teh manis yang menyegarkan.'
    },
    {
      'id': 15,
      'image': 'images/fruitjuice.png',
      'name': 'Jus Buah',
      'rating': '10',
      'price': '18,000',
      'description':
          'Jus Buah yang Menyegarkan dengan Buah Pilihan.'
    },
    {
      'id': 16,
      'image': 'images/hotchocolate.png',
      'name': 'Cokelat Panas',
      'rating': '10',
      'price': '15,000',
      'description':
          'Cokelat Panas dengan menggunakan coklat yang terbaik.'
    },
    {
      'id': 17,
      'image': 'images/hottea.png',
      'name': 'Teh Panas',
      'rating': '10',
      'price': '10,000',
      'description':
          'Teh Panas yang menyehatkan badan.'
    },
    {
      'id': 18,
      'image': 'images/jeruk.png',
      'name': 'Jus Jeruk',
      'rating': '10',
      'price': '15,000',
      'description':
          'Jus Jeruk Murni.'
    },
    {
      'id': 19,
      'image': 'images/matcha.png',
      'name': 'Matcha',
      'rating': '10',
      'price': '15,000',
      'description':
          'Dengan Daun Matcha Pilihan.'
    },
    {
      'id': 20,
      'image': 'images/milkshakeoreo.png',
      'name': 'Milk Shake Oreo',
      'rating': '10',
      'price': '17,000',
      'description':
          'Susu dengan Oreo.'
    },
    {
       'id': 21,
      'image': 'images/milktea.png',
      'name': 'Milk Tea',
      'rating': '10',
      'price': '14,000',
      'description':
          'Teh dengan susu yang menyegarkan.'
    },
    {
      'id': 22,
      'image': 'images/mocktail.png',
      'name': 'Mocktail',
      'rating': '10',
      'price': '20,000',
      'description':
          'Minuman yan menyegarkan dengan Buah.'
    },
    {
      'id': 23,
      'image': 'images/mojito.png',
      'name': 'Mojito',
      'rating': '10',
      'price': '20,000',
      'description':
          'Minuman dengan rasa sirup.'
    },
    {
      'id': 24,
      'image': 'images/smoothie.png',
      'name': 'Smoothies',
      'rating': '10',
      'price': '20,000',
      'description':
          'Minuman perpaduan buah dengan susu.'
    }
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredFoods = [];

  // Untuk menandai makanan favorit
  Set<int> favoriteFoodIds = Set<int>();

  @override
  void initState() {
    super.initState();
    filteredFoods = foods; // Menampilkan semua makanan pada awalnya
  }

  Future<void> addToFavorites(Map<String, dynamic> food) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    if (!favorites.contains(food['name'])) {
      favorites.add(food['name']);
      await prefs.setStringList('favorites', favorites);

      setState(() {
        favoriteFoodIds.add(food['id']);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${food['name']} ditambahkan ke favorit!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${food['name']} sudah ada dalam favorit!')),
      );
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu - FodieApp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade200, // Sky blue AppBar
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('images/restaurant_logo.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavScreen()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.lightBlue.shade50, // Sky blue background
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Mau cari apa?',
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) => setState(() {
                filteredFoods = foods
                    .where((food) => food['name']
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
              }),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: filteredFoods.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> food = filteredFoods[index];
                bool isFavorite = favoriteFoodIds.contains(food['id']);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(food: food),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.asset(
                            food['image'],
                            height: 120,
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
                                food['name'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                              ),
                              SizedBox(height: 5),
                              Text('Harga: ${food['price']}', style: TextStyle(color: Colors.black)),
                              SizedBox(height: 5),
                              Text(
                                food['description'],
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.black),
                          onPressed: () => addToFavorites(food),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
