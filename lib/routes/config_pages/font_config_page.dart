import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../pods/editor_pods.dart';
import '../../widgets/editor_config_page.dart';

final _fontConfigSections = [
  ConfigSection(
      key: 'automatic',
      description: '自动',
      icon: Icons.auto_mode,
      onEnter: (ref) {
        final notifier = ref.watch(fontConfigPod.notifier);
        notifier.update((prev) => prev.copyWith(autoGenerate: true));
      }),
  ConfigSection(
      key: 'font_size',
      description: '字体大小',
      icon: Icons.colorize,
      onEnter: (ref) {
        final notifier = ref.watch(fontConfigPod.notifier);
        notifier.update((prev) => prev.copyWith(autoGenerate: false));
      },
      builder: ((context) {
        return FadeIn(child: const FontSizeConfigSection());
      })),
];

class FontConfigPage extends StatelessWidget {
  const FontConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(child: EditorConfigPage(sections: _fontConfigSections));
  }
}

class FontSizeConfigSection extends StatefulWidget {
  const FontSizeConfigSection({super.key});

  @override
  State<FontSizeConfigSection> createState() => _FontSizeConfigSectionState();
}

class _FontSizeConfigSectionState extends State<FontSizeConfigSection> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
