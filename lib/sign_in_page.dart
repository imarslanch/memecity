// import 'dart:io';
// import 'package:basics/main.dart';
// import 'package:basics/database_helper.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _name = '', _username = '', _email = '', _phoneNumber = '';
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   Future<void> _saveData() async {
//     final user = {
//       'id': 1,
//       'name': _name,
//       'username': _username,
//       'email': _email,
//       'phoneNumber': _phoneNumber,
//       'imagePath': _image?.path,
//     };
//     await DatabaseHelper().insertUser(user);
//   }

//   // void _showSnackBar(String message) {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content: Text(message),
//   //       backgroundColor: Colors.red,
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: const Text(
//             'Sign In',
//             style: TextStyle(
//                 color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 30),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListView(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: _pickImage,
//                     child: CircleAvatar(
//                       radius: 85,
//                       backgroundColor: Colors.grey,
//                       backgroundImage:
//                           _image != null ? FileImage(_image!) : null,
//                       child: _image == null
//                           ? const Icon(
//                               Icons.add_a_photo_outlined,
//                               size: 50,
//                               color: Colors.white,
//                             )
//                           : null,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       onTapOutside: (event) {
//                         FocusScope.of(context).requestFocus(FocusNode());
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Name',
//                         hintText: 'Enter full name ',
//                         hintStyle: const TextStyle(fontWeight: FontWeight.w200),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your name';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) => _name = value ?? '',
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       onTapOutside: (event) {
//                         FocusScope.of(context).requestFocus(FocusNode());
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Username',
//                         hintText: 'Enter UserName ',
//                         hintStyle: const TextStyle(fontWeight: FontWeight.w200),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your username';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) => _username = value ?? '',
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       onTapOutside: (event) {
//                         FocusScope.of(context).requestFocus(FocusNode());
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         hintText: 'Enter email address ',
//                         hintStyle: const TextStyle(fontWeight: FontWeight.w200),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your email';
//                         }
//                         return null;
//                       },
//                       keyboardType: TextInputType.emailAddress,
//                       onSaved: (value) => _email = value ?? '',
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       // onTapOutside: (event) {
//                       //   FocusScope.of(context).requestFocus(FocusNode());
//                       //    },
//                       decoration: InputDecoration(
//                           labelText: 'Phone Number',
//                           hintText: 'Enter Phone Number ',
//                           hintStyle:
//                               const TextStyle(fontWeight: FontWeight.w200),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           )),
//                       keyboardType: TextInputType.phone,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your Phone Number';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) => _phoneNumber = value ?? '',
//                     ),
//                   ),
//                   const SizedBox(height: 20.0),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         _formKey.currentState!.save();
//                         await _saveData();
//                         Get.to(() => const HomePage(
//                               name: '',
//                             ));
//                         // Navigator.pushReplacement(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => const HomePage(
//                         //       name: '',
//                         //     ),
//                         //   ),
//                         // );
//                       } else {
//                         // _showSnackBar('All fields are Required');
//                         Get.snackbar('Warning:', 'All fields are required',
//                             colorText: Colors.red);
//                       }
//                     },
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.teal),
//                     child: const Text(
//                       'Sign In',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:memecity/databases/database.dart';
import 'package:memecity/preferences_helper.dart';
import 'package:local_auth/local_auth.dart';
import 'package:memecity/main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'database_helper.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  final LocalAuthentication _auth = LocalAuthentication();
  final PreferencesHelper _prefs = PreferencesHelper();
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    bool isBiometricEnabled = await _prefs.isBiometricEnabled();

    if (isBiometricEnabled) {
      try {
        final bool didAuthenticate = await _auth.authenticate(
          localizedReason: 'Please authenticate to proceed',
          options: const AuthenticationOptions(
            biometricOnly: true,
            useErrorDialogs: true,
          ),
        );

        if (didAuthenticate) {
          setState(() {
            _isAuthenticated = true;
          });
        } else {
          setState(() {
            _isAuthenticated = false;
          });
        }
      } catch (e) {
        print('Authentication error: $e');
        setState(() {
          _isAuthenticated = false;
        });
      }
    } else {
      setState(() {
        _isAuthenticated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) {
      return const HomePage();
    } else {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: _checkAuthentication,
            child: const Text('Authenticate'),
          ),
        ),
      );
    }
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  File? _image;
  final _formKey = GlobalKey<FormState>();

  final DataService _dataService = DataService();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  Future<void> _saveUserInfo() async {
    await _dataService.preferencesService.saveUserInfo(
        _fullNameController.text,
        _usernameController.text,
        _emailController.text,
        _phoneNumberController.text,
        _passWordController.text,
        _countryController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User Info Saved'),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSnackBar1(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  bool _obscureText = true;
  void _togglePasswordVeiw() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfilePictureProvider>(context);
    final profilePicture =
        Provider.of<ProfilePictureProvider>(context).profilePicture;

    Future<void> _completeSignIn() async {
      // Mark as signed in
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSignedIn', true);

      // Navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Text(
          'Sign In',
          style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
                savetheme(isDarkMode);
              });
            },
            icon: Icon(
              isDarkMode
                  ? Icons.brightness_3_outlined
                  : Icons.brightness_7_outlined,
              color: isDarkMode ? Colors.white : Colors.amber,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await provider.updateProfilePicture();
                      _pickImage;
                    },
                    child: Center(
                        child: profilePicture != null
                            ? CircleAvatar(
                                radius: 85,
                                backgroundColor: Colors.grey,
                                backgroundImage: MemoryImage(profilePicture),
                                //  child:
                              )
                            : Text(
                                'Tap here to Select Image',
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 30),
                              )),
                  ) // const AssetImage('assets/image7.jpg'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _fullNameController,
                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    labelText: 'Name',
                    hintText: 'Enter full name ',
                    hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                  //onSaved: (value) => _fullName = value ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _usernameController,
                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    labelText: 'Username',
                    hintText: 'Enter UserName ',
                    hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length < 4) {
                      return 'Username must be 4 charecters';
                    }
                    return null;
                  },
                  //  onSaved: (value) => _username = value ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    labelText: 'Email',
                    hintText: 'Enter email address ',
                    hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  //   onSaved: (value) => _email = value ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _phoneNumberController,
                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      labelText: 'Phone Number',
                      hintText: 'Enter Phone Number ',
                      hintStyle: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w200),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Phone Number';
                    }
                    return null;
                  },
                  //     onSaved: (value) => _phoneNumber = value ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _countryController,
                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    labelText: 'Country',
                    hintText: 'Enter Country ',
                    hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  textCapitalization: TextCapitalization.words,
                  autocorrect: true,
                  enableSuggestions: true,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your Country';
                    }
                    return null;
                  },
                  //     onSaved: (value) => _phoneNumber = value ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passWordController,
                  obscureText: _obscureText,

                  onTapOutside: (event) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  showCursor: true,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    suffixIcon: IconButton(
                        onPressed: _togglePasswordVeiw,
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: isDarkMode ? Colors.white : Colors.black,
                        )),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w200),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length < 6) {
                      return 'Password must be 6 charecter long';
                    }

                    return null;
                  },
                  //   keyboardType: TextInputType.visiblePassword,
                  //     onSaved: (value) => _passWord = value ?? '',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print('Form is valid');
                    _formKey.currentState!.save();
                    await _saveUserInfo();
                    _completeSignIn();
                    _showSnackBar1('Information Saved');
                    //   _AuthenticationWrapperState();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else {
                    print('Form is invalid');
                    _showSnackBar('WARNING: All fields are required');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.white : Colors.teal,
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }
}
