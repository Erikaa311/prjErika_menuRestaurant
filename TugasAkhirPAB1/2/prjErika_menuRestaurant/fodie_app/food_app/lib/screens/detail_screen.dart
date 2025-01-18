import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_screen.dart'; // Pastikan kamu mengimpor OrderScreen

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> food;

  DetailScreen({required this.food});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;

  Future<void> addToOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orders = prefs.getStringList('orders') ?? [];

    final order = {
      'name': widget.food['name'],
      'quantity': quantity.toString(),
      'price': widget.food['price'].replaceAll(',', '').trim(),
      'total': (int.parse(widget.food['price'].replaceAll(',', '').trim()) * quantity).toString(),
    };

    orders.add('${order['name']} - ${order['quantity']} - Rp ${order['total']}');
    await prefs.setStringList('orders', orders);

    // Cetak ke konsol
    print('Pesanan Ditambahkan: ${order['name']}, Quantity: ${order['quantity']}, Total: Rp ${order['total']}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.food['name']} ditambahkan ke pesanan!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    widget.food['image'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.food['name'],
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Harga: ${widget.food['price']}',
                          style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.food['description'],
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                          print('Quantity dikurangi: $quantity');
                        }
                      },
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                        print('Quantity ditambah: $quantity');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: addToOrder,
                  child: Text('Tambahkan ke Pesanan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 111, 189, 114),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    print('Navigasi ke layar pesanan');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderScreen()),
                    );
                  },
                  child: Text('Lihat Pesanan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 70, 195, 182),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
