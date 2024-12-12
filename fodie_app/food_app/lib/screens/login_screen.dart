import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController(); // Input untuk nama
  final TextEditingController phoneController = TextEditingController(); // Input untuk nomor WhatsApp
  final TextEditingController tableNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> authenticate(BuildContext context) async {
    final name = nameController.text.trim(); // Ambil nilai nama
    final phone = phoneController.text.trim(); // Ambil nilai nomor WhatsApp
    final tableNumber = tableNumberController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || phone.isEmpty || tableNumber.isEmpty || password.isEmpty) {
      // Validasi input kosong
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Gagal'),
          content: Text('Semua kolom harus diisi!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else if (password != '12345') {
      // Validasi password salah
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Gagal'),
          content: Text('Password salah!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Simpan data di SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name); // Simpan nama
      await prefs.setString('phone', phone); // Simpan nomor WhatsApp
      await prefs.setString('tableNumber', tableNumber);

      // Navigasi ke halaman berikutnya
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.fastfood,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Selamat datang',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Tambahan input untuk nama
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 15),
                      // Tambahan input untuk nomor WhatsApp
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Nomor WhatsApp',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 15),
                      // Input nomor meja
                      TextField(
                        controller: tableNumberController,
                        decoration: InputDecoration(
                          labelText: 'Nomor Meja',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.table_bar),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),
                      // Input password
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () => authenticate(context),
                        child: Text('Login', style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 128, 199, 227),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
