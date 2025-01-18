import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart'; // Impor DetailScreen
import 'profile_screen.dart'; // Impor ProfileScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> foods = [
    {'id': 1, 'image': 'images/pizza.png', 'name': 'Pizza', 'rating': '7', 'price': '50,000', 'description': 'Pizza lezat dengan topping keju, daging, dan saus tomat.'},
    {'id': 2, 'image': 'images/burger.png', 'name': 'Burger', 'rating': '7', 'price': '30,000', 'description': 'Burger juicy dengan patty daging sapi dan sayuran segar.'},
    {'id': 3, 'image': 'images/sushi.png', 'name': 'Sushi', 'rating': '8', 'price': '70,000', 'description': 'Sushi tradisional Jepang dengan ikan segar dan nasi.'},
    {'id': 4, 'image': 'images/naspad.png', 'name': 'Nasi Padang', 'rating': '9', 'price': '30,000', 'description': 'Nasi dengan berbagai lauk seperti rendang, ayam gulai, dan sambal hijau.'},
    {'id': 5, 'image': 'images/ayampop.png', 'name': 'Ayam pop', 'rating': '8', 'price': '40,000', 'description': 'Ayam rebus khas Padang dengan santan, digoreng ringan dan disajikan dengan sambal merah.'},
    {'id': 6, 'image': 'images/gado.png', 'name': 'Gado-gado', 'rating': '8', 'price': '20,000', 'description': 'Salad sayuran segar dengan bumbu kacang yang kaya rasa.'},
    {'id': 7, 'image': 'images/mieayam.png', 'name': 'Mie ayam', 'rating': '8', 'price': '15,000', 'description': 'Mie kuning dengan topping ayam kecap, kuah kaldu segar, dan sayuran hijau.'},
    {'id': 8, 'image': 'images/sate.png', 'name': 'Sate Madura', 'rating': '8', 'price': '25,000', 'description': 'Tusukan daging panggang dengan bumbu kacang manis gurih.'},
    {'id': 9, 'image': 'images/miecelor.png', 'name': 'Mie Celor', 'rating': '8', 'price': '20,000', 'description': 'Mie kuning khas Palembang dengan kuah santan kental dan taburan udang.'},
    {'id': 10, 'image': 'images/nasigoreng.png', 'name': 'Nasi Goreng', 'rating': '8', 'price': '20,000', 'description': 'Nasi goreng gurih dengan campuran kecap manis, telur, dan ayam atau udang.'},
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredFoods = [];

  @override
  void initState() {
    super.initState();
    filteredFoods = foods; // Awalnya tampilkan semua makanan
  }

  Future<bool> isFavorite(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('${id}_favorite') ?? false;
  }

  void toggleFavorite(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFav = await isFavorite(id);
    prefs.setBool('${id}_favorite', !isFav);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    'Menu - FodieApp',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  centerTitle: true,
  actions: [
    IconButton(
      icon: Icon(Icons.person),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      },
    ),
  ],
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari makanan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) => setState(() {
                filteredFoods = foods
                    .where((food) => food['name'].toLowerCase().contains(query.toLowerCase()))
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text('Rating: ${food['rating']}'),
                              Text('Harga: ${food['price']}'),
                              SizedBox(height: 5),
                              Text(
                                food['description'],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder<bool>(
                          future: isFavorite(food['id']),
                          builder: (context, snapshot) {
                            bool isFav = snapshot.data ?? false;
                            return IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () => toggleFavorite(food['id']),
                            );
                          },
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
