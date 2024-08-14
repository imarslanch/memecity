import 'package:memecity/api_service.dart';
import 'package:memecity/chat_information_screen.dart';
import 'package:memecity/navigation_bar_screens/calling_screen.dart';
import 'package:memecity/navigation_bar_screens/home_screen.dart';
import 'package:memecity/navigation_bar_screens/vc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class ChatDetailScreen extends StatefulWidget {
  final Contact contact;

  const ChatDetailScreen({super.key, required this.contact});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  List<dynamic> messages = [];
  List<Contact> contacts = [];
  List<Post> posts = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  final TextEditingController _textController = TextEditingController();
  Future<void> fetchMessages() async {
    final fetchedMessages = await ApiService.fetchMessages(
        'user_phone_number', widget.contact.phones.first.number);
    setState(() {
      messages = fetchedMessages;
    });
  }

  void _addImagePost(String? imagePath) {
    setState(() {
      posts.add(Post(imagePath: imagePath));
    });
  }

  Future<void> _pickCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _addImagePost(pickedFile.path);
    }
  }

  Future<void> sendMessage(String content) async {
    final message = {
      'from': 'user_phone_number',
      'to': widget.contact.phones.first.number,
      'content': content,
    };
    await ApiService.sendMessage(message);
    setState(() {
      messages.add(message);
    });
    _controller.clear();
  }

  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launch(launchUri.toString());
  // }

  // void startChat(Contact contact) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ChatinfoScreen(contact: contact),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: TextButton(
            style: TextButton.styleFrom(iconColor: Colors.white),
            onPressed: () {
              Get.to(() => ChatinfoScreen(contact: Contact()));
            },
            child: Text(
              widget.contact.displayName ?? 'No Name',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          actions: [
            IconButton(
                iconSize: 30,
                icon: const Icon(
                  Icons.call_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to(() => const CallingScreen());
                }
                // =>
                // _makePhoneCall(widget.contact.phones.first.number),
                ),
            IconButton(
              iconSize: 30,
              onPressed: () {
                Get.to(() => const CameraScreen());
              },
              icon: const Icon(
                Icons.videocam_outlined,
                color: Colors.white,
              ),
            )
          ],
          backgroundColor: isDarkMode ? Colors.black : Colors.teal,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isSentByUser = message['from'] == 'user_phone_number';
                  return ListTile(
                    title: Align(
                      alignment: isSentByUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSentByUser ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['content'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _pickCamera();
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (text) => {setState(() {})},
                        controller: _controller,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          hintStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w200),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  _controller.text.isEmpty
                      ? IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.teal, iconSize: 30),
                          tooltip: 'Record Message',
                          onPressed: () {
                            // Get.snackbar('Nothing to post', 'Add Text');
                          },
                          icon: const Icon(
                            Icons.mic_none,
                            color: Colors.white,
                          ))
                      : IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.teal, iconSize: 30),
                          onPressed: () {
                            sendMessage(ApiService.baseUrl);
                            //  _addTextPost(_textController.text);
                            print(
                                "Send Button pressed with text: ${_textController.text}");
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ))
                ],
              ),
            ),
          ],
        ),
        backgroundColor: isDarkMode
            ? Colors.grey.shade800
            : const Color.fromARGB(255, 142, 197, 255));
  }
}
