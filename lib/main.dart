import 'package:bytebrain_project_akhir/core/application.dart';
import 'package:bytebrain_project_akhir/core/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // Memuat konfigurasi dari file .env dan menjalankan aplikasi
  await dotenv.load(fileName: ".env");
  runApp(const Injector(child: MainApp()));
}
