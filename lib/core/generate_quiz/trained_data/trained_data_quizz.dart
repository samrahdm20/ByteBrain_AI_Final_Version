import 'package:bytebrain_project_akhir/core/generate_quiz/gemini_api_call.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class QuestionsDataSource {
  // Konstruktor QuestionsDataSource menerima instance GeminiApi sebagai klien
  const QuestionsDataSource({
    required GeminiApi client,
  }) : _client = client;

  final GeminiApi
      _client; // Menyimpan instance GeminiApi untuk melakukan panggilan API

  // Fungsi untuk mengajukan pertanyaan berdasarkan subjek, level, bahasa, dan jumlah pertanyaan yang diminta
  Future<String?> askQuestions(String subject, String level, String language,
      int numberOfQuestions) async {
    // Membangun prompt yang akan dikirim ke API untuk menghasilkan pertanyaan kuis
    final prompt = '''
    You're a system that helps people prepare for job quiz games. Create another best list of questions that could help a person on $subject in $language.
    Give me $numberOfQuestions MCQs questions (4 options maximum per question but one option must be correct per questions, all in one block and no image in the questions) for $level level. 
    Provide your answer in the following JSON format: {"questions": [{"label":"", "answers":[{"label":"", "isCorrect":false},{"label":"", "isCorrect":true}]}]}. Generate all in one block
    Do not return the result as Markdown and do not include the format type (json) in your answer.
    
    ''';

    try {
      // Mengirim prompt ke Gemini API dan menunggu respon
      final response = await _client.generateContent(prompt);

      if (response == null) {
        debugPrint('null response'); // Log jika tidak ada respons dari API
        return null;
      }
      return response; // Mengembalikan respon jika berhasil
    } on GenerativeAIException catch (e) {
      // Menangani pengecualian yang terjadi saat menggunakan Generative AI
      debugPrint('GenerativeAIException: $e');
      return null;
    } catch (e) {
      // Menangani pengecualian umum lainnya
      debugPrint('Error: $e');
      return null;
    }
  }
}
