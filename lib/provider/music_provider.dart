import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LocalMusic with ChangeNotifier {
  List<Map<String, dynamic>> _playLists = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  void files() async {
    var systemTempDir = Directory.systemTemp.parent.parent;

    await for (var entity
        in systemTempDir.list(recursive: true, followLinks: false)) {
      print(entity.path);
    }
  }

  void createPlaylist(String title) {
    var singlePlayList = {title: []};
    print(singlePlayList.entries);
    return _playLists.add(singlePlayList);
  }

  List get playLists {
    return [..._playLists];
  }
}
