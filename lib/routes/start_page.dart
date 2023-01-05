import 'package:flutter/material.dart';
import 'package:lyricify/routes/lyrics_selection_page.dart';
import '../widgets/omni_box.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  static const _gradient = LinearGradient(
    colors: [
      Color(0xFFCB356B),
      Color(0xFFBD3F32),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  void _onConfirmButtonPressed(BuildContext context, int songId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LyricsSelectionPage(songId: songId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _gradient),
        child: Center(
          child: IntrinsicHeight(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Lyricify",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "VarelaRound",
                          fontSize: 60,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Omnibox(
                      onSubmit: (res) =>
                          _onConfirmButtonPressed(context, res.songId)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
