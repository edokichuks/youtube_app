import 'package:flutter/material.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
                      ),
          activeIcon: Icon(Icons.home),
          label: 'Home'

        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.explore_outlined,
            
          ),
          activeIcon: Icon(Icons.explore),
          label: 'Explore'

        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle_outlined,
            
          ),
          activeIcon: Icon(Icons.add_circle),
          label: 'Add'

        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.subscriptions_outlined,
            
          ),
          activeIcon: Icon(Icons.subscriptions),
          label: 'Subscription'

        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.video_library,
            
          ),
          activeIcon: Icon(Icons.video_library_outlined),
          label: 'video library'

        ),
      ]),
    );
  }
}
