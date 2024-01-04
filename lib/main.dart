import 'package:flutter/material.dart';
import 'package:music_app/provider/player.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'navigation/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './Screens/homescreen.dart';
import './models/playlist.dart';
import './provider/music_provider.dart';

late SharedPreferences sharedPrefs;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlayListAdapter());
  Hive.openBox<PlayList>('playlists');
  sharedPrefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<LocalMusic>(
          create: (_) => LocalMusic(sharedPrefs),
        ),
        ListenableProvider<MusicPlayer>(
          create: (_) => MusicPlayer(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(127, 132, 137, 1)),
          textTheme: const TextTheme(
              titleMedium: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              titleSmall: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              bodyMedium: TextStyle(
                color: Colors.white,
                overflow: TextOverflow.fade,
              ),
              bodySmall: TextStyle(color: Colors.white)),
          useMaterial3: true,
        ),
        home: FutureBuilder(
          future: Permission.storage.request(),
          builder: (context, snapshot) {
            if (snapshot.data == PermissionStatus.granted) {
              return const HomeScreen();
            } else {
              return const Scaffold();
            }
          },
        ),
      ),
    );
  }
}
