import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/mini_tab_view.dart';
import '../widgets/poster.dart';
import 'config_pages/background_config_page.dart';
import 'config_pages/font_config_page.dart';
import 'config_pages/page_config_page.dart';

enum EditorTab {
  layout(icon: Icons.layers, description: '排版'),
  text(icon: Icons.text_format, description: "文本"),
  background(icon: Icons.image, description: "背景"),
  decorations(icon: Icons.border_all, description: '装饰');

  final IconData icon;
  final String description;
  const EditorTab({required this.icon, required this.description});
}

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  Widget _buildPage(EditorTab tab, BuildContext context) {
    switch (tab) {
      case EditorTab.layout:
        return const PageConfigPage();
      case EditorTab.background:
        return const BackgroundConfigPage();
      case EditorTab.text:
        return const FontConfigPage();
      default:
        return Container();
    }
  }

  Widget _buildBottomBar(BuildContext context, WidgetRef ref, Widget? child) {
    final textTheme = Theme.of(context).textTheme;
    return MiniTabView(
        tabs: EditorTab.values,
        pageBuilder: _buildPage,
        itemBuilder: (tab, context) =>
            Text(tab.description, style: textTheme.labelLarge));
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
        body: SafeArea(
          child: Column(
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
                ),
              ),
              Consumer(builder: _buildBottomBar)
            ],
          ),
        ));
  }
}
