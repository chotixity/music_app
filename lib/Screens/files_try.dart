import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FilesTry extends StatefulWidget {
  const FilesTry({super.key});

  @override
  State<FilesTry> createState() => _FilesTryState();
}

class _FilesTryState extends State<FilesTry> {
  Directory dir = Directory.systemTemp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: ,
        );
  }
}
