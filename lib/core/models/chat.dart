import 'package:bytebrain_project_akhir/core/enums/chat_role.dart';

class Message {
  final ChatRole role; // Menyimpan peran dalam chat (misalnya: user atau AI)
  final String message; // Menyimpan isi pesan teks

  // Konstruktor untuk menginisialisasi instance Message dengan peran dan pesan yang diberikan
  Message({
    required this.role,
    required this.message,
  });
}
