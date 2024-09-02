import 'package:bytebrain_project_akhir/core/provider/message_provider.dart';
import 'package:bytebrain_project_akhir/presentation/notes_ui/home_screen_notes.dart';
import 'package:bytebrain_project_akhir/presentation/about_dev_ui/about_dev.dart';
import 'package:bytebrain_project_akhir/presentation/chat_with_image_ui/chat_with_image.dart';
import 'package:bytebrain_project_akhir/presentation/home_ui/ui/chat_bubble.dart';
import 'package:bytebrain_project_akhir/presentation/home_ui/ui/write_message_textfield.dart';
import 'package:bytebrain_project_akhir/presentation/generate_quiz_ui/home_screen_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showScrollToBottomButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        title: Consumer(
          builder: (context, ref, child) {
            final isTyping = ref.watch(messagesProvider).isTyping;
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/robot1.png'),
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
                    const SizedBox(
                      height: 2,
                    ),
                    if (isTyping)
                      const Text(
                        'Sedang mengetik...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )
                    else
                      const Row(
                        children: [
                          Icon(
                            Icons.brightness_1,
                            color: Colors.greenAccent,
                            size: 10,
                          ),
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
            );
          },
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
                        backgroundImage: AssetImage('assets/robot1.png'),
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.fileImage,
                size: 20,
              ),
              title: const Text('Chat with Image'),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ChatImage(),
                ));
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
                _konfirmasiKeluar(context); // Panggil fungsi konfirmasi keluar
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
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      setState(() {
                        if (scrollNotification.metrics.maxScrollExtent == 0) {
                          // Semua pesan muat dalam satu layar
                          _showScrollToBottomButton = false;
                        } else {
                          _showScrollToBottomButton = scrollNotification
                                  .metrics.pixels <=
                              scrollNotification.metrics.maxScrollExtent - 1;
                        }
                      });
                    }
                    return true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Consumer(builder: (context, ref, child) {
                      final messages = ref.watch(messagesProvider).messages;
                      return ListView.builder(
                          controller:
                              ref.read(messagesProvider).scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return ChatBubble(message: messages[index]);
                          });
                    }),
                  ),
                ),
              ),
              const WriteMessageTextField(),
            ],
          ),
          if (_showScrollToBottomButton)
            Positioned(
              right: 16,
              bottom: 80,
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  ref.read(messagesProvider).scrollToBottom();
                },
                child: const Icon(Icons.arrow_downward),
              ),
            ),
        ],
      ),
    );
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
            'assets/robot1.png',
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
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                SystemNavigator.pop(); // Keluar dari aplikasi
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

// Game icon setting and lauch
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
}
