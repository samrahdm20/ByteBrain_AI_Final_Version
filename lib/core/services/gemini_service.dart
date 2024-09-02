import 'package:dio/dio.dart';
import 'package:bytebrain_project_akhir/core/repositry/gemini_repositry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiChatService extends GeminiChatRepositry {
  final Dio _dio =
      Dio(); // Membuat instance Dio untuk melakukan permintaan HTTP.

  @override
  Future<Map<String, dynamic>> getBardResponse(
      List<Map<String, dynamic>> contents) async {
    final apiKey = dotenv.get('API_KEY'); // Mengambil API key dari file .env.
    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';
    final data = {
      "contents": contents, // Konten yang dikirim ke API.
      "generationConfig": {
        "temperature": 0.9, // Mengatur variasi respons.
        "topK": 1, // Mengatur top-K sampling.
        "topP": 1, // Mengatur top-P sampling.
        "maxOutputTokens": 2048, // Maksimum token output yang dihasilkan.
        "stopSequences": []
      },
      "safetySettings": [
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "threshold":
              "BLOCK_ONLY_HIGH" // Mengatur kategori keamanan untuk mencegah konten pelecehan.
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "threshold":
              "BLOCK_ONLY_HIGH" // Mengatur kategori keamanan untuk mencegah ujaran kebencian.
        },
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "threshold":
              "BLOCK_ONLY_HIGH" // Mengatur kategori keamanan untuk mencegah konten seksual eksplisit.
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "threshold":
              "BLOCK_ONLY_HIGH" // Mengatur kategori keamanan untuk mencegah konten berbahaya.
        }
      ]
    };
    try {
      debugPrint('Mengirim permintaan API ke: $url');
      debugPrint('Data yang dikirim: $data');

      final response = await _dio.post(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json', // Mengatur header konten JSON.
        }),
        data: data, // Mengirim data dalam permintaan POST.
      );

      debugPrint('Respons API diterima: ${response.data}');
      return response.data['candidates'][0]
          ['content']; // Mengembalikan konten dari kandidat pertama.
    } catch (e) {
      debugPrint('Error saat memanggil API: $e');
      throw Exception(e); // Meneruskan exception untuk ditangani lebih lanjut.
    }
  }
}
