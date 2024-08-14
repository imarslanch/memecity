import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifications',
      home: NotificationList(),
    );
  }
}

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
//  final faker = Faker();
  late List<Map<String, dynamic>> notifications;

  List<Map<String, dynamic>> generateNotifications(int count) {
    return List.generate(
      count,
      (i) {
        if (i == 0) {
          // Customize the first notification
          return {
            'title': 'Tayyab Tariq',
            'subtitle': 'HELLO🙂',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 1) {
          // Customize the second notification
          return {
            'title': 'Hamza Tariq',
            'subtitle': 'Where are you?! 🤔',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 2) {
          // Customize third the notification
          return {
            'title': 'Missed call 📞 ',
            'subtitle': 'Ahsin Mehmood',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 3) {
          // Customize the  notification
          return {
            'title': 'Bhai ❤️',
            'subtitle': 'Helo',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 4) {
          // Customize the  notification
          return {
            'title': '❤️❤️',
            'subtitle': 'Call me when free 😘😘',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 5) {
          // Customize the  notification
          return {
            'title': 'Papa Jan❤️',
            'subtitle': 'photo:🖼️',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 6) {
          // Customize the second notification
          return {
            'title': 'Ahsin Mehmood',
            'subtitle': 'What about work??🤔 ',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 7) {
          // Customize the second notification
          return {
            'title': 'Misssed Call 📞',
            'subtitle': 'Tayyab Tariq',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 8) {
          // Customize the second notification
          return {
            'title': 'Qasim Tariq ',
            'subtitle': 'Chal Pubg kheley 🎮',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 9) {
          // Customize the second notification
          return {
            'title': 'Missed Call 📞',
            'subtitle': ' Papa Jan ❤️',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else if (i == 10) {
          // Customize the second notification
          return {
            'title': ' Best Friend👺 ',
            'subtitle': 'What about The Game 🎯',
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        } else {
          // Generate random notifications
          return {
            'title': faker.lorem.sentence(),
            'subtitle': faker.lorem.sentence(),
            'dateTime': DateTime.now()
                .subtract(Duration(days: faker.randomGenerator.integer(30))),
          };
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    notifications = generateNotifications(15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.01,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
              'No Notifications',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Slidable(
                  key: Key(notification['title']),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _removeNotification(index),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      notification['title'],
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification['subtitle'],
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm')
                              .format(notification['dateTime']),
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _removeAllNotifications,
        tooltip: 'Delete All Notifications',
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
        child: const Icon(
          Icons.delete_sweep,
          color: Colors.white,
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }

  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  void _removeAllNotifications() {
    setState(() {
      notifications.clear();
    });
  }
}




// class _NotificationListState extends State<NotificationList> {
//   List<Map<String, dynamic>> notifications = List.generate(
//     30,
//     (i) => {
//             'title': faker.lorem.sentence(),
//                   'subtitle': faker.lorem.sentence(),
//                         'dateTime': DateTime.now().subtract(Duration(days: faker.randomGenerator.integer(30))),
//                             },
//                               );
//     }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(
//           color: Colors.white,
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back_rounded),
//         ),
//         title: const Text(
//           'Notifications',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color.fromARGB(134, 0, 0, 0),
//         elevation: 0.01,
//       ),
//       body: notifications.isEmpty
//           ? const Center(child: Text('0 Notifications'))
//           : ListView.builder(
//               itemCount: notifications.length,
//               itemBuilder: (context, index) {
//                 final notification = notifications[index];
//                 return Slidable(
//                   key: Key(notification['title']),
//                   startActionPane: ActionPane(
//                     motion: const DrawerMotion(),
//                     children: [
//                       SlidableAction(
//                         onPressed: (context) => _removeNotification(index),
//                         backgroundColor: Colors.red,
//                         foregroundColor: Colors.white,
//                         icon: Icons.delete,
//                         label: 'Delete',
//                       ),
//                     ],
//                   ),
//                   child: ListTile(
//                     title: Text(notification['title']),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(notification['subtitle']),
//                         Text(
//                           DateFormat('yyyy-MM-dd – kk:mm')
//                               .format(notification['dateTime']),
//                           style:
//                               const TextStyle(fontSize: 12, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     isThreeLine: true,
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _removeAllNotifications,
//         tooltip: 'Delete All Notifications',
//         child: const Icon(Icons.delete_sweep),
//       ),
//     );
//   }

//   void _removeNotification(int index) {
//     setState(() {
//       notifications.removeAt(index);
//     });
//   }

//   void _removeAllNotifications() {
//     setState(() {
//       notifications.clear();
//     });
//   }
// }
  // List<String> notifications =
//       List<String>.generate(15, (i) => 'Notification ${i + 1}');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(
//           color: Colors.white,
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back_rounded),
//         ),
//         title: const Text(
//           'Notifications',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color.fromARGB(134, 0, 0, 0),
//         elevation: 0.01,
//       ),
//       body: notifications.isEmpty
//           ? const Center(
//               child: Text('No notifications',
//                   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)))
//           : ListView.builder(
//               itemCount: notifications.length,
//               itemBuilder: (context, index) {
//                 return Slidable(
//                   key: Key(notifications[index]),
//                   startActionPane: ActionPane(
//                     motion: const DrawerMotion(),
//                     children: [
//                       SlidableAction(
//                         onPressed: (context) => _removeNotification(index),
//                         backgroundColor: const Color.fromARGB(255, 255, 17, 0),
//                         foregroundColor: Colors.white,
//                         icon: Icons.delete,
//                       ),
//                     ],
//                   ),
//                   child: ListTile(
//                     title: Text(notifications[index]),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _removeAllNotifications,
//         tooltip: 'Delete All Notifications',
//         backgroundColor: Colors.blue,
//         child: const Icon(Icons.delete_sweep_outlined),
//       ),
//       backgroundColor: Colors.cyan,
//     );
//   }

//   void _removeNotification(int index) {
//     setState(() {
//       notifications.removeAt(index);
//     });
//   }

//   void _removeAllNotifications() {
//     setState(() {
//       notifications.clear();
//     });
//   }
// }
    



//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading: IconButton(
//             color: Colors.white,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_rounded),
//           ),
//           title: const Text(
//             'Notifications',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(134, 0, 0, 0),
//           elevation: 0.01,
//         ),
//         body: const Text(
//           'Notifications:',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 19,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.cyan,
//       ),
//     );
//   }
//  }
