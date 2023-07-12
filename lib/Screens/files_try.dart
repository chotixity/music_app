import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_manager/file_manager.dart';
import 'package:path_provider/path_provider.dart';

class FilesTry extends StatefulWidget {
  const FilesTry({super.key});

  @override
  State<FilesTry> createState() => _FilesTryState();
}

class _FilesTryState extends State<FilesTry> {
  FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FileManager.getStorageList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<FileSystemEntity> storageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: storageList
                    .map(
                      (e) => ListTile(
                        title: Text(
                          FileManager.basename(e),
                        ),
                        onTap: () {
                          controller.openDirectory(e);
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return const Dialog(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
