import 'package:flutter/material.dart';

class Song {
  final String title;
  final String artist;
  final double length;
  final Image thumbnail;
  bool playing = false;
  bool favorite = false;

  Song({
    required this.playing,
    required this.favorite,
    required this.title,
    required this.artist,
    required this.length,
    required this.thumbnail,
  });
}
