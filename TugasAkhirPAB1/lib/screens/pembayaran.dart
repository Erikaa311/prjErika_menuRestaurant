import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart'; // Import HomeScreen untuk navigasi kembali ke home

class PembayaranScreen extends StatefulWidget {
  final int totalWithTax;

  PembayaranScreen({required this.totalWithTax});

  @override
  _PembayaranScreenState createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  List<String> paymentMethods = [
    "Cash",
    "OVO",
    "ShopeePay",
    "GoPay",
    "Kartu Kredit"
  ];
  String selectedMethod = "";

  Future<void> clearOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('orders');
  }

  @override
  Widget build(BuildContext context) {
    double ppn = widget.totalWithTax * 0.11;
    int totalWithPPN = (widget.totalWithTax + ppn).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF87CEEB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total yang Harus Dibayar:',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Rp. ${totalWithPPN.toString().replaceAll(',', '.')}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '(Termasuk PPN 11%: Rp. ${ppn.toStringAsFixed(0).replaceAll('.', ',')})',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Pilih Metode Pembayaran:',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: paymentMethods.map((method) {
                          return RadioListTile<String>(
                            title: Text(
                              method,
                              style: TextStyle(color: Colors.black),
                            ),
                            value: method,
                            groupValue: selectedMethod,
                            onChanged: (String? value) {
                              setState(() {
                                selectedMethod = value ?? "";
                              });
                            },
                            activeColor: Colors.black,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: selectedMethod.isNotEmpty
                  ? () async {
                      await clearOrders();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Pembayaran Berhasil!'),
                          content: Text(
                              'Metode: $selectedMethod\nTerima kasih telah memesan.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (route) => false,
                                );
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedMethod.isNotEmpty ? Colors.black : Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Konfirmasi Pembayaran',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
