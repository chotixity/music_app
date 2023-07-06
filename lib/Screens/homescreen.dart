import 'package:flutter/material.dart';

import './homepage.dart';
import './library.dart';
import './search.dart';
import '../widgets/icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = .6;
  bool playing = false;
  bool singleloop = false;
  bool shuffle = false;
  bool favorite = false;

  int _selectedindex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Search(),
    const myLibrary(),
  ];

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(
        Icons.home_outlined,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Search',
      icon: Icon(Icons.search_sharp),
    ),
    BottomNavigationBarItem(
      label: 'Library',
      icon: Icon(Icons.layers_sharp),
    ),
  ];

  void _shuffle() {
    setState(() {
      shuffle = !shuffle;
    });
  }

  void _loop() {
    setState(() {
      singleloop = !singleloop;
    });
  }

  void _favorite() {
    setState(() {
      favorite = !favorite;
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  void play() {
    setState(() {
      playing = !playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'good afternoon',
          style: theme.textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFF282C30),
              child: Icon(
                Icons.bolt,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFF282C30),
              child: Icon(
                Icons.grid_view_outlined,
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromRGBO(40, 44, 48, 1),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        child: Center(
          child: _pages.elementAt(_selectedindex),
        ),
      ),
      bottomSheet: Container(
        height: 230,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF353A40),
              Color(0xFF32373D),
              Color(0xFF23282C),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Expanded(
          child: Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset('assets/image20.png'),
                ),
                title: const Text(
                  'Dont forget your Roots - 2021',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                ),
                subtitle: const Text(
                  'six 60',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: IconButtons(
                  () {
                    _favorite();
                  },
                  favorite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Slider(
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                  value: value,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtons(
                    () {
                      _shuffle();
                    },
                    shuffle ? Icons.shuffle : Icons.playlist_play,
                  ),
                  Row(
                    children: [
                      IconButtons(
                        () {},
                        Icons.skip_previous,
                      ),
                      IconButtons(
                        () {
                          play();
                        },
                        playing ? Icons.pause : Icons.play_arrow,
                      ),
                      IconButtons(
                        () {},
                        Icons.skip_next,
                      )
                    ],
                  ),
                  IconButtons(
                    () {
                      _loop();
                    },
                    singleloop ? Icons.repeat_one : Icons.repeat_outlined,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 58,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2F353A),
                        Color(0xFF1C1F22),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    ),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      currentIndex: _selectedindex,
                      onTap: _selectPage,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Colors.transparent,
                      items: _items,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
