import 'package:memecity/account.dart';
import 'package:memecity/api_service.dart';
import 'package:memecity/media_link_doc_screen.dart';
import 'package:memecity/navigation_bar_screens/calling_screen.dart';
import 'package:memecity/navigation_bar_screens/home_screen.dart';
import 'package:memecity/navigation_bar_screens/vc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class ChatinfoScreen extends StatefulWidget {
  final Contact contact;

  const ChatinfoScreen({
    super.key,
    required this.contact,
  });

  @override
  State<ChatinfoScreen> createState() => _ChatinfoScreenState();
}

class _ChatinfoScreenState extends State<ChatinfoScreen> {
  List<dynamic> messages = [];
  List<Post> posts = [];
  //final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  //final TextEditingController _textController = TextEditingController();
  Future<void> fetchMessages() async {
    final fetchedMessages = await ApiService.fetchMessages(
        'user_phone_number', widget.contact.phones.first.number);
    setState(() {
      messages = fetchedMessages;
    });
  }

  // Future<void> sendMessage(String content) async {
  //   final message = {
  //     'from': 'user_phone_number',
  //     'to': widget.contact.phones.first.number,
  //     'content': content,
  //   };
  //   await ApiService.sendMessage(message);
  //   setState(() {
  //     messages.add(message);
  //   });
  //   _controller.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDarkMode ? Colors.white : Colors.teal,
          ),
        ),
        title: Text(
          widget.contact.displayName ?? 'No Name',
          style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.call_outlined,
              color: isDarkMode ? Colors.white : Colors.teal,
            ),
            onPressed: () {
              Get.to(() => const CallingScreen());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.videocam_outlined,
              color: isDarkMode ? Colors.white : Colors.teal,
            ),
            onPressed: () {
              Get.to(() => const CameraScreen());
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // Profile section
          ListTile(
            leading: const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/image7.jpg'), // Change to your asset
              radius: 30,
            ),
            title: const Text(''),
            subtitle: const Text('🥺حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ '),
            trailing: IconButton(
              icon: const FaIcon(FontAwesomeIcons.addressCard),
              onPressed: () {},
            ),
          ),
          const Divider(),
          // Media, Links, and Docs
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.photoFilm),
            title: const Text('Media, Links, and Docs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MediaLinksDocsScreen()),
              );
            },
          ),
          const Divider(),
          // Group Info
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.users),
            title: const Text('Group Info'),
            onTap: () {},
          ),
          const Divider(),
          // Custom section
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.bell),
            title: const Text('Custom Notifications'),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.gear),
            title: const Text('Settings'),
            onTap: () {
              Get.to(() => const Account());
            },
          ),
        ],
      ),
    );
  }
}
