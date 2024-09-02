import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiSingleton {
  // Membuat instance tunggal dari GeminiSingleton menggunakan pola Singleton
  static final GeminiSingleton _singleton = GeminiSingleton._internal();

  // Deklarasi instance Gemini yang akan diinisialisasi nanti
  late Gemini _geminiInstance;

  // Factory constructor untuk mengembalikan instance tunggal
  factory GeminiSingleton() {
    return _singleton;
  }

  // Konstruktor internal yang digunakan untuk inisialisasi instance
  GeminiSingleton._internal() {
    debugPrint('inisialisasi gemini'); // Debug print saat inisialisasi
    _geminiInstance = Gemini(GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey:
            "AIzaSyAsKsKFL003veNaTE7lOxBkfUmugsDabc8")); // Inisialisasi Gemini dengan model yang ditentukan
  }

  // Getter untuk mendapatkan instance Gemini yang telah diinisialisasi
  Gemini get geminiInstance => _geminiInstance;
}

class Gemini {
  // Model generatif yang digunakan dalam instance Gemini
  // ignore: prefer_typing_uninitialized_variables
  final model;

  // Konstruktor untuk menginisialisasi instance Gemini dengan model tertentu
  Gemini(this.model);
}
