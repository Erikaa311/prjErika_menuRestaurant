import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      'total': (int.parse(widget.food['price'].replaceAll(',', '').trim()) *
              quantity)
          .toString(),
    };

    orders
        .add('${order['name']} - ${order['quantity']} - Rp ${order['total']}');
    await prefs.setStringList('orders', orders);

    // Cetak ke konsol
    print(
        'Pesanan Ditambahkan: ${order['name']}, Quantity: ${order['quantity']}, Total: Rp ${order['total']}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.food['name']} ditambahkan ke pesanan!')),
    );

    // Navigate back to the home screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Menu', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.lightBlue.shade200, // Sky blue AppBar
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // Ikon warna hitam
      ),
      backgroundColor: Colors.lightBlue.shade50, // Latar belakang sky blue terang
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menyesuaikan gambar
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  widget.food['image'],
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3, // Responsif
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              // Card untuk informasi makanan
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.lightBlue.shade50, // Sky blue terang untuk card
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.food['name'],
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Harga: ${widget.food['price']}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.food['description'],
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Menambahkan jumlah makanan
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.lightBlue),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.lightBlue),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 100), // Extra space to prevent overlap
            ],
          ),
        ),
      ),
      // Button untuk menambahkan ke pesanan
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: addToOrder,
          child: Text('Tambahkan ke Pesanan',
              style: TextStyle(color: Colors.black)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue, // Sky blue
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
