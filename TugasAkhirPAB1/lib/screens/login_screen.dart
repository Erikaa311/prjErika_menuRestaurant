import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController nameController =
      TextEditingController(); // Input untuk nama
  final TextEditingController phoneController =
      TextEditingController(); // Input untuk nomor WhatsApp
  final TextEditingController tableNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> authenticate(BuildContext context) async {
    final name = nameController.text.trim(); // Ambil nilai nama
    final phone = phoneController.text.trim(); // Ambil nilai nomor WhatsApp
    final tableNumber = tableNumberController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        tableNumber.isEmpty ||
        password.isEmpty) {
      // Validasi input kosong
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Gagal', style: TextStyle(color: Colors.black)),
          content: Text('Semua kolom harus diisi!',
              style: TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      );
    } else if (password != '12345') {
      // Validasi password salah
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Gagal', style: TextStyle(color: Colors.black)),
          content:
              Text('Password salah!', style: TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: Colors.black)),
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
                colors: [Colors.lightBlue.shade200, Colors.lightBlue.shade50],
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
                color: Colors.lightBlue.shade50, // Warna card sky blue terang
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.lightBlue,
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
                          color: Colors.black, // Hitam untuk teks
                        ),
                      ),
                      SizedBox(height: 10),
                      // Tambahan input untuk nama
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          labelStyle: TextStyle(
                              color: Colors.black), // Teks label hitam
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.person,
                              color: Colors.lightBlue), // Ikon sky blue
                        ),
                      ),
                      SizedBox(height: 15),
                      // Tambahan input untuk nomor WhatsApp
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Nomor WhatsApp',
                          labelStyle: TextStyle(
                              color: Colors.black), // Teks label hitam
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.phone,
                              color: Colors.lightBlue), // Ikon sky blue
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 15),
                      // Input nomor meja
                      TextField(
                        controller: tableNumberController,
                        decoration: InputDecoration(
                          labelText: 'Nomor Meja',
                          labelStyle: TextStyle(
                              color: Colors.black), // Teks label hitam
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.table_bar,
                              color: Colors.lightBlue), // Ikon sky blue
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
                          labelStyle: TextStyle(
                              color: Colors.black), // Teks label hitam
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.lock,
                              color: Colors.lightBlue), // Ikon sky blue
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () => authenticate(context),
                        child: Text('Login',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue, // Sky blue
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
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
