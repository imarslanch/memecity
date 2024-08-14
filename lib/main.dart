import 'dart:io';
import 'package:memecity/archive_screen.dart';
import 'package:memecity/databases/database.dart';
import 'package:memecity/navigation_bar_screens/calls_screen.dart';
import 'package:memecity/navigation_bar_screens/chat_screen.dart';
import 'package:memecity/navigation_bar_screens/home_screen.dart';
import 'package:memecity/navigation_bar_screens/profile_screen.dart';
import 'package:memecity/notification_screen.dart';
import 'package:memecity/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:memecity/Language.dart';
import 'package:memecity/account.dart';
import 'package:memecity/privacy_policy.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  await GetStorage.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProfilePictureProvider()),
  ], child: const MyApp()));
}

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //    routes: {
      //   'profilescreen': (context) => const ProfileScreen(),
      //   '/signinpage': (context) => const SignInPage(),
      //   '/chatscreen': (context) => const ChatScreen(),
      //   '/selectNumber': (context) => const SelectNumberScreen(),
      //   },
    );
  }
}

// class IconController extends GetxController {
//   var isSunny = true.obs;
//   void toggleIcon() {
//     isSunny.value = !isSunny.value;
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService _dataService = DataService();

  // late GoogleMapController mapsController;
  String? _fullName;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserinfo();
  }

  Future<void> _loadUserinfo() async {
    final userInfo = await _dataService.preferencesService.getUserInfo();
    setState(() {
      _fullName = userInfo['fullName'];
      _email = userInfo['email'];
    });
  }

  File? image;
  int _selectedIndex = 0;
  List<Post> posts = [];
  List<Post> archivedPosts = [];
  final List<Widget> _widgetOptions = <Widget>[
    const PostScreen(),
    const ChatScreen(),
    const CallScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Future<void> _requestPermissions() async {
  //   await Permission.camera.request();
  //   await Permission.microphone.request();
  // }

  void _unarchivePost(Post post) {
    setState(() {
      archivedPosts.remove(post);
      posts.add(post);
    });
  }

  // final IconController iconController = Get.put(IconController());
  bool isDarkMode = loadTheme();
  // final UserController userController = Get.find();

  // @override
  // void initState() {
  //   super.initState();
  //   _loadData();
  // }

  // Future<void> _loadData() async {
  //   final user = await DatabaseHelper().getUser();
  //   if (user != null) {
  //     setState(() {
  //       name = user['name'];
  //       username = user['username'];
  //       email = user['email'];
  //       phoneNumber = user['phoneNumber'];
  //       String? imagePath = user['imagePath'];
  //       if (imagePath != null) {
  //         image = File(imagePath);
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final profilePicture =
        Provider.of<ProfilePictureProvider>(context).profilePicture;
    var isDarkMode = loadTheme();
    return GetMaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            [
              'MemeCity',
              'Chats',
              'Calls',
              'Profile',
            ][_selectedIndex],
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.teal,
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          elevation: 0.01,
          iconTheme: IconThemeData(
            color: isDarkMode ? Colors.white : Colors.teal,
          ),
          toolbarHeight: 100,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_outlined,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 30,
              ),
            ),
          ],
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
        ),
        drawer: Drawer(
          backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  ' $_fullName',
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                accountEmail: Text(
                  ' $_email',
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.teal,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black54 : Colors.white,
                ),
                currentAccountPicture: profilePicture != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(profilePicture))
                    : const Text('No Image'),
                // CircleAvatar(
                //   backgroundColor: isDarkMode ? Colors.white : Colors.teal,
                //   backgroundImage: image != null ? FileImage(image!) : null,
                //   child: image == null
                //       ? Text(
                //           name.isNotEmpty ? name[0] : '',
                //           style: const TextStyle(fontSize: 40.0),
                //         )
                //       : null,
                // ),
                margin: const EdgeInsets.only(bottom: 10),
              ),
              // const DrawerHeader(
              //   child: Row(
              //     children: [
              //       CircleAvatar(
              //         foregroundImage: AssetImage('assets/image7.jpg'),
              //         radius: 30,
              //         // icon: const Icon(Icons.person,
              //         //     size: 60, color: Colors.white),
              //         // onPressed: () {
              //         //   Get.snackbar('M Arslan Tariq',
              //         //       '+923198229759' ' example@gmail.com',
              //         //       backgroundColor: Colors.white,
              //         //       colorText: Colors.black);
              //         // },
              //       ),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Text(
              //             'M Arslan Tariq',
              //             style: TextStyle(
              //                 color: Colors.teal,
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w700),
              //           ),
              //           Text(
              //             '+923198229759',
              //             style: TextStyle(
              //                 color: Colors.teal,
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w700),
              //           ),
              //           Text(
              //             'moontariq@gmail.com',
              //             style: TextStyle(
              //                 color: Colors.teal,
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.w700),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text(
                  'Account',
                ),
                onTap: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Account()),
                  // );
                  Get.to(
                    () => const Account(),
                  );
                  //  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications_none_outlined),
                title: const Text('Notifications'),
                onTap: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const NotificationScreen()),
                  // );
                  Get.to(() => const NotificationScreen());
                },
              ),
              SwitchListTile(
                secondary: Icon(
                  isDarkMode
                      ? Icons.brightness_3_outlined
                      : Icons.brightness_7_outlined,
                  color: isDarkMode ? Colors.white : Colors.amber,
                  // themeController.isDarkTheme.value
                  //     ? Icons.wb_sunny
                  //     : Icons.nightlight_round_outlined,
                ),
                title: const Text('Change Theme'),

                value: isDarkMode,
                onChanged: (bool value) {
                  setState(() {
                    isDarkMode = value;
                    savetheme(isDarkMode);
                  });
                },
                thumbIcon: WidgetStatePropertyAll(Icon(isDarkMode
                    ? Icons.brightness_3_outlined
                    : Icons.brightness_7_rounded)),
                inactiveThumbColor: Colors.blue,

                // Get.changeTheme(
                //     Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                // iconController.toggleIcon();
              ),

              ListTile(
                leading: const Icon(Icons.archive_outlined),
                title: const Text('Archive'),
                onTap: () {
                  Get.to(() => ArchiveScreen(
                        posts: archivedPosts,
                        onUnarchive: _unarchivePost,
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: const Text('Language'),
                onTap: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => LanguageScreen()),
                  // );
                  Get.to(() => const LanguageScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: const Text('Contact Us'),
                onTap: () {
                  _launchDialer();
                },
                onLongPress: () {
                  Get.snackbar(
                    'For Help',
                    '+923198229759',
                    backgroundColor: isDarkMode ? Colors.black : Colors.white,
                    colorText: isDarkMode ? Colors.white : Colors.black,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.padding_outlined),
                title: const Text('Privacy Policy'),
                onTap: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PrivacyPolicyScreen()),
                  // );
                  Get.to(() => const PrivacyPolicyScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  // Access the provider here
                  final profilePictureProvider =
                      Provider.of<ProfilePictureProvider>(context,
                          listen: false);

                  await profilePictureProvider.deleteProfilePicture();

                  Restart.restartApp();
                },
              ),
              ListTile(
                title: const Text('Developer: Muhammad Arslan Tariq'),
                onTap: () {
                  Get.snackbar(
                    'Developer:',
                    'Muhammad Arslan Tariq',
                    backgroundColor: isDarkMode ? Colors.black : Colors.white,
                    colorText: isDarkMode ? Colors.white : Colors.black,
                  );
                },
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chats'),
            BottomNavigationBarItem(
                icon: Icon(Icons.phone_outlined), label: 'Calls'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'profile')
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: isDarkMode ? Colors.white : Colors.teal,
          onTap: _onItemTapped,
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          elevation: 0.01,
          unselectedItemColor: isDarkMode ? Colors.white38 : Colors.black,
          unselectedIconTheme: IconThemeData(
            color: isDarkMode ? Colors.white38 : Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            color: isDarkMode ? Colors.white38 : Colors.black,
          ),
          showUnselectedLabels: true,
          enableFeedback: true,
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

void _launchDialer() async {
  final Uri phoneNumber = Uri(scheme: 'tel', path: '+923198229759');
  if (await canLaunchUrl(phoneNumber)) {
    await launchUrl(phoneNumber);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}
