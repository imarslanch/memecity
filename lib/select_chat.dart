import 'package:flutter/material.dart';

class SelectChat extends StatelessWidget {
  const SelectChat({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('select chat'));
//   }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select contact',
              style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                // Handle search action
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Handle more options
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.group_add),
              ),
              title: const Text('New group'),
              onTap: () {
                // Handle new group action
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person_add),
              ),
              title: const Text('New contact'),
              onTap: () {
                // Handle new contact action
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.groups),
              ),
              title: const Text('New community'),
              onTap: () {
                // Handle new community action
              },
            ),
            const Divider(),
            _contactItem('Moon (You)', 'Message yourself'),
            _contactItem('Abdul Bajwa Member', ''),
            _contactItem('Abdullah Abid', 'G.G.A.D'),
            _contactItem('Abdullah Asif', ''),
            _contactItem('Ahmad',
                'NO LOVE 🚫NO BOYS ❤️ I HATE FRIEND 🚫 Leave me😈 Alone 😈'),
            _contactItem('Ahmed Toor N',
                'All of the life is a dream and dreams are nothing but illustrations...'),
            _contactItem('Ahsan B J', ''),
          ],
        ),
      ),
    );
  }

  ListTile _contactItem(String name, String subtitle) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]),
      ),
      title: Text(name),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
    );
  }
}
