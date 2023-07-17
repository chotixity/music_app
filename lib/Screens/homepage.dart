import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../provider/music_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<LocalMusic>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Albums',
              style: theme.textTheme.titleSmall,
            ),
          ),
          Flexible(
            child: FutureBuilder(
                future: provider.getAlbums(),
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
                    scrollDirection: Axis.horizontal,
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: 180,
                          width: 130,
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.white,
                            color: const Color(0xFF282C30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: QueryArtworkWidget(
                                    controller: _audioQuery,
                                    id: item.data![index].id,
                                    type: ArtworkType.ALBUM,
                                    nullArtworkWidget: const Icon(
                                      Icons.album,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item.data![index].album,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.clip,
                                  ),
                                  maxLines: 2,
                                ),
                                Text(
                                  ' ${item.data![index].numOfSongs} songs',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Artists',
              style: theme.textTheme.titleSmall,
            ),
          ),
          Flexible(
            child: FutureBuilder(
                future: provider.getArtists(),
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
                    scrollDirection: Axis.horizontal,
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: 180,
                          width: 130,
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.white,
                            color: const Color(0xFF282C30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: QueryArtworkWidget(
                                    controller: _audioQuery,
                                    id: item.data![index].id,
                                    type: ArtworkType.ARTIST,
                                    nullArtworkWidget: const Icon(
                                      Icons.art_track,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item.data![index].artist,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  ' ${item.data![index].numberOfTracks} songs',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
