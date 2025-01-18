class Order {
  final String name; // Nama makanan
  final String image; // Lokasi gambar makanan
  final int quantity; // Jumlah pesanan
  final double price; // Harga makanan

  // Constructor untuk inisialisasi data
  Order({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });
}
