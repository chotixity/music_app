import 'package:flutter/material.dart';

import '../widgets/single_song_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Recently Played',
              style: theme.textTheme.titleSmall,
            ),
          ),
          const Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SingleSongTile('mega Hit mix'),
                  SingleSongTile('mega Hit mix'),
                  SingleSongTile('mega Hit mix'),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'To get you started',
              style: theme.textTheme.titleSmall,
            ),
          ),
          const Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SingleSongTile('mega Hit mix'),
                  SingleSongTile('mega Hit mix'),
                  SingleSongTile('mega Hit mix'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
