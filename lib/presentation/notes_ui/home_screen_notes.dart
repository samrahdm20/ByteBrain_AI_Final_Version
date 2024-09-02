import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bytebrain_project_akhir/core/notes/task_search.dart';
import 'package:bytebrain_project_akhir/presentation/notes_ui/add_update_screen.dart';
import 'package:bytebrain_project_akhir/core/notes/db_handler.dart';
import 'package:bytebrain_project_akhir/core/notes/model.dart';
import 'package:bytebrain_project_akhir/presentation/about_dev_ui/about_dev.dart';
import 'package:bytebrain_project_akhir/presentation/chat_with_image_ui/chat_with_image.dart';
import 'package:bytebrain_project_akhir/presentation/home_ui/ui/chat_screen.dart';
import 'package:bytebrain_project_akhir/presentation/generate_quiz_ui/home_screen_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenNotes extends StatefulWidget {
  const HomeScreenNotes({super.key});

  @override
  State<HomeScreenNotes> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenNotes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  DBHelper? dbHelper;
  late Future<List<TodoModel>> dataList;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
    initializeNotifications();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  loadData() async {
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 166, 126),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            color: Colors.white,
            onPressed: () async {
              final result = await showSearch(
                // ignore: use_build_context_synchronously
                context: context,
                delegate: TaskSearch(dataList: await dataList),
              );

              if (result != null) {
                final index =
                    (await dataList).indexWhere((todo) => todo.id == result.id);
                if (index != -1) {
                  _scrollController.animateTo(
                    index *
                        100.0, // Adjust this value based on your item height
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            onPressed: _openDrawer,
          ),
        ],
        title: const Row(
          children: [
            Text(
              'Catatan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(FontAwesomeIcons.paperPlane, color: Colors.white, size: 20),
          ],
        ),
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
                        'ByteBrain 🤖',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Binary Yet Technical Entity Brain',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    'Personal AI Assistant',
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
                Navigator.pop(context);
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<TodoModel>>(
              future: dataList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Gagal memuat data',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'Belum ada catatan...',
                          speed: const Duration(milliseconds: 45),
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 128, 123, 123)),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                      totalRepeatCount: 1,
                      displayFullTextOnTap: true,
                    ),
                  );
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      int todoId = snapshot.data![index].id!.toInt();
                      String todoTitle = snapshot.data![index].title.toString();
                      String todoDT =
                          snapshot.data![index].dateandtime.toString();
                      return Dismissible(
                        key: ValueKey<int>(todoId),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.redAccent,
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            dbHelper!.delete(todoId);
                            dataList = dbHelper!.getDataList();
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.lightBlue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    todoTitle,
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                                thickness: 0.8,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      todoDT,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                AddUpdateTask(
                                                  todoId: todoId,
                                                  todoTitle: todoTitle,
                                                  todoDT: todoDT,
                                                  update: true,
                                                )),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.edit_note,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUpdateTask(),
            ),
          );
        },
      ),
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
