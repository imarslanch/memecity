import 'dart:io';

import 'package:memecity/navigation_bar_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchiveScreen extends StatelessWidget {
  final List<Post> posts;
  final ValueChanged<Post> onUnarchive;

  const ArchiveScreen(
      {super.key, required this.posts, required this.onUnarchive});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Archived Posts',
          style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
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
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: post.text != null ? Text(post.text!) : null,
              leading: post.imagePath != null
                  ? Image.file(
                      File(post.imagePath!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : post.videoPath != null
                      ? Icon(Icons.video_library)
                      : null,
              trailing: IconButton(
                icon: Icon(Icons.unarchive),
                onPressed: () {
                  onUnarchive(post);
                },
              ),
            ),
          );
        },
      ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }
}
