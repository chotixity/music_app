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
                    trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: theme.primaryColor,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      item.data![index].title,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('Share Song'),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.share),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('Add to playlist'),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.playlist_add),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('Delete'),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.delete),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
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
