import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextProvider extends ChangeNotifier {
  final SpeechToText _speechToText =
      SpeechToText(); // Instance untuk mengelola SpeechToText
  bool _isAvailable = false; // Status ketersediaan SpeechToText
  String _text = ''; // Hasil transkripsi teks
  String _status = 'Mendengar...'; // Status saat ini

  String get text => _text; // Mendapatkan teks hasil transkripsi
  String get status => _status; // Mendapatkan status saat ini

  Future<bool> isAvailabe() async {
    _isAvailable = await _speechToText.initialize(
      onStatus: (status) {
        debugPrint('Status: $status'); // Mencetak status
      },
      onError: (error) {
        debugPrint('Error: $error'); // Mencetak error
        _status = 'Berhenti'; // Memperbarui status jika ada error
        notifyListeners(); // Memberitahu listener bahwa status telah berubah
      },
      finalTimeout: const Duration(seconds: 5),
    );
    return _isAvailable; // Mengembalikan status ketersediaan
  }

  void startListening() {
    _speechToText.listen(
      onResult: _onSpeechResult, // Callback untuk hasil transkripsi
      listenFor: const Duration(seconds: 30), // Durasi mendengarkan
      pauseFor: const Duration(seconds: 5), // Durasi jeda sebelum melanjutkan
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      debugPrint(
          'Final Result: ${result.recognizedWords}'); // Mencetak hasil akhir
      _text = result.recognizedWords; // Menyimpan teks hasil akhir
      _status = 'Selesai'; // Memperbarui status jika hasil akhir
    } else {
      debugPrint(
          'Interim Result: ${result.recognizedWords}'); // Mencetak hasil sementara
      _text = result.recognizedWords;
    }
    notifyListeners(); // Memberitahu listener bahwa teks atau status telah berubah
  }

  // stop mendengarkan
  void stopListening() {
    _status = 'Mendengar...';
    _text = '';
    _speechToText.stop();
  }

  // batal mendengarkan
  void cancelListening() {
    _status = 'Mendengar...';
    _text = '';
    _speechToText.cancel();
  }
}

// Provider untuk SpeechToTextProvider
final speechToTextProvider =
    ChangeNotifierProvider((ref) => SpeechToTextProvider());
