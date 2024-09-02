import 'package:bytebrain_project_akhir/core/notes/model.dart';
import 'package:flutter/material.dart';

class TaskSearch extends SearchDelegate<TodoModel> {
  List<TodoModel> dataList; // Daftar data TodoModel untuk pencarian

  TaskSearch(
      {required this.dataList}); // Konstruktor untuk inisialisasi daftar data

  @override
  List<Widget> buildActions(BuildContext context) {
    // Menampilkan ikon untuk membersihkan query pencarian
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Mengosongkan query pencarian
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Menampilkan ikon kembali
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.black,
      onPressed: () {
        close(context,
            TodoModel()); // Menutup pencarian dan mengembalikan model kosong
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Mencari hasil berdasarkan query dan menampilkan hasil pencarian
    List<TodoModel> searchResults = dataList
        .where(
            (task) => task.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length, // Jumlah item hasil pencarian
      itemBuilder: (context, index) {
        TodoModel task = searchResults[index];

        return ListTile(
          title: Text(task.title!), // Menampilkan judul
          onTap: () {
            close(context,
                task); // Menutup pencarian dan mengembalikan item yang dipilih
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Menampilkan saran berdasarkan query pencarian
    return buildResults(context);
  }
}
