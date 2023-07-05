import 'package:flutter/material.dart';

class SingleSongTile extends StatelessWidget {
  final String title;
  const SingleSongTile(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 130,
      child: Card(
        elevation: 5,
        shadowColor: Colors.white,
        color: Color(0xFF282C30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                height: 100,
                width: 100,
                'assets/image20.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
