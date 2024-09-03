import 'dart:io';
import 'package:bytebrain_project_akhir/presentation/about_dev_ui/about_dev.dart';
import 'package:bytebrain_project_akhir/presentation/chat_with_image_ui/api.dart';
import 'package:bytebrain_project_akhir/presentation/generate_quiz_ui/home_screen_quiz.dart';
import 'package:bytebrain_project_akhir/presentation/home_ui/ui/chat_screen.dart';
import 'package:bytebrain_project_akhir/presentation/notes_ui/home_screen_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatImage extends StatefulWidget {
  const ChatImage({super.key});

  @override
  State<ChatImage> createState() => _MainPageState();
}

class _MainPageState extends State<ChatImage> {
  // Kunci untuk Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Method untuk membuka drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  TextEditingController textEditingController = TextEditingController();
  String answer = ''; // Menyimpan jawaban dari AI
  XFile? image; // Menyimpan gambar yang diambil
  bool isLoading = false; // Menyimpan status awal loading
  bool isAIResponding = false; // Menyimpan status awal respons AI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey, // Kunci untuk Scaffold
        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/robot2.png'),
                  radius: 19,
                ),
              ),
              const SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ByteBrain ✨',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      if (!isAIResponding)
                        const Icon(
                          Icons.brightness_1,
                          color: Colors.greenAccent,
                          size: 10,
                        ),
                      if (!isAIResponding) const SizedBox(width: 5),
                      Text(
                        isAIResponding ? 'Sedang mengetik...' : 'Online',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 0, 166, 126),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: _openDrawer,
            ),
          ],
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 166, 126),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _bukaFotoProfilPengguna(context);
                      },
                      child: const Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/robot2.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'ByteBrain',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Your personal AI assistant',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.message,
                  size: 20,
                ),
                title: const Text('Chat'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const ChatScreen();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.fileImage,
                  size: 20,
                ),
                title: const Text('Chat with Image'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.filePdf,
                  size: 20,
                ),
                title: const Text('Chat with PDF'),
                onTap: () async {
                  const url = 'https://bytebrain-chatpdf.streamlit.app/';
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Tidak bisa dijalankan $url';
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.circleQuestion,
                  size: 20,
                ),
                title: const Text('Generate Quiz'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const FormScreen();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.paperPlane,
                  size: 20,
                ),
                title: const Text('Notes'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const HomeScreenNotes();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.dev,
                  size: 20,
                ),
                title: const Text('About Dev'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const AboutPop();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.gamepad,
                  size: 20,
                ),
                title: const Text('Education Games'),
                onTap: () {
                  _showEducationGame(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.icons,
                  size: 20,
                ),
                title: const Text('Connect with Us'),
                onTap: () {
                  _showSocialMediaDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.personThroughWindow,
                  size: 17,
                ),
                title: const Text('Exit'),
                onTap: () {
                  _konfirmasiKeluar(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/SMA Muhammadiyah Ambon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: image == null
                                ? Colors.grey.shade200
                                : null, // Warna latar belakang jika gambar tidak ada
                            borderRadius: BorderRadius.circular(10),
                            image: image != null
                                ? DecorationImage(
                                    image: FileImage(File(image!
                                        .path))) // Menampilkan gambar jika ada
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (answer.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: answer));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Teks disalin ke clipboard'),
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 166, 126),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          MarkdownBody(
                            data: answer,
                            selectable: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 15.0),
                  child: TextField(
                    controller: textEditingController,
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Tanyakan sesuatu...',
                      hintStyle: const TextStyle(color: Colors.black45),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 168, 212, 250),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        gapPadding: 0,
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8.0),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.gallery)
                              .then(
                            (value) {
                              setState(() {
                                image = value;
                              });
                            },
                          );
                        },
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Harap pilih gambar terlebih dahulu'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          setState(() {
                            isLoading = true;
                            isAIResponding = true;
                            answer = '';
                          });

                          debugPrint('Mengirim permintaan ke API...');
                          debugPrint('Teks: ${textEditingController.text}');
                          debugPrint('Gambar: ${image!.path}');

                          GenerativeModel model = GenerativeModel(
                              model: 'gemini-1.5-flash', apiKey: apiKey);

                          model.generateContent([
                            Content.multi([
                              TextPart(textEditingController.text),
                              DataPart('image/jpeg',
                                  File(image!.path).readAsBytesSync())
                            ])
                          ]).then((value) {
                            debugPrint('Menerima respons dari API:');
                            debugPrint(value.text.toString());

                            setState(() {
                              answer = value.text.toString();
                              isLoading = false;
                              isAIResponding = false;
                            });
                          }).catchError((error) {
                            debugPrint('Terjadi kesalahan: $error');
                            setState(() {
                              isLoading = false;
                              isAIResponding = false;
                            });
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isLoading)
              Positioned.fill(
                child: Center(
                  child: Lottie.asset(
                    'assets/animation/loadingImage.json',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
          ],
        ));
  }

  // method buka foto profile
  void _bukaFotoProfilPengguna(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'ByteBrain',
            textAlign: TextAlign.center,
          ),
          content: Image.asset(
            'assets/robot2.png',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  // method buka education games
  void _showEducationGame(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Education Games'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildGameButton(
                  'Math true or false',
                  'https://chairil13.github.io/Math-game/',
                  FontAwesomeIcons.calculator,
                ),
                _buildGameButton(
                  'Memory Game',
                  'https://chairil13.github.io/Memory-game/',
                  FontAwesomeIcons.brain,
                ),
                _buildGameButton(
                  "Rubik's Cube",
                  'https://chairil13.github.io/rubic-cube/',
                  FontAwesomeIcons.cube,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  // method tombol game
  Widget _buildGameButton(String label, String url, IconData icon) {
    return ElevatedButton(
      onPressed: () async {
        Uri uri = Uri.parse(url);
        if (!await launchUrl(uri)) {
          throw Exception('Tidak bisa dijalankan $url');
        }
      },
      child: Row(
        children: [
          FaIcon(icon),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  // method buka connect with us
  void _showSocialMediaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text('Connect with SMA Muhammadiyah Ambon',
                textAlign: TextAlign.center),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildSocialMediaButton(
                  'WhatsApp',
                  'https://api.whatsapp.com/send?phone=+6282290815896&text=Assalamualaikum',
                  FontAwesomeIcons.whatsapp,
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildSocialMediaButton(
                    'Map',
                    'https://maps.app.goo.gl/hWQJ4TwThJ7CuYFi7',
                    FontAwesomeIcons.map),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Connect with Chairil',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildSocialMediaButton(
                  'WhatsApp',
                  'https://api.whatsapp.com/send?phone=+6282238482847&text=Hello,%20Chairil%20Ali',
                  FontAwesomeIcons.whatsapp,
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildSocialMediaButton(
                    'Instagram',
                    'https://www.instagram.com/chairilali_13?igsh=MTYwczBkbG53c251cg==',
                    FontAwesomeIcons.instagram),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Connect with Samrah',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildSocialMediaButton(
                  'WhatsApp',
                  'https://api.whatsapp.com/send?phone=+6282213160067&text=Hello,%20Samrah',
                  FontAwesomeIcons.whatsapp,
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildSocialMediaButton(
                    'Instagram',
                    'https://www.instagram.com/samrahdm?igsh=azloOXR2dG01ZzJy',
                    FontAwesomeIcons.instagram),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  // method tombol sosial media
  Widget _buildSocialMediaButton(String label, String url, IconData icon) {
    return ElevatedButton(
      onPressed: () async {
        Uri uri = Uri.parse(url);
        if (!await launchUrl(uri)) {
          throw Exception('Tidak bisa dijalankan $url');
        }
      },
      child: Row(
        children: [
          FaIcon(icon),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  // method konfirmasi keluar
  void _konfirmasiKeluar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Apakah Anda yakin ingin keluar?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }
}
