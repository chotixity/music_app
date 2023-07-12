import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/models/playlist.dart';
//import 'package:music_app/Screens/files_try.dart';
import 'package:provider/provider.dart';
//import 'package:on_audio_query/on_audio_query.dart';
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
  void dispose() {
    Hive.close();
    // TODO: implement dispose
    super.dispose();
  }

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
                builder: (context) => LocalMusicScreen(),
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
            //provider.showDirectories();
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
                          provider.createPlaylist(_playlistTitle.text, []);
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
          child: Hive.box<PlayList>('playlists').isEmpty
              ? const Text('You currently have no playlists')
              : ValueListenableBuilder(
                  valueListenable: Hive.box<PlayList>('playlists').listenable(),
                  builder: (context, box, _) {
                    //final playlists = box.values.toList().cast<PlayList>();
                    final titles = box.keys.toList().cast<String>();
                    print(titles);
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        return ListItem(
                          const Icon(
                            Icons.music_note_outlined,
                            color: Colors.white,
                          ),
                          titles[index],
                          '',
                          IconButtons(() {}, Icons.play_circle),
                        );
                      },
                    );
                  },
                ),
        )
      ],
    );
  }
}
