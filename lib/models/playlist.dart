import './song.dart';

import 'package:hive/hive.dart';
part 'playlist.g.dart';

@HiveType(typeId: 0)
class PlayList extends HiveObject {
  @HiveField(0)
  List<Song> songs = [];
  PlayList(this.songs);
}
