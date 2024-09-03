import 'package:bytebrain_project_akhir/presentation/notes_ui/home_screen_notes.dart';
import 'package:bytebrain_project_akhir/presentation/about_dev_ui/about_dev.dart';
import 'package:bytebrain_project_akhir/presentation/chat_with_image_ui/chat_with_image.dart';
import 'package:bytebrain_project_akhir/presentation/home_ui/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'quizz_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // kunci untuk scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // mengisi nilai awal form kuis
  final _formKey = GlobalKey<FormState>();
  String _subject = '';
  String _level = 'Beginner';
  int _numberOfQuestions = 1;
  String _language = 'Indonesian';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // kunci untuk scaffold
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 0, 166, 126),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/robot3.png'),
                radius: 19,
              ),
            ),
            const SizedBox(width: 13),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ByteBrain ✨',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Icon(Icons.brightness_1,
                        color: Colors.greenAccent, size: 10),
                    SizedBox(width: 5),
                    Text(
                      'Online',
                      style: TextStyle(
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
                        backgroundImage: AssetImage('assets/robot3.png'),
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
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const ChatImage();
                }));
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
                Navigator.pop(context);
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          'Isi formulir',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Topik Quiz',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          _subject = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Silahkan Masukkan Topik';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Pilih level',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _level = value!;
                          });
                        },
                        items: [
                          'Beginner',
                          'Intermediate',
                          'Professional',
                          'Expert'
                        ]
                            .map((level) => DropdownMenuItem(
                                  value: level,
                                  child: Text(level),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jumlah pertanyaan',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _numberOfQuestions = int.parse(value!);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Silakan masukkan nomor';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _language,
                        decoration: const InputDecoration(
                          labelText: 'Pilih Bahasa',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _language = value!;
                          });
                        },
                        items: [
                          'Indonesian',
                          'Arabic',
                          'Chinese',
                          'English',
                          'Français',
                          'German',
                          'Japanese',
                          'Korean',
                          'Malay',
                          'Spanish',
                        ]
                            .map((language) => DropdownMenuItem(
                                  value: language,
                                  child: Text(language),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizzScreen(
                            subject: _subject,
                            level: _level,
                            numberOfQuestions: _numberOfQuestions,
                            language: _language,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 166, 126),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Generate Quiz',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          'assets/robot3.png',
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

// social media icon setting and lauch
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
