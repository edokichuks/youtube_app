import 'package:flutter/material.dart';

import '../data.dart';

class CustomSilverAppBar extends StatelessWidget {
  const CustomSilverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Image.asset('assets/yt_logo_dark.png'),
            ),
            leadingWidth: 100,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.cast),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                  onPressed: () {},
                  iconSize: 40,
                  icon: CircleAvatar(
                    foregroundImage: NetworkImage(currentUser.profileImageUrl),
                  )),
            ]
          );
  }
}