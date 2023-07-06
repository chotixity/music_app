import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../provider/music_provider.dart';
import '../Screens/local_music_screen.dart';
import '../widgets/List_Item.dart';
import '../widgets/icon_button.dart';

class myLibrary extends StatefulWidget {
  const myLibrary({super.key});

  @override
  State<myLibrary> createState() => _myLibraryState();
}

class _myLibraryState extends State<myLibrary> {
  final _playlistTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalMusic>(context);
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
          IconButtons(() {
            provider.files();
          }, Icons.arrow_forward_ios),
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
                          provider.createPlaylist(_playlistTitle.text);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Submit'),
                      )
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
            },
          ),
        )
      ],
    );
  }
}
