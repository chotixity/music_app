//import 'dart:io';
import 'package:music_app/models/playlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../models/song.dart';
import 'package:just_audio/just_audio.dart';

enum PlayingState {
  play,
  pause,
}

enum PlayingMode {
  order,
  loop,
}

enum ListMode {
  shuffle,
  list,
}

class LocalMusic with ChangeNotifier {
  LocalMusic(this._prefs) {
    _init();
  }

  final SharedPreferences _prefs;
  final _playListKey = 'playLists';

  final List<PlayList> _playLists = [];
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

  Future getSongs() {
    final songs = _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    return songs;
  }

  Future getArtists() {
    final artists = _audioQuery.queryArtists(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    return artists;
  }

  Future createPlaylist(String title, List<Song> songs) async {
    var singlePlayList = PlayList(songs);
    //print(singlePlayList.entries);
    Hive.box<PlayList>('playlists').put(title, singlePlayList);
    notifyListeners();
  }

  void addSongsToPlayList(String title) {
    final index = Hive.box<PlayList>('playlists')
        .keys
        .toList()
        .indexWhere((element) => element == title);
    final playlist = Hive.box<PlayList>('playlists').values.toList()
      ..elementAt(index);
    // print(playlist);
    //playlist.add();
  }

  void _syncToPreferences() {
    // _prefs.setString(_playListKey, );
  }

  List get playLists {
    return [..._playLists];
  }

  //Audio Player section
  final _audioPlayer = AudioPlayer();
  final playingstate = ValueNotifier(PlayingState.play);

  void _init() async {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;

      if (isPlaying) {
        playingstate.value = PlayingState.pause;
      } else {
        playingstate.value = PlayingState.play;
      }
    });
  }

  void play(String? uri) {
    _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }
}
