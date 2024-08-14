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

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Currently selected language
  String _selectedLanguage = 'English';

  // List of available languages including Urdu
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Urdu'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select Language',
              style: TextStyle(color: Colors.white)),
          backgroundColor: isDarkMode ? Colors.black : Colors.teal,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your language:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    return ListTile(
                      title: Text(
                        language,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      trailing: _selectedLanguage == language
                          ? const Icon(Icons.check, color: Colors.teal)
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language;
                          // Update language in the app (not implemented here)
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
      ),
    );
  }
}
