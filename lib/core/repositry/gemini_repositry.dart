abstract class GeminiChatRepositry {
  // Methode abstrak untuk mendapatkan respons dari Bard (Gemini AI)
  Future<Map<String, dynamic>> getBardResponse(
      List<Map<String, dynamic>> contents);
}
