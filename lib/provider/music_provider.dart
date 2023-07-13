//import 'dart:io';
import 'package:music_app/models/playlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../models/song.dart';

class LocalMusic with ChangeNotifier {
  LocalMusic(this._prefs);
  final SharedPreferences _prefs;
  final _playListKey = 'playLists';

  List<PlayList> _playLists = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future getAlbums() {
    final albums = _audioQuery.queryAlbums(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    return albums;
  }

  Future createPlaylist(String title, List<Song> songs) async {
    var singlePlayList = PlayList(songs);
    //print(singlePlayList.entries);
    Hive.box<PlayList>('playlists').put(title, singlePlayList);
  }

  void addSongsToPlayList(String title) {
    final index = Hive.box<PlayList>('playlists')
        .keys
        .toList()
        .indexWhere((element) => element == title);
    final playlists = Hive.box<PlayList>('playlists').values.toList();
    var playlist = playlists.elementAt(index);
    //playlist.add();
  }

  void _syncToPreferences() {
    // _prefs.setString(_playListKey, );
  }

  List get playLists {
    return [..._playLists];
  }
}
