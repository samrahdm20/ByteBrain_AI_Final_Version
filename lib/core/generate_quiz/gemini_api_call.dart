import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApi {
  // Konstruktor GeminiApi menerima tipe model sebagai parameter dan menginisialisasi _model
  GeminiApi({required String type})
      : _model = GenerativeModel(
          model: type,
          apiKey: dotenv.get("API_KEY"), // Mendapatkan API key dari file .env
        );

  final GenerativeModel _model; // Menyimpan instance model generatif

  // Fungsi untuk menghasilkan konten berdasarkan prompt yang diberikan
  Future<String?> generateContent(String prompt) async {
    final response = await _model.generateContent([
      Content.text(
          prompt), // Mengirim prompt sebagai input untuk model generatif
    ]);

    return response.text; // Mengembalikan teks hasil dari model
  }
}
