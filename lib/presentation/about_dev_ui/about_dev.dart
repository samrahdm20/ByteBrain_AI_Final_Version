import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bytebrain_project_akhir/presentation/notes_ui/home_screen_notes.dart';
import 'package:bytebrain_project_akhir/presentation/chat_with_image_ui/chat_with_image.dart';
import 'package:bytebrain_project_akhir/presentation/home_ui/ui/chat_screen.dart';
import 'package:bytebrain_project_akhir/presentation/generate_quiz_ui/home_screen_quiz.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPop extends StatefulWidget {
  const AboutPop({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationPopState createState() => _NavigationPopState();
}

class _NavigationPopState extends State<AboutPop> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Method untuk membuka drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  // status awal foto profile saat nanti diperluas
  bool isProfileExpanded = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 166, 126),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            onPressed: _openDrawer,
          ),
        ],
        title: const Row(
          children: [
            Text(
              'About',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(FontAwesomeIcons.dev, color: Colors.white, size: 25),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 166, 126),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Chairil & Samrah',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.laptopCode,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Mobile Dev',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    'Ambon, Maluku, Indonesia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
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
                Navigator.pop(context);
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
            const SizedBox(
              height: 2,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        isHovered = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        isHovered = false;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isProfileExpanded = !isProfileExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          width: isProfileExpanded ? 200.0 : 100.0,
                          height: isProfileExpanded ? 200.0 : 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                isProfileExpanded ? 34.0 : 100.0),
                            border: Border.all(
                              color: Colors.blue,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              isProfileExpanded ? 30.0 : 100.0,
                            ),
                            child: Image.asset(
                              'assets/profile.png',
                              width: isProfileExpanded ? 200.0 : 100.0,
                              height: isProfileExpanded ? 200.0 : 100.0,
                              fit: BoxFit.cover,
                              color: isHovered ? Colors.grey : null,
                              colorBlendMode: BlendMode.saturation,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chairil Ali,\nSamrah Daeng Makase',
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Mobile',
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            FontAwesomeIcons.dev,
                            color: Color.fromARGB(255, 0, 166, 126),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'All about "widget"',
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Hai, perkenalkan kami adalah developer dari aplikasi ByteBrain AI, Chairil Ali dan Samrah Daeng Makase. Passion kami yaitu sebagai Mobile Developer, khususnya menggunakan framework Flutter. Untuk melihat tutorial penggunaan aplikasi ini, bisa klik icon Youtube di pojok kiri bawah :)\n\nJika punya pertanyaan, request fitur, bug, error, atau mau kerjasama, silahkan hubungi kami melalui menu connect with us. Sekian dan terima gaji :)',
                              speed: const Duration(milliseconds: 45),
                              textStyle: const TextStyle(fontSize: 15),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                          totalRepeatCount: 1,
                          displayFullTextOnTap: true,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: () async {
                  const url =
                      'https://youtu.be/h1gQDAaTd44?si=5HFXjuykYqLczVdM';
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    throw 'Tidak bisa dijalankan $url';
                  }
                },
                child: Lottie.asset(
                  'assets/animation/youtube.json',
                  height: 95,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // methode untuk konfirmasi keluar
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

  // methode untuk connect with us
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
                  'https://api.whatsapp.com/send?phone=+62 82290815896&text=Assalamualaikum',
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

  // method untuk education games
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

  // method untuk tombol game
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

  // methode untuk tombol sosial media
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
}
