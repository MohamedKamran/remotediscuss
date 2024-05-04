import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Discuss | Quadropic'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.person_circle_fill),
            onPressed: () {
              print("object");
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: GNav(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            iconSize: 24,
            gap: 8,
            // tab button ripple color when pressed
            hoverColor: Theme.of(context)
                .colorScheme
                .secondary, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            tabBackgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.05),
            tabActiveBorder: Border.all(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                width: 0.5), // tab button border
            tabBorder: Border.all(color: Colors.transparent, width: 1),
            activeColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              GButton(icon: Icons.home_filled, text: 'Home'),
              GButton(icon: CupertinoIcons.video_camera_solid, text: 'Meets'),
              GButton(icon: CupertinoIcons.calendar, text: 'Schedule'),
              GButton(icon: CupertinoIcons.checkmark_square_fill, text: 'ToDo'),
            ]),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          print("object");
        },
        child: const Text("data"),
      ),
      body: const Center(
        child: Text(
          'Welcome to Remote Discuss | Quadropic',
        ),
      ),
    );
  }
}
