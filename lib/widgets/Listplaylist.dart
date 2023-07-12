import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/List_Item.dart';
import '../provider/music_provider.dart';
import '../widgets/icon_button.dart';

class plays extends StatelessWidget {
  const plays({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalMusic>(context);
    return ListView.builder(
      itemCount: provider.playLists.length,
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
    );
  }
}
