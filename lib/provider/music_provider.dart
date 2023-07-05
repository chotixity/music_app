import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LocalMusic with ChangeNotifier {
  List _playLists = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Future<void> createPlaylist(String title) async {
    final name = _audioQuery.createPlaylist(title);
    _playLists.add(name);
    print(name);
  }

  List get playLists {
    return [..._playLists];
  }
}
