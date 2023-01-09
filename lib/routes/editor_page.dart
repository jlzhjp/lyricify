import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyricify/widgets/mini_tab_view.dart';

import '../providers/editor_pods.dart';
import '../widgets/poster.dart';
import 'editor_pages/background_config_page.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  Widget _buildPage(EditorTab tab, BuildContext context) {
    switch (tab) {
      case EditorTab.background:
        return const BackgroundConfigPage();
      case EditorTab.text:
        return Container();
      default:
        return Container();
    }
  }

  Widget _buildBottomBar(BuildContext context, WidgetRef ref, Widget? child) {
    return MiniTabView(
        tabs: EditorTab.values,
        pageBuilder: _buildPage,
        itemBuilder: (tab, context) => Text(tab.description));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('编辑'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
                child: Center(
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Poster(),
                ),
              ),
            )),
            Consumer(builder: _buildBottomBar)
          ],
        ));
  }
}
