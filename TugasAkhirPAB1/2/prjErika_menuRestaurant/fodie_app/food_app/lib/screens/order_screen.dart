import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class SharedPreferencesHelper {
  static Future<String> getTableNumber() async {
    final prefs = await SharedPreferences.getInstance();
    final tableNumber = prefs.getString('tableNumber') ?? 'Unknown';
    print('Nomor Meja: $tableNumber');  // Tambahkan log ini
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
          final priceString = parts[2].replaceAll('Rp ', '').replaceAll(',', '').trim();
          final price = int.tryParse(priceString) ?? 0;
          return sum + price;
        }
        return sum;
      });
    } catch (e) {
      print('Error menghitung total: $e');
    }

    // Hitung pajak 10%
    double tax = total * 0.10;
    int totalWithTax = (total + tax).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Pesanan'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String foodName = '';
                  int foodQuantity = 1;
                  String foodPrice = '';
                  return AlertDialog(
                    title: Text('Tambah Pesanan'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'Nama Makanan'),
                          onChanged: (value) {
                            foodName = value;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Jumlah'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            foodQuantity = int.tryParse(value) ?? 1;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Harga (tanpa Rp)'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            foodPrice = value;
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (foodName.isNotEmpty && foodPrice.isNotEmpty) {
                            addOrder('$foodName - $foodQuantity - Rp $foodPrice');
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Simpan'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: getTableNumber(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Container(
              color: Colors.grey[200],
              child: orders.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada pesanan.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Nomor Meja: ${snapshot.data}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                int price = int.tryParse(parts[2].replaceAll('Rp ', '').replaceAll(',', '').trim()) ?? 0;
                                return Card(
                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.fastfood, color: Colors.teal),
                                    title: Text('Pesanan ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                      'Nama: $foodName \nJumlah: $quantity \nTotal: Rp ${price.toString().replaceAll(',', '.')}',
                                      style: TextStyle(color: Colors.grey[700]),
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
                                'Total Pesanan: Rp. ${total.toString().replaceAll(',', '.')}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Pajak (10%): Rp. ${tax.toStringAsFixed(0).replaceAll('.', ',')}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Total yang Harus Dibayar: Rp. ${totalWithTax.toString().replaceAll(',', '.')}',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Harap menunggu, pesanan sedang diproses',
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          } else {
            return Center(child: Text('Tidak dapat memuat nomor meja.'));
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
