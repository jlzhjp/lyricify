import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pods/editor_pods.dart';
import '../../widgets/editor_config_page.dart';

final _pageConfigSections = [
  ConfigSection(
      key: 'size',
      description: '尺寸',
      icon: Icons.zoom_in,
      builder: (context) => const PageSizeConfigSection()),
];

class PageConfigPage extends StatefulWidget {
  const PageConfigPage({super.key});

  @override
  State<PageConfigPage> createState() => _PageConfigPageState();
}

class _PageConfigPageState extends State<PageConfigPage> {
  @override
  Widget build(BuildContext context) {
    return EditorConfigPage(sections: _pageConfigSections);
  }
}

class PageSizeConfigSection extends ConsumerWidget {
  const PageSizeConfigSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posterWidth = ref.watch(pageConfigPod.select((pod) => pod.width));
    final notifier = ref.watch(pageConfigPod.notifier);

    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text('宽度: '),
            ),
            DropdownButton(
              value: posterWidth,
              items: const [
                DropdownMenuItem(
                  value: 720,
                  child: Text('720px'),
                ),
                DropdownMenuItem(
                  value: 1080,
                  child: Text('1080px'),
                )
              ],
              onChanged: (value) {
                notifier.update((prev) => prev.copyWith(width: value!));
              },
            )
          ],
        )
      ],
    );
  }
}
