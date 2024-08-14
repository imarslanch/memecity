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

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define default text styles if needed
    TextStyle headlineStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black87,
    );
    TextStyle subtitleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: isDarkMode ? Colors.white : Colors.black54,
    );
    TextStyle bodyTextStyle = TextStyle(
      fontSize: 16,
      color: isDarkMode ? Colors.white : Colors.black87,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: headlineStyle,
              ),
              const SizedBox(height: 20),
              Text(
                'Effective Date: August 4,2024',
                style: subtitleStyle,
              ),
              const SizedBox(height: 20),
              Text(
                '1. Introduction\n\n'
                'Welcome to MemeCity. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our app. Please read this policy carefully.\n\n'
                '2. Information Collection\n\n'
                'We collect information about you in various ways, including:\n'
                '   - Personal Data: Such as your name, email address, and contact details.\n'
                '   - Usage Data: Information about how you use our app, such as access times, features used, and interactions.\n'
                '   - Device Information: Details about your device, including model, operating system, and unique identifiers.\n'
                '   - Cookies and Tracking Technologies: We may use cookies, web beacons, and similar technologies to enhance your experience.\n\n'
                '3. Use of Your Information\n\n'
                'We use the information we collect to:\n'
                '   - Provide, operate, and maintain our app.\n'
                '   - Improve, personalize, and expand our app.\n'
                '   - Understand and analyze how you use our app.\n'
                '   - Communicate with you, including sending updates and promotional materials.\n'
                '   - Ensure the security of our app and prevent fraud.\n\n'
                '4. Disclosure of Your Information\n\n'
                'We may disclose your information:\n'
                '   - To comply with legal obligations or respond to legal processes.\n'
                '   - To our service providers who assist us in operating the app.\n'
                '   - In connection with a merger, acquisition, or sale of assets.\n'
                '   - With your consent or at your direction.\n\n'
                '5. Security\n\n'
                'We implement reasonable security measures to protect your information from unauthorized access or disclosure. However, no security system is impenetrable, and we cannot guarantee absolute security.\n\n'
                '6. Your Rights\n\n'
                'You have the right to:\n'
                '   - Access, correct, or delete your personal information.\n'
                '   - Object to or restrict the processing of your personal information.\n'
                '   - Withdraw your consent at any time, where applicable.\n\n'
                '7. Changes to This Privacy Policy\n\n'
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page. You are advised to review this policy periodically for any changes.\n\n'
                '8. Contact Us\n\n'
                'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:\n'
                '   - Email: moontariq853@gmail.com\n'
                '   - Address: Memecity@support\n\n',
                style: bodyTextStyle,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }
}
