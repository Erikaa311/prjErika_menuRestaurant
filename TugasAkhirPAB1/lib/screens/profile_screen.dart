import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String phone = '';
  String tableNumber = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Tidak diketahui';
      phone = prefs.getString('phone') ?? 'Tidak diketahui';
      tableNumber = prefs.getString('tableNumber') ?? 'Tidak diketahui';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Anda',
          style: TextStyle(color: const Color.fromARGB(255, 8, 4, 4)),
        ),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(255, 247, 244, 244), // AppBar putih
        elevation: 0,
      ),
      backgroundColor: Color(0xFF87CEEB), // Skyblue
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Informasi Profil',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(color: Colors.black),
            ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: Text('Nama', style: TextStyle(color: Colors.black)),
              subtitle: Text(name, style: TextStyle(color: Colors.black54)),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.black),
              title:
                  Text('Nomor WhatsApp', style: TextStyle(color: Colors.black)),
              subtitle: Text(phone, style: TextStyle(color: Colors.black54)),
            ),
            ListTile(
              leading: Icon(Icons.table_bar, color: Colors.black),
              title: Text('Nomor Meja', style: TextStyle(color: Colors.black)),
              subtitle:
                  Text(tableNumber, style: TextStyle(color: Colors.black54)),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Logout', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white, // Teks tombol hitam
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black), // Border hitam
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
