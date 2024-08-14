import 'dart:io';

import 'package:memecity/change_password.dart';
import 'package:memecity/databases/database.dart';
import 'package:memecity/edit_info_screen.dart';
import 'package:memecity/notification_setting.dart';
import 'package:memecity/privacy_policy.dart';
import 'package:memecity/sign_in_page.dart';
// import 'package:basics/privacy_policy.dart';
// import 'package:basics/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
//import 'package:path/path.dart';

import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();
//final UserController userController = Get.find();

class Account extends StatelessWidget {
  const Account({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountScreen(),
    );
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
  });
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final DataService _dataService = DataService();
  String? _fullName;
  String? _username;
  String? _email;
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _loadUserinfo();
    _loadBiometricsPreference();
  }

  Future<void> _loadUserinfo() async {
    final userInfo = await _dataService.preferencesService.getUserInfo();
    setState(() {
      _fullName = userInfo['fullName'];
      _username = userInfo['username'];
      _email = userInfo['email'];
      _phoneNumber = userInfo['phoneNumber'];
    });
  }

  File? image;
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricsEnabled = false;

  Future<void> _loadBiometricsPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBiometricsEnabled = prefs.getBool('biometrics_enabled') ?? false;
    });
  }

  Future<void> _setBiometricsPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometrics_enabled', value);
  }

  Future<void> _authenticate() async {
    if (!_isBiometricsEnabled) return;

    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );

      if (!didAuthenticate) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication error')),
      );
    }
  }

  // final LocalAuthentication _localAuth = LocalAuthentication();
  // bool _isBiometricsEnabled = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadBiometricsPreference();
  // }

  // Future<void> _loadBiometricsPreference() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _isBiometricsEnabled = prefs.getBool('biometrics_enabled') ?? false;
  //   });
  // }

  // Future<void> _setBiometricsPreference(bool value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('biometrics_enabled', value);
  // }

  // Future<void> _authenticate() async {
  //   if (!_isBiometricsEnabled) return;

  //   try {
  //     final bool didAuthenticate = await _localAuth.authenticate(
  //       localizedReason: 'Please authenticate to access this feature',
  //       options: const AuthenticationOptions(
  //         biometricOnly: true,
  //         useErrorDialogs: true,
  //       ),
  //     );

  //     if (!didAuthenticate) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Authentication failed')),
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Authentication error')),
  //     );
  //   }
  // }
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
    // Define custom text styles
    TextStyle headerStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black87,
    );
    TextStyle subheaderStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: isDarkMode ? Colors.white : Colors.black54,
    );
    TextStyle optionStyle = TextStyle(
      fontSize: 16,
      color: isDarkMode ? Colors.white : Colors.black87,
    );
    final profilePicture =
        Provider.of<ProfilePictureProvider>(context).profilePicture;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            Row(
              children: [
                profilePicture != null
                    ? CircleAvatar(
                        radius: 50, backgroundImage: MemoryImage(profilePicture)
                        // : const AssetImage('assets/image7.jpg'),
                        )
                    : const Text('No Image'),
                // CircleAvatar(
                //   radius: 40,
                //   backgroundImage: image != null ? FileImage(image!) : null,
                //   child: image == null
                //       ? Text(
                //           name.isNotEmpty ? name[0] : '',
                //           style: const TextStyle(fontSize: 40.0),
                //         )
                //       : null, // Update with user profile image
                // ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_fullName',
                      style: headerStyle,
                    ),
                    Text(
                      '$_username', // Replace with dynamic user name
                      style: subheaderStyle,
                    ),
                    Text(
                      ' $_phoneNumber', // Replace with dynamic user name
                      style: subheaderStyle,
                    ),
                    Text(
                      '$_email',
                      style: subheaderStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            // Account Options
            ListTile(
              leading: Icon(
                Icons.person,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text('Edit Profile', style: optionStyle),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditInfoScreen()),
                );
                //    Get.to(() => const SignInPage());
                // Navigate to Edit Profile screen
              },
            ),
            ListTile(
              leading: Icon(
                Icons.security,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text('Change Password', style: optionStyle),
              onTap: () {
                Get.to(() => const ChangePasswordScreen());
                // Navigate to Change Password screen
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.person),
            //   title: const Text('Edit Profile', style: optionStyle),
            //   onTap: () {
            //     Get.to(() => const SignInPage());
            //     // Navigate to Edit Profile screen
            //   },
            // ),
            ListTile(
              leading: Icon(
                Icons.notifications,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text('Notifications Setting', style: optionStyle),
              onTap: () {
                Get.to(() => const NotificationSettingsScreen());
                // Navigate to Notifications settings
              },
            ),
            ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text('Privacy Setting', style: optionStyle),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()),
                );
                //   Get.to(() => const PrivacyPolicyScreen());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text('Help & Support', style: optionStyle),
              onTap: () {
                _launchDialer();
                //  _sendMail();
                // Navigate to Help & Support screen
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: Text('Switch Account', style: optionStyle),
              onTap: () {
                Restart.restartApp();
              },
            ),
            SwitchListTile(
                secondary: Icon(
                  Icons.fingerprint,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                title: Text('Biometric Authentication', style: optionStyle),
                value: _isBiometricsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isBiometricsEnabled = value;
                    _setBiometricsPreference(value);
                  });
                  if (value) {
                    _authenticate(); // Attempt authentication when enabling
                  }
                },
                thumbIcon: WidgetStatePropertyAll(
                  Icon(
                    _isBiometricsEnabled
                        ? Icons.fingerprint_outlined
                        : Icons.do_disturb_alt_outlined,
                    color: _isBiometricsEnabled ? Colors.blue : Colors.white,
                  ),
                ),
                activeColor: Colors.white,
                activeTrackColor:
                    isDarkMode ? Colors.white : Colors.teal.shade100),
          ],
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
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
//  void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

// void openEmailApp(BuildContext context) {
//   try {
//     AppAvailability.launchApp(
//             Platform.isIOS ? "message://" : "com.google.android.gm")
//         .then((_) {
//       print("App Email launched!");
//     }).catchError((err) {
      
//           _showSnackBar("App Email not found!");
//       print(err);
//     });
//   } catch (e) {
//     _showSnackBar("Email App not found!");
//   }
// }


// void _sendMail() async {
//   final Uri mail = Uri(
//       scheme: 'mailto:moontariq853@gmail.com',
//       );
//   if (await canLaunchUrl(mail)) {
//     await launchUrl(mail);
//   } else {
//     throw 'Could not launch $mail';
//   }
// }
