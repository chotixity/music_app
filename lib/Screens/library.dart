import 'package:flutter/material.dart';
import 'package:music_app/Screens/local_music_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/List_Item.dart';
import '../widgets/icon_button.dart';

class myLibrary extends StatefulWidget {
  const myLibrary({super.key});

  @override
  State<myLibrary> createState() => _myLibraryState();
}

class _myLibraryState extends State<myLibrary> {
  final _playlistTitle = TextEditingController();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _hasPermission = false;

  @override
  void initState() {
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();
    // TODO: implement initState
    super.initState();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      //mainAxisAlignment: MainAxisAlignment.,
      children: [
        ListItem(
          const Icon(
            Icons.storage,
            color: Colors.white,
          ),
          'Local Songs',
          'Play songs from your local storage',
          IconButtons(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LocalMusicScreen(),
              ),
            );
          }, Icons.arrow_forward_ios),
        ),
        const SizedBox(
          height: 10,
        ),
        ListItem(
          const Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          'Favorites',
          '',
          IconButtons(() {}, Icons.arrow_forward_ios),
        ),
        const SizedBox(
          height: 10,
        ),
        ListItem(
          const Icon(
            Icons.add_circle_outline_sharp,
            color: Colors.white,
          ),
          'Add New Playlist',
          '',
          IconButtons(
            () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Enter Playlist Title'),
                    content: TextField(
                      controller: _playlistTitle,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            _audioQuery.createPlaylist(_playlistTitle.text);
                          },
                          child: const Text('Submit'))
                    ],
                  );
                },
              );
            },
            Icons.arrow_forward_ios,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'My playlists',
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListItem(
                  const Icon(
                    Icons.music_note_outlined,
                    color: Colors.white,
                  ),
                  'Title',
                  '',
                  IconButtons(() {}, Icons.play_circle),
                );
              }),
        )
      ],
    );
  }
}
