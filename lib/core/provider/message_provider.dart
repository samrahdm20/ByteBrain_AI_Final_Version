import 'package:bytebrain_project_akhir/core/trained_data/trained_data.dart';
import 'package:bytebrain_project_akhir/core/enums/chat_role.dart';
import 'package:bytebrain_project_akhir/core/models/chat.dart';
import 'package:bytebrain_project_akhir/core/repositry/gemini_repositry.dart';
import 'package:bytebrain_project_akhir/core/services/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bytebrain_project_akhir/core/notes/db_handler.dart';
import 'package:bytebrain_project_akhir/core/notes/model.dart';

class MessageProvider extends ChangeNotifier {
  final GeminiChatRepositry
      _bardChatRepositry; // Repositori untuk komunikasi dengan Gemini

  MessageProvider(
      this._bardChatRepositry); // Konstruktor untuk inisialisasi repositori

  final List<Map<String, dynamic>> _contents =
      trainedData; // Data pelatihan awal
  final List<Message> _messages = [
    Message(
      role: ChatRole.model,
      // Pesan awal dari model
      message:
          'Halo selamat datang, saya ByteBrain (Binary Yet Technical Entity Brain), yaitu sebuah kecerdasan buatan yang dilatih oleh tim dari SMA Muhammadiyah Ambon yang terdiri dari Chairil Ali dan Samrah Daeng Makase. Tugas saya adalah menjawab pertanyaan anda untuk berbagai topik keilmuan, saya juga bisa sebagai teman curhat dan asisten pribadi yang siap membantumu dalam berbagai tugas yang diberikan, perlu diingat bahwa saya bisa saja membuat kesalahan karena masih terus dikembangkan, namun saya belajar tiap harinya. Apakah ada yang bisa saya bantu? 🤖\n\nUntuk melihat daftar catatan anda, silahkan ketik "catatan".',
    ),
  ];

  // Kontrol untuk scrolling
  final ScrollController _scrollController = ScrollController();

  bool _isTyping = false; // Status apakah model sedang mengetik

  final DBHelper _dbHelper = DBHelper(); // Helper untuk database notes

  List<Message> get messages => _messages; // Mendapatkan daftar pesan
  ScrollController get scrollController =>
      _scrollController; // Mendapatkan kontrol scroll
  bool get isTyping => _isTyping; // Mendapatkan status typing

  Future<List<TodoModel>> getNotes() async {
    return await _dbHelper
        .getDataList(); // Mendapatkan daftar notes dari database
  }

  Future<void> sendPrompt(String message) async {
    debugPrint('Pesan yang dikirim: $message');
    _messages.add(Message(
        role: ChatRole.user, message: message)); // Menambahkan pesan pengguna
    notifyListeners(); // Memberitahu listener bahwa ada perubahan

    if (message.toLowerCase().contains('catatan') ||
        message.toLowerCase().contains('notes')) {
      List<TodoModel> notes = await getNotes();
      String response = formatNotesResponse(notes);
      _messages.add(Message(
          role: ChatRole.model, message: response)); // Menambahkan respon notes
    } else {
      _contents.add({
        "role": "user",
        "parts": [
          {
            "text": message,
          }
        ]
      });
      _goToRecentMessage(); // Scroll ke pesan terbaru

      _isTyping = true;
      notifyListeners(); // Memberitahu listener bahwa model sedang mengetik

      await _getBardResponse(); // Mendapatkan respon dari Gemini

      _isTyping = false;
    }

    notifyListeners(); // Memberitahu listener setelah typing selesai
    _goToRecentMessage(); // Scroll ke pesan terbaru
  }

  String formatNotesResponse(List<TodoModel> notes) {
    if (notes.isEmpty) {
      return "Hmm, Anda belum memiliki catatan. Silakan tambahkan catatan melalui fitur Notes.";
    }

    String response = "Berikut adalah daftar catatan Anda:\n\n";
    for (var note in notes) {
      response += "- ${note.title}\n"; // Menampilkan judul catatan
    }
    response +=
        "\nUntuk menambah, mengedit, atau menghapus catatan, silakan gunakan fitur Notes, Anda bisa mengaksesnya pada menu pojok kanan atas layar.";
    return response;
  }

  Future<void> _getBardResponse() async {
    try {
      debugPrint('Memulai permintaan ke Gemini');
      final response = await _bardChatRepositry
          .getBardResponse(_contents); // Mendapatkan respons dari Gemini
      debugPrint('Respons dari Gemini diterima');
      _contents.add(response);
      _messages.add(Message(
          role: ChatRole.model,
          message: response['parts'][0]
              ['text'])); // Menambahkan respon ke pesan
      notifyListeners(); // Memberitahu listener setelah mendapatkan respons
      _goToRecentMessage(); // Scroll ke pesan terbaru
    } catch (e) {
      debugPrint('Error saat mendapatkan respons dari Bard: $e');
      _contents.removeLast(); // Menghapus konten terakhir jika terjadi error
      throw Exception(e);
    }
  }

  void _goToRecentMessage() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +
          _scrollController.position.viewportDimension,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    ); // Scroll ke pesan terbaru dengan gaya
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    ); // Scroll ke bagian bawah
  }
}

// Provider untuk MessageProvider dengan GeminiChatService
final messagesProvider =
    ChangeNotifierProvider((ref) => MessageProvider(GeminiChatService()));
