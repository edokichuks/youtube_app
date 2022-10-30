import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_ui/data.dart';
import 'package:flutter_youtube_ui/screens/video_screen.dart';
import 'package:miniplayer/miniplayer.dart';

import 'home_screen.dart';

final miniPlaterControllerProvider =
    StateProvider.autoDispose<MiniplayerController>((ref) {
  return MiniplayerController();
});
final selectedVideoProvider = StateProvider<Video?>((ref) => null);

class NavScreen extends StatefulWidget {
  NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  final _screens = [
    HomeScreen(),
    const Scaffold(
      body: Center(child: Text('Explore')),
    ),
    const Scaffold(
      body: Center(child: Text('Add')),
    ),
    const Scaffold(
      body: Center(child: Text('Subscription')),
    ),
    const Scaffold(
      body: Center(child: Text('Library')),
    ),
  ];
  static const double _playerMinHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final selectedVideo = watch(selectedVideoProvider).state;
        final miniPlaterController = watch(miniPlaterControllerProvider).state;

        return Stack(
          children: _screens
              .asMap()
              .map(
                (i, screen) => MapEntry(
                  i,
                  Offstage(
                    offstage: _selectedIndex != i,
                    child: screen,
                  ),
                ),
              )
              .values
              .toList()
            ..add(Offstage(
              offstage: selectedVideo == null,
              child: Miniplayer(
                  controller: miniPlaterController,
                  minHeight: _playerMinHeight,
                  maxHeight: MediaQuery.of(context).size.height,
                  builder: ((height, percentage) {
                    if (selectedVideo == null) {
                      return const SizedBox.shrink();
                    }
                    if (height <= _playerMinHeight + 50.0)
                      return Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  selectedVideo.thumbnailUrl,
                                  height: _playerMinHeight - 4,
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                            child: Text(
                                          selectedVideo.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                        )),
                                        Text(
                                          '${selectedVideo.author.username} * ${selectedVideo.viewCount}}',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.play_arrow)),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read(selectedVideoProvider)
                                          .state = null;
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            const LinearProgressIndicator(
                              value: 0.6,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                            )
                          ],
                        ),
                      );
                    return VideoScreen();
                  })),
            )),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (i) => setState(() {
                _selectedIndex = i;
              }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                activeIcon: Icon(Icons.add_circle),
                label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions_outlined),
                activeIcon: Icon(Icons.subscriptions),
                label: 'Subscription'),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library_outlined),
                activeIcon: Icon(Icons.video_library),
                label: 'video library'),
          ]),
    );
  }
}
