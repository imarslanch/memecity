import 'package:flutter/material.dart';

class MediaLinksDocsScreen extends StatelessWidget {
  const MediaLinksDocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media, Links, and Docs'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Photos'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Videos'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Links'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.document_scanner),
            title: const Text('Documents'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
