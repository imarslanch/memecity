import 'package:memecity/databases/database.dart';
import 'package:memecity/edit_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class ProfileScreen extends StatelessWidget {
  // final String name, username, email, phoneNumber;
  // final File? image;

  const ProfileScreen({
    super.key,
    // required this.name,
    // required this.username,
    // required this.email,
    // required this.phoneNumber,
    // this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ProfileForm(),
      // Column(
      //   children: [
      //     Center(
      //       child: CircleAvatar(
      //         foregroundImage: AssetImage('assets/image1.jpg'),
      //         radius: 100,
      //       ),
      //     ),
      //     Text(
      //       'Full Name:',
      //       style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      //     ),
      //     Text(
      //       'Muhammad Arslan Tariq',
      //       style: TextStyle(fontSize: 15),
      //     ),
      //     Text(
      //       'Username:',
      //       style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      //     ),
      //     Text(
      //       '@im_arslanch',
      //       style: TextStyle(
      //         fontSize: 15,
      //       ),
      //     ),
      //     Text(
      //       'Email:',
      //       style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      //     ),
      //     Text(
      //       'moontariq853@gmail.com',
      //       style: TextStyle(
      //         fontSize: 15,
      //       ),
      //     ),
      //     Text(
      //       'Phone Number:',
      //       style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      //     ),
      //     TextField()
      //   ],
      // ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});
  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final DataService _dataService = DataService();

  // late GoogleMapController mapsController;
  String? _fullName;
  String? _username;
  String? _email;
  String? _phoneNumber;
  String? _country;

  // File? image;
  // String name = '';
  final picker = ImagePicker();
  // Future<void> _saveData() async {
  //   final user = {
  //     'id': 1,
  //     'name': name,
  //     'username': username,
  //     'email': email,
  //     'phoneNumber': phoneNumber,
  //     'imagePath': image?.path,
  //   };
  // }

  // Future getImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  @override
  void initState() {
    super.initState();
    _loadUserinfo();
  }

  Future<void> _loadUserinfo() async {
    final userInfo = await _dataService.preferencesService.getUserInfo();
    setState(() {
      _fullName = userInfo['fullName'];
      _username = userInfo['username'];
      _email = userInfo['email'];
      _phoneNumber = userInfo['phoneNumber'];
      _country = userInfo['country'];
    });
  }

  // void _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  // }

  // final _formKey = GlobalKey<FormState>();
  // String name = '', username = '', email = '', phoneNumber = '';
  // File? image;

  @override
  Widget build(BuildContext context) {
    TextStyle userdatastyle = TextStyle(
      fontSize: 16,
      color: isDarkMode ? Colors.white : Colors.black87,
    );
    final profilePicture =
        Provider.of<ProfilePictureProvider>(context).profilePicture;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  profilePicture != null
                      ? CircleAvatar(
                          radius: 85,
                          backgroundImage: MemoryImage(profilePicture),
                        )
                      : const Text('No Profile Picture Selected'),
                  //   GestureDetector(
                  //      onTap: getImage,
                  // child: Obx(() {
                  //   return CircleAvatar(
                  //       radius: 85,
                  //       backgroundColor: Colors.grey,
                  //       backgroundImage:
                  //           userController.profilePicture.value.isNotEmpty
                  //               ? FileImage(image!)
                  //               : const AssetImage('assets/image7.jpg'));
                  // }),
                  // CircleAvatar(
                  //   radius: 85,
                  //
                  //   backgroundImage: image != null
                  //       ? FileImage(image!)
                  //       : const AssetImage('assets/image7.jpg'),
                  //   child: image == null
                  //       ? Text(
                  //           name.isNotEmpty ? name[0] : '',
                  //           style: const TextStyle(fontSize: 40),
                  //         )
                  //       : null,
                  //   //_image != null
                  //   //     ? FileImage(_image!)
                  //   //     : const AssetImage('assets/image7.jpg'),
                  // ),
                  //    ),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Full Name',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_fullName',
                    style: userdatastyle,
                  )
                  //  TextField(
                  //   onTapOutside: (event) {
                  //     FocusScope.of(context).requestFocus(FocusNode());
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter full name ',
                  //     hintStyle: const TextStyle(fontWeight: FontWeight.w200),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  //   onChanged: (text) {
                  //     //   fullName = text;
                  //   },
                  // ),
                  ),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Username',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: SizedBox(width: 400,
                  child: Text(
                    '$_username',
                    style: userdatastyle,
                  )
                  // TextField(
                  //   onTapOutside: (event) {
                  //     FocusScope.of(context).requestFocus(FocusNode());
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter a unique username',
                  //     hintStyle: const TextStyle(fontWeight: FontWeight.w200),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  //   onChanged: (text) {
                  //     //    username = text;
                  //   },
                  // ),
                  //    ),
                  ),
              const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Email',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400)),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  //child: SizedBox(width: 400,
                  child: Text(
                    '$_email',
                    style: userdatastyle,
                  )
                  //  TextField(
                  //   onTapOutside: (event) {
                  //     FocusScope.of(context).requestFocus(FocusNode());
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: 'example@gmail.com',
                  //     hintStyle: const TextStyle(fontWeight: FontWeight.w200),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  //   onChanged: (text) {
                  //     //    email = text;
                  //   },
                  // ),
                  //     ),
                  ),
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: SizedBox(width: 400,
                  child: Text(
                    '$_phoneNumber',
                    style: userdatastyle,
                  )
                  // TextField(
                  //   autocorrect: true,
                  //   keyboardType: TextInputType.phone,
                  //   maxLength: 15,
                  //   onTapOutside: (event) {
                  //     FocusScope.of(context).requestFocus(FocusNode());
                  //   },
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter Phone Number ',
                  //     hintStyle: const TextStyle(fontWeight: FontWeight.w200),
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //         gapPadding: BorderSide.strokeAlignCenter),
                  //   ),
                  //   onChanged: (text) {
                  //     //    phoneNumber = text;
                  //   },
                  // ),
                  //    ),
                  ),
              const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Country',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400)),
                  )),

              ///   SizedBox(
              //  width: 400,
              //  child
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_country',
                    style: userdatastyle,
                  )
                  // TextField(
                  //   autofillHints: const <String>['Pakistan'],
                  //   onTapOutside: (event) {
                  //     FocusScope.of(context).requestFocus(FocusNode());
                  //   },
                  //   autocorrect: true,
                  //   decoration: InputDecoration(
                  //     hintText: 'Enter Country Name',
                  //     hintStyle: const TextStyle(fontWeight: FontWeight.w200),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  //   onChanged: (text) {
                  //     //    country = text;
                  //   },
                  // ),
                  ),
              //  ),
              // SizedBox(
              //   height: 300,
              //   width: 800,
              //   child: GoogleMap(
              //     onMapCreated: (GoogleMapController controller) {
              //       mapsController = controller;
              //     },
              //     initialCameraPosition: const CameraPosition(
              //       target: LatLng(37.7749, -122.4194),
              //       zoom: 10,
              //     ),
              //     markers: {
              //       Marker(
              //         markerId: MarkerId('marker_1'),
              //         position: LatLng(37.7749, -122.4194),
              //         infoWindow: InfoWindow(
              //             title: 'MOON',
              //             snippet: 'HELLO',
              //             onTap: () {
              //               Get.snackbar('title', 'message');
              //             }),
              //       ),
              //     },
              //   ),
              // ),
              ElevatedButton(
                onPressed: () async {
                  // Access the provider here
                  final profilePictureProvider =
                      Provider.of<ProfilePictureProvider>(context,
                          listen: false);

                  await profilePictureProvider.deleteProfilePicture();

                  Get.to(() => const EditInfoScreen());
                },
                //
                //  },
                //  () async {
                //   if (Platform.isAndroid) {
                //     //    _formKey.currentState!.save();
                //     //   await //_saveData();
                //   } else {
                //     _showSnackBar('All fields are required.');
                //   }
                //   // Save the data to the respective columns
                //   // print('Full Name: $fullName');
                //   // print('Username: $username');
                //   // print('Email: $email');
                //   // print('Phone Number: $phoneNumber');
                //   // print('Country: $country');
                // },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width * 0.8, 45),
                  backgroundColor: isDarkMode ? Colors.black : Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                ),
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
