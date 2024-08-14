// import 'package:basics/database_helper.dart';
// import 'package:basics/main.dart';
// import 'package:basics/sign_in_page.dart';
// import 'package:flutter/material.dart';
//
// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen> {
// //   final PreferencesHelper _prefs = PreferencesHelper();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _checkInitialScreens();
// //   }

// //   Future<void> _checkInitialScreens() async {
// //     bool splashShown = await _prefs.isSplashShown();
// //     bool signInShown = await _prefs.isSignInShown();

// //     if (!splashShown) {
// //       // Show splash screen
// //       await _prefs.setSplashShown(true);

// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => const SignInPage()),
// //       );
// //     } else if (!signInShown) {
// //       // Show sign-in page
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => const SignInPage()),
// //       );
// //     } else {
// //       // Show home page
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //             builder: (context) => const HomePage(
// //                   name: '',
// //                 )),
// //       );
// //     }
// //   }

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Initializer(),
//     );
//   }
// }

// class Initializer extends StatefulWidget {
//   const Initializer({super.key});

//   @override
//   State<Initializer> createState() => _InitializerState();
// }

// class _InitializerState extends State<Initializer> {
//   bool _isFirstTime = true;
//   @override
//   void initState() {
//     super.initState();
//     _navigateToSigninPage();
//   }

//   Future<void> checkFirstTime() async {
//     final user = await DatabaseHelper().getUser();
//     setState(() {
//       _isFirstTime = user == null;
//     });
//   }

//   void state() {
//     super.initState();
//     checkFirstTime();
//   }

//   _navigateToSigninPage() async {
//     await Future.delayed(const Duration(seconds: 3), () {});
//     if (_isFirstTime) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const SignInPage(),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomePage(
//           ),
//         ),
//       );
//     }

//     // @override
//     // Widget build(BuildContext context) {
//     //   if () {
//     //     return const SignInPage();
//     //   }
//     // }
//   }
// splash_screen.dart

import 'package:memecity/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_storage/get_storage.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    final prefs = await SharedPreferences.getInstance();
    final bool isSignedIn = prefs.getBool('isSignedIn') ?? false;

    // Navigate to the appropriate screen based on sign-in status
    if (isSignedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthenticationWrapper()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/logo_image.jpg',
              cacheWidth: 700,
              matchTextDirection: true,
            ),
          ),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.white : Colors.white,
    );
  }
}
