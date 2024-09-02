import 'package:bytebrain_project_akhir/core/provider/tts_provider.dart';
import 'package:bytebrain_project_akhir/core/enums/chat_role.dart';
import 'package:bytebrain_project_akhir/core/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final user = message.role == ChatRole.user;

    return Column(
      crossAxisAlignment:
          user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!user)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _copyToClipboard(context, message.message);
                  },
                  child: const Icon(
                    Icons.copy,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  "Copy",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(6.0),
          constraints: const BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            color: user ? Colors.grey[300] : Colors.lightBlue[600],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(user ? 14.0 : 4.0),
              topRight: const Radius.circular(14.0),
              bottomLeft: const Radius.circular(14.0),
              bottomRight: Radius.circular(user ? 4.0 : 14.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              user
                  ? Text(
                      message.message,
                      style: TextStyle(
                        color: user ? Colors.black : Colors.white,
                        fontSize: 16.0,
                      ),
                    )
                  : SelectionArea(
                      child: MarkdownBody(
                        data: message.message,
                        selectable: true,
                        styleSheet:
                            MarkdownStyleSheet.fromTheme(Theme.of(context))
                                .copyWith(
                          p: const TextStyle(
                            color: Colors.white,
                          ),
                          a: const TextStyle(
                            color: Colors.deepPurple,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.deepPurple,
                          ),
                          listBullet: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTapLink: (text, href, title) {
                          launchUrl(Uri.parse(href!));
                        },
                      ),
                    ),
              if (!user)
                InkWell(
                  onTap: () => TTSProvider().speak(message.message),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Icon(
                      Icons.volume_up,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesan disalin ke clipboard'),
        backgroundColor: Color.fromARGB(255, 0, 166, 126),
      ),
    );
  }
}
