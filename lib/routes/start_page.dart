import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/song_info_pods.dart';
import '../widgets/omni_box.dart';
import 'lyrics_selection_page.dart';

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  ConsumerState<StartPage> createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
  static const _gradient = LinearGradient(
    colors: [Color(0xFFCB356B), Color(0xFFBD3F32)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  void _onConfirmButtonPressed(int songId) {
    ref.read(songIdPod.notifier).update(songId);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LyricsSelectionPage()));
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
                      onSubmit: (res) => _onConfirmButtonPressed(res.songId)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
