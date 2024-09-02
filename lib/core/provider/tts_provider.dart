import 'package:flutter_tts/flutter_tts.dart';

class TTSProvider {
  // Implementasi pola Singleton
  static final TTSProvider _instance = TTSProvider._internal();

  // Konstruktor factory mengembalikan instance singleton
  factory TTSProvider() => _instance;

  // Konstruktor internal privat
  TTSProvider._internal();

  // Instance dari FlutterTts
  final FlutterTts _flutterTts = FlutterTts();

  // Metode untuk memicu TTS berbicara teks yang diberikan
  Future<void> speak(String text) async {
    await _flutterTts.setPitch(0.8); // Mengatur tingkat pitch (nada suara)
    await _flutterTts.setSpeechRate(0.5); // Mengatur kecepatan berbicara
    await _flutterTts
        .speak(text); // Perintah untuk berbicara teks yang diberikan
  }
}
