import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<String> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteItems = prefs.getStringList('favorites') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white, // AppBar putih
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // Ikon hitam
      ),
      backgroundColor: Color(0xFF87CEEB), // Latar belakang skyblue
      body: favoriteItems.isEmpty
          ? Center(
              child: Text(
                'Tidak ada makanan favorit.',
                style:
                    TextStyle(fontSize: 18, color: Colors.black), // Teks hitam
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    color: Colors.white, // Kartu putih
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Text(
                        favoriteItems[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black, // Teks hitam
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black, // Ikon hitam untuk hapus
                        ),
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          favoriteItems.removeAt(index);
                          await prefs.setStringList('favorites', favoriteItems);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
