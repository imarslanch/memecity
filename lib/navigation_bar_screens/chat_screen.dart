import 'package:memecity/chat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async {
    if (await _requestPermission(Permission.contacts)) {
      final contactList =
          await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        contacts = contactList;
      });
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  void startChat(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(contact: contact),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(contacts[index].displayName ?? 'No Name'),
                  onTap: () => startChat(contacts[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContactSelectionScreen(contacts: contacts)),
        ),
        child: const Icon(
          Icons.chat_bubble_outline,
          color: Colors.white,
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }
}

class ContactSelectionScreen extends StatelessWidget {
  final List<Contact> contacts;

  const ContactSelectionScreen({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Contact',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
      ),
      body: contacts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(contacts[index].displayName ?? 'No Name'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatDetailScreen(contact: contacts[index]),
                      ),
                    );
                  },
                );
              },
            ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }
}
