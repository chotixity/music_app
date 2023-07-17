import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../provider/music_provider.dart';
import '../widgets/icon_button.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<LocalMusic>(context);
    return Column(
      children: [
        const SearchBar(),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: FutureBuilder(
            // Default values:
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              // Display error, if any.
              if (item.hasError) {
                return Text(item.error.toString());
              }
              // Waiting content.
              if (item.data == null) {
                return const CircularProgressIndicator();
              }
              if (item.data!.isEmpty) return const Text("Nothing found!");

              return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: QueryArtworkWidget(
                      controller: _audioQuery,
                      id: item.data![index].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: const Icon(
                        Icons.music_note_sharp,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      item.data![index].title,
                      style: theme.textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      item.data![index].artist ?? "No Artist",
                      style: theme.textTheme.bodyMedium,
                    ),
                    trailing: ValueListenableBuilder<PlayingState>(
                      valueListenable: provider.playingstate,
                      builder: (context, value, __) {
                        switch (value) {
                          case PlayingState.play:
                            return IconButtons(
                              () {
                                provider.play(item.data![index].uri);
                              },
                              Icons.play_arrow,
                            );
                          case PlayingState.pause:
                            return IconButtons(
                              () {
                                provider.pause();
                              },
                              Icons.pause,
                            );
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
