import 'package:flutter/material.dart';
import 'package:food_app/screens/pembayaran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class SharedPreferencesHelper {
  static Future<String> getTableNumber() async {
    final prefs = await SharedPreferences.getInstance();
    final tableNumber = prefs.getString('tableNumber') ?? 'Unknown';
    print('Nomor Meja: $tableNumber');
    return tableNumber;
  }
}

class _OrderScreenState extends State<OrderScreen> {
  List<String> orders = [];

  Future<void> loadOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      orders = prefs.getStringList('orders') ?? [];
    });
  }

  Future<void> addOrder(String order) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    orders.add(order);
    await prefs.setStringList('orders', orders);
    setState(() {});
  }

  Future<void> removeOrder(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    orders.removeAt(index);
    await prefs.setStringList('orders', orders);
    setState(() {});
  }

  Future<String> getTableNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('tableNumber') ?? 'Unknown';
  }

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    int total = 0;

    try {
      total = orders.fold(0, (sum, item) {
        final parts = item.split(' - ');
        if (parts.length == 3) {
          final priceString =
              parts[2].replaceAll('Rp ', '').replaceAll(',', '').trim();
          final price = int.tryParse(priceString) ?? 0;
          return sum + price;
        }
        return sum;
      });
    } catch (e) {
      print('Error menghitung total: $e');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Pesanan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFF87CEEB), // Skyblue
      body: FutureBuilder<String>(
        future: getTableNumber(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Container(
              color: Color(0xFF87CEEB), // Skyblue
              child: orders.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada pesanan.',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Nomor Meja: ${snapshot.data}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              final parts = orders[index].split(' - ');
                              if (parts.length == 3) {
                                String foodName = parts[0];
                                int quantity = int.tryParse(parts[1]) ?? 1;
                                int price = int.tryParse(parts[2]
                                        .replaceAll('Rp ', '')
                                        .replaceAll(',', '')
                                        .trim()) ??
                                    0;
                                return Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Icon(Icons.fastfood,
                                        color: Colors.black),
                                    title: Text('Pesanan ${index + 1}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    subtitle: Text(
                                      'Nama: $foodName \nJumlah: $quantity \nTotal: Rp ${price.toString().replaceAll(',', '.')}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    trailing: IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        removeOrder(index);
                                      },
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'Total yang Harus Dibayar: Rp. ${total.toString().replaceAll(',', '.')}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PembayaranScreen(totalWithTax: total),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 5, 4, 3),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Lanjutkan ke Pembayaran',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          } else {
            return Center(
                child: Text('Tidak dapat memuat nomor meja.',
                    style: TextStyle(color: Colors.black)));
          }
        },
      ),
    );
  }
}
