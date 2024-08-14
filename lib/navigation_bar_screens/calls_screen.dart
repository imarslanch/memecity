// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';

// class ContactScreen extends StatefulWidget {
//   const ContactScreen({super.key});

//   @override
//   _ContactScreenState createState() => _ContactScreenState();
// }

// class _ContactScreenState extends State<ContactScreen> {
//   List<dynamic> contacts = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchContacts();
//   }

//   Future<void> fetchContacts() async {
//     final response =
//         await http.get(Uri.parse('http://localhost:3000/contacts'));
//     if (response.statusCode == 200) {
//       setState(() {
//         contacts = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load contacts');
//     }
//   }

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launch(launchUri.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: contacts.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 final contact = contacts[index];
//                 return ListTile(
//                   title: Text(contact['name'] ?? 'No Name'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(contact['phoneNumber'] ?? 'No Phone Number'),
//                       if (contact['recentCalls'] != null)
//                         ...contact['recentCalls']
//                             .map<Widget>((call) => Text(
//                                   'Called at: ${DateTime.parse(call).toLocal()}',
//                                   style: const TextStyle(
//                                       color: Colors.grey, fontSize: 12),
//                                 ))
//                             .toList(),
//                     ],
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.call),
//                     onPressed: () => _makePhoneCall(contact['phoneNumber']),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:memecity/navigation_bar_screens/calling_screen.dart';
import 'package:flutter/material.dart';
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

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CallTabs(),
    );
  }
}

class CallTabs extends StatelessWidget {
  const CallTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {},
                  isSelected: true,
                  enableFeedback: true,
                  highlightColor: Colors.white24,
                  tooltip: 'Add to Favourites',
                  disabledColor: Colors.green,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green),
                  ),
                ),
                const SizedBox(
                  width: 1,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Add to Favourites',
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Recent',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CallLogEntry(
              name: 'Bhai ❤️😍',
              time: ' ↗️ Today, 4:54 pm',
              callType: CallType.outgoing,
              callCount: 6,
            ),
            const CallLogEntry(
              name: 'Bhai ❤️😍',
              time: '↙️ Today, 4:07 pm',
              callType: CallType.incoming,
              callCount: 7,
            ),
          ],
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }
}

class CallLogEntry extends StatelessWidget {
  final String name;
  final String time;
  final CallType callType;
  final int? callCount;

  const CallLogEntry({
    super.key,
    required this.name,
    required this.time,
    required this.callType,
    this.callCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        foregroundImage: AssetImage('assets/image7.jpg'),
        radius: 20,
      ),
      title: Text(
        '$name${callCount != null ? ' ($callCount)' : ''}',
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        time,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      onTap: () {},
      selected: true,
      trailing: Stack(
        children: [
          IconButton(
            icon: Icon(
              callType == CallType.outgoing
                  ? Icons.phone_callback_outlined
                  : Icons.phone_forwarded_outlined,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Get.to(() => const CallingScreen());
            },
          ),
        ],
      ),
    );
  }
}

enum CallType { incoming, outgoing }











// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CallScreen extends StatelessWidget {
//   const CallScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'CallScreen',
//       home: CallTabs(),
//     );
//   }
// }

// class CallTabs extends StatefulWidget {
//   const CallTabs({super.key});

//   @override
//   State<CallTabs> createState() => _CallTabs();
// }

// class _CallTabs extends State<CallTabs> {
//   late List<Map<String, dynamic>> calltabs;

//   List<Map<String, dynamic>> generateCallTabs(int count) {
//     return List.generate(count, (i) {
//       if (i == 0) {
//         // Customize the first notification
//         return {
//           'title': 'Tayyab Tariq',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 1) {
//         // Customize the second notification
//         return {
//           'title': 'Hamza Tariq',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 2) {
//         // Customize third the notification
//         return {
//           'title': 'Missed call 📞 ',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 3) {
//         // Customize the  notification
//         return {
//           'title': 'Bhai ❤️',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 4) {
//         // Customize the  notification
//         return {
//           'title': '❤️❤️',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 5) {
//         // Customize the  notification
//         return {
//           'title': 'Papa Jan❤️',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 6) {
//         // Customize the second notification
//         return {
//           'title': 'Ahsin Mehmood🤞',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 7) {
//         // Customize the second notification
//         return {
//           'title': 'Misssed Call 📞',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 8) {
//         // Customize the second notification
//         return {
//           'title': 'Qasim Tariq ',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 9) {
//         // Customize the second notification
//         return {
//           'title': 'Missed Call 📞 ',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else if (i == 10) {
//         // Customize the second notification
//         return {
//           'title': ' Best Friend👺 ',
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30))),
//         };
//       } else {
//         // Generate random notifications
//         return {
//           'title': faker.lorem.sentence(),
//           'dateTime': DateTime.now()
//               .subtract(Duration(days: faker.randomGenerator.integer(30)))
//         };
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     calltabs = generateCallTabs(11);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: calltabs.isEmpty
//           ? const Center(child: Text('NO Notifications'))
//           : ListView.builder(
//               itemCount: calltabs.length,
//               itemBuilder: (context, index) {
//                 final notification = calltabs[index];
//                 return ListTile(
//                   title: Text(notification['title']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         DateFormat('yyyy-MM-dd – kk:mm')
//                             .format(notification['dateTime']),
//                         style:
//                             const TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _removeAllcalltabs,
//         tooltip: 'Delete All Notifications',
//         child: const Icon(Icons.call),
//       ),
//     );
//   }

//   // void _removeNotification(int index) {
//   //   setState(() {
//   //     // notifications.removeAt(index);
//   //   });
//   // }

//   void _removeAllcalltabs() {
//     setState(() {
//       calltabs.clear();
//     });
//   }
// }
