class TodoModel {
  final int? id;
  final String? title;
  final String? dateandtime;
  final DateTime? dueDateTime;

  // Konstruktor untuk inisialisasi instance TodoModel
  TodoModel({
    this.id,
    this.title,
    this.dateandtime,
    this.dueDateTime,
  });

  // Konstruktor untuk membuat instance TodoModel dari map
  TodoModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        dateandtime = res['dateandtime'],
        dueDateTime =
            DateTime.now(); // DateTime diinisialisasi dengan waktu saat ini

  // Mengonversi instance TodoModel ke dalam bentuk map untuk disimpan di database
  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "dateandtime": dateandtime,
    };
  }
}
